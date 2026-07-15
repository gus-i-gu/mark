import { createHash } from "node:crypto";
import type { FastifyRequest } from "fastify";
import {
  createLocalJWKSet,
  decodeProtectedHeader,
  errors,
  jwtVerify,
  type JWK,
  type JWTPayload,
} from "jose";
import {
  HostedAuthError,
  type Clock,
  type ExternalPrincipal,
  type PrincipalVerifier,
} from "./hosted_contracts.js";

export type JwtVerifierOptions = {
  issuer: string;
  audience: string;
  jwksUri: string;
  clock: Clock;
  skewSeconds?: number;
  timeoutMs?: number;
  cacheMaxAgeMs?: number;
  staleIfErrorMs?: number;
  cooldownMs?: number;
  unknownKidCooldownMs?: number;
  maxTokenBytes?: number;
  maxJwksBytes?: number;
  fetchJwks?: typeof fetch;
};

export class Auth0JwtVerifier implements PrincipalVerifier {
  private readonly jwks: BoundedJwksSource;
  private readonly maxTokenBytes: number;

  constructor(private readonly options: JwtVerifierOptions) {
    this.jwks = new BoundedJwksSource({
      uri: options.jwksUri,
      issuer: options.issuer,
      timeoutMs: options.timeoutMs ?? 1500,
      cacheMaxAgeMs: options.cacheMaxAgeMs ?? 300000,
      staleIfErrorMs: options.staleIfErrorMs ?? 600000,
      cooldownMs: options.cooldownMs ?? 1000,
      unknownKidCooldownMs: options.unknownKidCooldownMs ?? 1000,
      maxBytes: options.maxJwksBytes ?? 65536,
      clock: options.clock,
      fetchJwks: options.fetchJwks ?? fetch,
    });
    this.maxTokenBytes = options.maxTokenBytes ?? 8192;
  }

  async verify(request: FastifyRequest): Promise<ExternalPrincipal> {
    const token = bearer(request.headers.authorization);
    if (Buffer.byteLength(token, "utf8") > this.maxTokenBytes) {
      throw new HostedAuthError("token-rejected");
    }
    try {
      const header = decodeProtectedHeader(token);
      if (header.alg !== "RS256" || typeof header.kid !== "string") {
        throw new HostedAuthError("token-rejected");
      }
      const verified = await jwtVerify(
        token,
        (header, jwt) => this.jwks.getKey(header, jwt),
        {
          issuer: this.options.issuer,
          audience: this.options.audience,
          algorithms: ["RS256"],
          clockTolerance: this.options.skewSeconds ?? 30,
          currentDate: this.options.clock.now(),
        },
      );
      const subject = validSubject(verified.payload);
      return {
        issuer: this.options.issuer,
        subject,
        audience: this.options.audience,
        expiresAt: expiry(verified.payload),
      };
    } catch (error) {
      if (error instanceof HostedAuthError) throw error;
      if (error instanceof errors.JOSEError || error instanceof Error) {
        throw new HostedAuthError("token-rejected");
      }
      throw new HostedAuthError("token-rejected");
    }
  }
}

type BoundedJwksOptions = {
  uri: string;
  issuer: string;
  timeoutMs: number;
  cacheMaxAgeMs: number;
  staleIfErrorMs: number;
  cooldownMs: number;
  unknownKidCooldownMs: number;
  maxBytes: number;
  clock: Clock;
  fetchJwks: typeof fetch;
};

class BoundedJwksSource {
  private local: ReturnType<typeof createLocalJWKSet> | null = null;
  private freshUntil = 0;
  private staleUntil = 0;
  private revision = "";
  private kids = new Set<string>();
  private nextRefreshAfter = 0;
  private negativeKidUntil = new Map<string, number>();
  private refreshPromise: Promise<
    "changed" | "unchanged" | "stale-retained"
  > | null = null;
  private readonly uri: URL;

  constructor(private readonly options: BoundedJwksOptions) {
    this.uri = boundedUri(options.uri, options.issuer);
  }

  async getKey(
    header: Parameters<ReturnType<typeof createLocalJWKSet>>[0],
    token: Parameters<ReturnType<typeof createLocalJWKSet>>[1],
  ) {
    const now = this.options.clock.now().getTime();
    const kid = typeof header?.kid === "string" ? header.kid : "";
    if (!this.local || now >= this.freshUntil) {
      await this.refresh();
    }
    try {
      return await this.local!(header, token);
    } catch (error) {
      if (!(error instanceof errors.JWKSNoMatchingKey)) throw error;
      if (kid && now < (this.negativeKidUntil.get(kid) ?? 0)) {
        throw error;
      }
      const outcome = await this.refresh();
      if (kid && outcome !== "changed") {
        this.negativeKidUntil.set(
          kid,
          this.options.clock.now().getTime() +
            this.options.unknownKidCooldownMs,
        );
      } else if (kid && this.hasKid(kid)) {
        this.negativeKidUntil.delete(kid);
      }
      return this.local!(header, token);
    }
  }

  private async refresh(): Promise<"changed" | "unchanged" | "stale-retained"> {
    const now = this.options.clock.now().getTime();
    if (this.refreshPromise) return this.refreshPromise;
    if (now < this.nextRefreshAfter) {
      if (this.local && now < this.staleUntil) return "stale-retained";
      throw new HostedAuthError("token-rejected");
    }
    this.refreshPromise = this.fetchAndCache()
      .catch((error) => {
        this.nextRefreshAfter = now + this.options.cooldownMs;
        if (this.local && now < this.staleUntil)
          return "stale-retained" as const;
        throw error;
      })
      .finally(() => {
        this.refreshPromise = null;
      });
    return this.refreshPromise;
  }

