import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import test from "node:test";
import Fastify from "fastify";
import { exportJWK, generateKeyPair, SignJWT } from "jose";
import { parseHostedConfig } from "../src/application/hosted_config.js";
import { Auth0JwtVerifier } from "../src/application/jwt_verifier.js";
import { HostedAuthError } from "../src/application/hosted_contracts.js";
import { buildApp, ROUTE_AUTHORIZATION_DESCRIPTORS } from "../src/http/app.js";

test("hosted config requires closed production keys without values", () => {
  assert.throws(
    () => parseHostedConfig({ NODE_ENV: "production" }),
    /PORT is required/,
  );
  assert.throws(
    () =>
      parseHostedConfig({
        NODE_ENV: "production",
        PORT: "3000",
        MARKEI_SYNC_DATABASE_URL: "postgres://runtime",
        MARKEI_AUTH_ISSUER: "http://issuer.example/",
        MARKEI_AUTH_AUDIENCE: "api",
        MARKEI_PUBLIC_ORIGIN: "https://app.example",
        MARKEI_LOG_LEVEL: "info",
      }),
    /MARKEI_AUTH_ISSUER must use HTTPS/,
  );
  assert.doesNotThrow(() =>
    parseHostedConfig(
      {
        NODE_ENV: "test",
        PORT: "3000",
        MARKEI_SYNC_DATABASE_URL: "postgres://runtime",
        MARKEI_AUTH_ISSUER: "http://127.0.0.1:9999/",
        MARKEI_AUTH_AUDIENCE: "api",
        MARKEI_PUBLIC_ORIGIN: "http://127.0.0.1:3000",
        MARKEI_LOG_LEVEL: "info",
      },
      { allowLoopbackHttp: true },
    ),
  );
});

test("hosted production entrypoint has no fixture-auth import", () => {
  const source = readFileSync("src/hosted.ts", "utf8");
  assert.equal(source.includes("FixtureAuthVerifier"), false);
});

test("Auth0JwtVerifier accepts RS256 access token and rejects wrong audience", async () => {
  const fixture = await jwtFixture();
  const verifier = new Auth0JwtVerifier({
    issuer: fixture.issuer,
    audience: fixture.audience,
    jwksUri: fixture.jwksUri,
    clock: { now: () => fixture.now },
  });
  const principal = await verifier.verify(request(await fixture.token()));
  assert.equal(principal.subject, "auth0|subject");
  await assert.rejects(
    verifier.verify(request(await fixture.token({ audience: "wrong" }))),
    HostedAuthError,
  );
  await fixture.close();
});

test("Auth0JwtVerifier rejects malformed bearer input", async () => {
  const fixture = await jwtFixture();
  const verifier = new Auth0JwtVerifier({
    issuer: fixture.issuer,
    audience: fixture.audience,
    jwksUri: fixture.jwksUri,
    clock: { now: () => fixture.now },
    maxTokenBytes: 8,
  });
  await assert.rejects(
    verifier.verify({ headers: {} } as never),
    HostedAuthError,
  );
  await assert.rejects(
    verifier.verify({
      headers: { authorization: ["Bearer a", "Bearer b"] },
    } as never),
    HostedAuthError,
  );
  await assert.rejects(
    verifier.verify({ headers: { authorization: "Basic abc" } } as never),
    HostedAuthError,
  );
  await assert.rejects(
    verifier.verify({ headers: { authorization: "Bearer " } } as never),
    HostedAuthError,
  );
  await assert.rejects(
    verifier.verify(request(await fixture.token())),
    HostedAuthError,
  );
  await fixture.close();
});

