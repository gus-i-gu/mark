import type { FastifyRequest } from "fastify";
import { createRemoteJWKSet, errors, jwtVerify, type JWTPayload } from "jose";
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
  cooldownMs?: number;
  maxTokenBytes?: number;
};

export class Auth0JwtVerifier implements PrincipalVerifier {
  private readonly jwks: ReturnType<typeof createRemoteJWKSet>;
  private readonly maxTokenBytes: number;

  constructor(private readonly options: JwtVerifierOptions) {
    const uri = new URL(options.jwksUri);
    this.jwks = createRemoteJWKSet(uri, {
      timeoutDuration: options.timeoutMs ?? 1500,
      cacheMaxAge: options.cacheMaxAgeMs ?? 300000,
      cooldownDuration: options.cooldownMs ?? 1000,
    });
    this.maxTokenBytes = options.maxTokenBytes ?? 8192;
  }

  async verify(request: FastifyRequest): Promise<ExternalPrincipal> {
    const token = bearer(request.headers.authorization);
    if (Buffer.byteLength(token, "utf8") > this.maxTokenBytes) {
      throw new HostedAuthError("token-rejected");
    }
    try {
      const verified = await jwtVerify(token, this.jwks, {
        issuer: this.options.issuer,
        audience: this.options.audience,
        algorithms: ["RS256"],
        clockTolerance: this.options.skewSeconds ?? 30,
        currentDate: this.options.clock.now(),
      });
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

function bearer(value: string | undefined): string {
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