  private async fetchAndCache(): Promise<"changed" | "unchanged"> {
    const controller = new AbortController();
    const timeout = setTimeout(
      () => controller.abort(),
      this.options.timeoutMs,
    );
    try {
      const response = await this.options.fetchJwks(this.uri, {
        redirect: "manual",
        signal: controller.signal,
      });
      if (response.status < 200 || response.status >= 300) {
        throw new HostedAuthError("token-rejected");
      }
      const text = await boundedText(response, this.options.maxBytes);
      const parsed = JSON.parse(text) as unknown;
      const jwks = validateJwks(parsed);
      const revision = keySetRevision(jwks.keys);
      const outcome = revision === this.revision ? "unchanged" : "changed";
      this.local = createLocalJWKSet(jwks);
      this.revision = revision;
      this.kids = new Set(jwks.keys.map((key) => key.kid as string));
      const now = this.options.clock.now().getTime();
      this.freshUntil = now + this.options.cacheMaxAgeMs;
      this.staleUntil = now + this.options.staleIfErrorMs;
      this.nextRefreshAfter = 0;
      if (outcome === "changed") {
        for (const kid of this.negativeKidUntil.keys()) {
          if (this.hasKid(kid)) this.negativeKidUntil.delete(kid);
        }
      }
      return outcome;
    } catch (error) {
      if (error instanceof HostedAuthError) throw error;
      throw new HostedAuthError("token-rejected");
    } finally {
      clearTimeout(timeout);
    }
  }

  private hasKid(kid: string) {
    return this.kids.has(kid);
  }
}

function boundedUri(value: string, issuerValue: string): URL {
  const uri = new URL(value);
  const issuer = new URL(issuerValue);
  if (!["https:", "http:"].includes(uri.protocol)) {
    throw new HostedAuthError("token-rejected");
  }
  if (uri.username || uri.password || uri.hash) {
    throw new HostedAuthError("token-rejected");
  }
  if (
    issuer.protocol === "https:" &&
    (uri.protocol !== "https:" || uri.origin !== issuer.origin)
  ) {
    throw new HostedAuthError("token-rejected");
  }
  return uri;
}

async function boundedText(response: Response, maxBytes: number) {
  if (!response.body) return "";
  const reader = response.body.getReader();
  const chunks: Uint8Array[] = [];
  let total = 0;
  for (;;) {
    const { done, value } = await reader.read();
    if (done) break;
    total += value.byteLength;
    if (total > maxBytes) {
      await reader.cancel().catch(() => undefined);
      throw new HostedAuthError("token-rejected");
    }
    chunks.push(value);
  }
  return Buffer.concat(chunks).toString("utf8");
}

function validateJwks(value: unknown): { keys: JWK[] } {
  if (
    !value ||
    typeof value !== "object" ||
    !Array.isArray((value as { keys?: unknown }).keys)
  ) {
    throw new HostedAuthError("token-rejected");
  }
  const seen = new Map<string, string>();
  const keys = (value as { keys: JWK[] }).keys;
  if (keys.length < 1 || keys.length > 16) {
    throw new HostedAuthError("token-rejected");
  }
  for (const key of keys) {
    if (!key || typeof key !== "object") {
      throw new HostedAuthError("token-rejected");
    }
    if (
      typeof key.kid !== "string" ||
      key.kid.length < 1 ||
      key.kid.length > 128
    ) {
      throw new HostedAuthError("token-rejected");
    }
    const fingerprint = JSON.stringify(key);
    const previous = seen.get(key.kid);
    if (previous !== undefined) {
      throw new HostedAuthError("token-rejected");
    }
    seen.set(key.kid, fingerprint);
  }
  return { keys };
}

function keySetRevision(keys: JWK[]): string {
  const normalized = keys
    .map((key) => canonicalJson(key))
    .sort()
    .join("\n");
  return createHash("sha256").update(normalized).digest("hex");
}

function canonicalJson(value: unknown): string {
  if (Array.isArray(value)) {
    return `[${value.map(canonicalJson).join(",")}]`;
  }
  if (value && typeof value === "object") {
    const entries = Object.entries(value as Record<string, unknown>)
      .filter(([, item]) => item !== undefined)
      .sort(([left], [right]) => left.localeCompare(right));
    return `{${entries
      .map(([key, item]) => `${JSON.stringify(key)}:${canonicalJson(item)}`)
      .join(",")}}`;
  }
  return JSON.stringify(value);
}

function bearer(value: string | string[] | undefined): string {
  if (Array.isArray(value))
    throw new HostedAuthError("authentication-required");
  if (!value) throw new HostedAuthError("authentication-required");
  const parts = value.trim().split(/\s+/);
  if (parts.length !== 2 || parts[0] !== "Bearer" || !parts[1]) {
    throw new HostedAuthError("authentication-required");
  }
  return parts[1];
}

function validSubject(payload: JWTPayload): string {
  if (typeof payload.sub !== "string")
    throw new HostedAuthError("token-rejected");
  if (payload.sub.length < 1 || payload.sub.length > 256) {
    throw new HostedAuthError("token-rejected");
  }
  return payload.sub;
}

function expiry(payload: JWTPayload): Date {
  if (typeof payload.exp !== "number")
    throw new HostedAuthError("token-rejected");
  return new Date(payload.exp * 1000);
}