for (const jwtCase of [
  {
    name: "wrong issuer",
    token: (fixture: Awaited<ReturnType<typeof jwtFixture>>) =>
      fixture.token({ issuer: "https://wrong.example/" }),
  },
  {
    name: "wrong algorithm",
    token: async () => compactToken({ alg: "HS256", kid: "kid-1" }),
  },
  {
    name: "expired token",
    token: (fixture: Awaited<ReturnType<typeof jwtFixture>>) =>
      fixture.token({ expiresInSeconds: -60 }),
  },
  {
    name: "not-yet-valid token",
    token: (fixture: Awaited<ReturnType<typeof jwtFixture>>) =>
      fixture.token({ notBeforeSeconds: 120 }),
  },
  {
    name: "missing subject",
    token: (fixture: Awaited<ReturnType<typeof jwtFixture>>) =>
      fixture.token({ subject: null }),
  },
  {
    name: "missing kid",
    token: (fixture: Awaited<ReturnType<typeof jwtFixture>>) =>
      fixture.token({ kid: null }),
  },
  {
    name: "unknown kid",
    token: (fixture: Awaited<ReturnType<typeof jwtFixture>>) =>
      fixture.token({ kid: "unknown" }),
  },
  {
    name: "invalid signature",
    token: (fixture: Awaited<ReturnType<typeof jwtFixture>>) =>
      fixture.invalidSignatureToken(),
  },
]) {
  test(`Auth0JwtVerifier rejects ${jwtCase.name}`, async () => {
    const fixture = await jwtFixture();
    try {
      await assert.rejects(
        newVerifier(fixture).verify(request(await jwtCase.token(fixture))),
        HostedAuthError,
      );
    } finally {
      await fixture.close();
    }
  });
}

test("Auth0JwtVerifier caches known keys and fails closed for uncached outage", async () => {
  const fixture = await jwtFixture();
  const verifier = new Auth0JwtVerifier({
    issuer: fixture.issuer,
    audience: fixture.audience,
    jwksUri: fixture.jwksUri,
    clock: { now: () => fixture.now },
    cacheMaxAgeMs: 60000,
  });
  const known = await fixture.token();
  await verifier.verify(request(known));
  await fixture.close();
  assert.equal(
    (await verifier.verify(request(known))).subject,
    "auth0|subject",
  );
  await assert.rejects(
    verifier.verify(request(await fixture.token({ kid: "uncached" }))),
    HostedAuthError,
  );
});

test("Auth0JwtVerifier rejects malformed, oversized, redirected and conflicting JWKS", async () => {
  const fixture = await jwtFixture();
  await fixture.setJwksBody("not-json");
  await assert.rejects(
    newVerifier(fixture).verify(request(await fixture.token())),
    HostedAuthError,
  );
  await fixture.setJwksBody({
    keys: [fixture.publicJwk, { ...fixture.publicJwk, n: "conflict" }],
  });
  await assert.rejects(
    newVerifier(fixture).verify(request(await fixture.token())),
    HostedAuthError,
  );
  await fixture.setJwksBody({ keys: [fixture.publicJwk] });
  await assert.rejects(
    newVerifier(fixture, { maxJwksBytes: 8 }).verify(
      request(await fixture.token()),
    ),
    HostedAuthError,
  );
  await fixture.redirectJwks();
  await assert.rejects(
    newVerifier(fixture).verify(request(await fixture.token())),
    HostedAuthError,
  );
  await fixture.close();
});

test("Auth0JwtVerifier coalesces parallel refresh for one unknown key", async () => {
  const fixture = await jwtFixture();
  let fetchCount = 0;
  const verifier = newVerifier(fixture, {
    fetchJwks: async (input, init) => {
      fetchCount++;
      await new Promise((resolve) => setTimeout(resolve, 20));
      return fetch(input, init);
    },
  });
  await Promise.all([
    verifier.verify(request(await fixture.token())),
    verifier.verify(request(await fixture.token())),
    verifier.verify(request(await fixture.token())),
  ]);
  assert.equal(fetchCount, 1);
  await fixture.close();
});

test("protected route policy inventory covers hosted sync and recovery routes", () => {
  const operations = ROUTE_AUTHORIZATION_DESCRIPTORS.map(
    (policy) => policy.operation,
  ).sort();
  assert.deepEqual(operations, [
    "acknowledgement",
    "capabilities",
    "complete-rebootstrap",
    "device-revoke",
    "device-status",
    "download-events",
    "download-rebootstrap-chunk",
    "enroll-device",
    "identity-resolution",
    "query-enrollment",
    "query-rebootstrap",
    "start-rebootstrap",
    "upload-submission",
  ]);
});

