import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import test from "node:test";
import Fastify from "fastify";
import { exportJWK, generateKeyPair, SignJWT } from "jose";
import { parseHostedConfig } from "../src/application/hosted_config.js";
import { Auth0JwtVerifier } from "../src/application/jwt_verifier.js";
import { HostedAuthError } from "../src/application/hosted_contracts.js";

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

test("Auth0JwtVerifier rejects missing bearer and oversized token", async () => {
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
    verifier.verify(request(await fixture.token())),
    HostedAuthError,
  );
  await fixture.close();
});

async function jwtFixture() {
  const now = new Date("2026-07-15T00:00:00.000Z");
  const pair = await generateKeyPair("RS256", { extractable: true });
  const jwk = await exportJWK(pair.publicKey);
  jwk.kid = "kid-1";
  jwk.alg = "RS256";
  jwk.use = "sig";
  const app = Fastify({ logger: false });
  app.get("/.well-known/jwks.json", async () => ({ keys: [jwk] }));
  await app.listen({ host: "127.0.0.1", port: 0 });
  const port = (app.server.address() as { port: number }).port;
  const issuer = `http://127.0.0.1:${port}/`;
  const audience = "markei-api";
  return {
    now,
    issuer,
    audience,
    jwksUri: `${issuer}.well-known/jwks.json`,
    close: () => app.close(),
    token: (options: { audience?: string } = {}) =>
      new SignJWT({})
        .setProtectedHeader({ alg: "RS256", kid: "kid-1" })
        .setIssuer(issuer)
        .setAudience(options.audience ?? audience)
        .setSubject("auth0|subject")
        .setIssuedAt(Math.floor(now.getTime() / 1000))
        .setExpirationTime(Math.floor(now.getTime() / 1000) + 600)
        .sign(pair.privateKey),
  };
}

function request(token: string) {
  return { headers: { authorization: `Bearer ${token}` } } as never;
}