test("actual route inventory rejects an injected unclassified route", () => {
  assert.throws(
    () =>
      buildApp({
        authorization: { kind: "disabled" },
        registerUnclassifiedRouteForTest: (app) => {
          app.get("/v1/unclassified", async () => ({ ok: true }));
        },
      }),
    /actual route authorization inventory mismatch/,
  );
});

async function jwtFixture() {
  const now = new Date("2026-07-15T00:00:00.000Z");
  const pair = await generateKeyPair("RS256", { extractable: true });
  const jwk = await exportJWK(pair.publicKey);
  jwk.kid = "kid-1";
  jwk.alg = "RS256";
  jwk.use = "sig";
  let jwksBody: unknown = { keys: [jwk] };
  let redirect = false;
  const app = Fastify({ logger: false });
  app.get("/.well-known/jwks.json", async (_request, reply) => {
    if (redirect) return reply.redirect("/elsewhere");
    if (typeof jwksBody === "string")
      return reply.type("application/json").send(jwksBody);
    return jwksBody;
  });
  await app.listen({ host: "127.0.0.1", port: 0 });
  const port = (app.server.address() as { port: number }).port;
  const issuer = `http://127.0.0.1:${port}/`;
  const audience = "markei-api";
  return {
    now,
    issuer,
    audience,
    publicJwk: jwk,
    jwksUri: `${issuer}.well-known/jwks.json`,
    setJwksBody: (body: unknown) => {
      jwksBody = body;
    },
    redirectJwks: () => {
      redirect = true;
    },
    close: () => app.close(),
    token: (
      options: {
        audience?: string;
        issuer?: string;
        subject?: string | null;
        kid?: string | null;
        expiresInSeconds?: number;
        notBeforeSeconds?: number;
      } = {},
    ) => {
      let jwt = new SignJWT({})
        .setProtectedHeader({
          alg: "RS256",
          ...(options.kid === null ? {} : { kid: options.kid ?? "kid-1" }),
        })
        .setIssuer(options.issuer ?? issuer)
        .setAudience(options.audience ?? audience);
      if (options.subject !== null) {
        jwt = jwt.setSubject(options.subject ?? "auth0|subject");
      }
      return jwt
        .setIssuedAt(Math.floor(now.getTime() / 1000))
        .setExpirationTime(
          Math.floor(now.getTime() / 1000) + (options.expiresInSeconds ?? 600),
        )
        .setNotBefore(
          Math.floor(now.getTime() / 1000) + (options.notBeforeSeconds ?? -1),
        )
        .sign(pair.privateKey);
    },
    invalidSignatureToken: async () => {
      const other = await generateKeyPair("RS256", { extractable: true });
      return new SignJWT({})
        .setProtectedHeader({ alg: "RS256", kid: "kid-1" })
        .setIssuer(issuer)
        .setAudience(audience)
        .setSubject("auth0|subject")
        .setIssuedAt(Math.floor(now.getTime() / 1000))
        .setExpirationTime(Math.floor(now.getTime() / 1000) + 600)
        .sign(other.privateKey);
    },
  };
}

function newVerifier(
  fixture: Awaited<ReturnType<typeof jwtFixture>>,
  options: Partial<ConstructorParameters<typeof Auth0JwtVerifier>[0]> = {},
) {
  return new Auth0JwtVerifier({
    issuer: fixture.issuer,
    audience: fixture.audience,
    jwksUri: fixture.jwksUri,
    clock: { now: () => fixture.now },
    ...options,
  });
}

function request(token: string) {
  return { headers: { authorization: `Bearer ${token}` } } as never;
}

function compactToken(header: Record<string, unknown>) {
  return `${base64Url(JSON.stringify(header))}.${base64Url("{}")}.signature`;
}

function base64Url(value: string) {
  return Buffer.from(value)
    .toString("base64")
    .replaceAll("+", "-")
    .replaceAll("/", "_")
    .replaceAll("=", "");
}
