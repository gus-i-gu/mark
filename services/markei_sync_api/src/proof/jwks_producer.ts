import assert from "node:assert/strict";
import Fastify from "fastify";
import { exportJWK, generateKeyPair, SignJWT } from "jose";
import { Auth0JwtVerifier } from "../application/jwt_verifier.js";
import { HostedAuthError } from "../application/hosted_contracts.js";
import { makeProducerResult } from "./producer.js";
import { captureCase, emitProducer } from "./scenario_result.js";

type Fixture = Awaited<ReturnType<typeof jwtFixture>>;

const results = {
  "expired-cache-miss-fetches-once": await captureCase(expiredMissFetchesOnce),
  "changed-set-missing-key-installs-cooldown": await captureCase(
    changedSetMissingKeyInstallsCooldown,
  ),
  "irrelevant-metadata-preserves-revision": await captureCase(
    irrelevantMetadataPreservesRevision,
  ),
  "changed-public-key-rotates-revision": await captureCase(
    changedPublicKeyRotatesRevision,
  ),
  "key-membership-change-rotates-revision": await captureCase(
    keyMembershipChangeRotatesRevision,
  ),
  "concurrent-same-key-misses-coalesce": await captureCase(
    concurrentSameKeyMissesCoalesce,
  ),
  "distinct-unknown-key-pressure-bounded": await captureCase(
    distinctUnknownKeyPressureBounded,
  ),
  "outage-cooldown-and-later-retry": await captureCase(
    outageCooldownAndLaterRetry,
  ),
  "stale-known-key-boundary-and-expiry": await captureCase(
    staleKnownKeyBoundaryAndExpiry,
  ),
  "malformed-duplicate-private-non-rs256-rejection": await captureCase(
    malformedDuplicatePrivateNonRs256Rejection,
  ),
};

const producer = makeProducerResult("jwks-state-machine", results);
emitProducer("jwks-state-machine", producer);
process.stdout.write(
  `JWKS_STATE_MACHINE_PRODUCER=${producer.passed ? "true" : "false"}\n`,
);
if (!producer.passed) process.exitCode = 1;

async function expiredMissFetchesOnce() {
  const fixture = await jwtFixture();
  try {
    let now = fixture.now;
    let fetchCount = 0;
    const verifier = newVerifier(fixture, {
      clock: { now: () => now },
      cacheMaxAgeMs: 1,
      fetchJwks: async (input, init) => {
        fetchCount++;
        return fetch(input, init);
      },
    });
    await verifier.verify(request(await fixture.token()));
    fetchCount = 0;
    now = new Date(fixture.now.getTime() + 2);
    await rejects(
      verifier.verify(request(await fixture.token({ kid: "missing" }))),
    );
    assert.equal(fetchCount, 1);
  } finally {
    await fixture.close();
  }
}

async function changedSetMissingKeyInstallsCooldown() {
  const fixture = await jwtFixture();
  try {
    let now = fixture.now;
    let fetchCount = 0;
    const verifier = newVerifier(fixture, {
      clock: { now: () => now },
      cacheMaxAgeMs: 1,
      unknownKidCooldownMs: 60000,
      fetchJwks: async (input, init) => {
        fetchCount++;
        return fetch(input, init);
      },
    });
    await verifier.verify(request(await fixture.token()));
    await fixture.setJwksBody({ keys: [await fixture.publicJwk("rotated")] });
    fetchCount = 0;
    now = new Date(fixture.now.getTime() + 2);
    await rejects(
      verifier.verify(request(await fixture.token({ kid: "missing" }))),
    );
    await rejects(
      verifier.verify(request(await fixture.token({ kid: "missing" }))),
    );
    assert.equal(fetchCount, 1);
  } finally {
    await fixture.close();
  }
}

async function irrelevantMetadataPreservesRevision() {
  const fixture = await jwtFixture();
  try {
    let now = fixture.now;
    let fetchCount = 0;
    const verifier = newVerifier(fixture, {
      clock: { now: () => now },
      cacheMaxAgeMs: 1,
      unknownKidCooldownMs: 60000,
      fetchJwks: async (input, init) => {
        fetchCount++;
        return fetch(input, init);
      },
    });
    await verifier.verify(request(await fixture.token()));
    fetchCount = 0;
    now = new Date(fixture.now.getTime() + 2);
    await rejects(
      verifier.verify(request(await fixture.token({ kid: "metadata-miss" }))),
    );
    assert.equal(fetchCount, 1);
    await fixture.setJwksBody({
      keys: [
        { ...(await fixture.publicJwk("kid-1")), provider_metadata: "ignored" },
      ],
    });
    await rejects(
      verifier.verify(request(await fixture.token({ kid: "metadata-miss" }))),
    );
    assert.equal(fetchCount, 1);
  } finally {
    await fixture.close();
  }
}

async function changedPublicKeyRotatesRevision() {
  const fixture = await jwtFixture();
  try {
    let now = fixture.now;
    const verifier = newVerifier(fixture, {
      clock: { now: () => now },
      cacheMaxAgeMs: 1,
    });
    const old = await fixture.token();
    await verifier.verify(request(old));
    const rotated = await fixture.rotate("kid-1");
    await fixture.setJwksBody({ keys: [rotated.jwk] });
    now = new Date(fixture.now.getTime() + 2);
    await rejects(verifier.verify(request(old)));
    assert.equal(
      (await verifier.verify(request(await fixture.token({ key: rotated }))))
        .subject,
      "auth0|subject",
    );
  } finally {
    await fixture.close();
  }
}

async function keyMembershipChangeRotatesRevision() {
  const fixture = await jwtFixture();
  try {
    let now = fixture.now;
    const second = await fixture.rotate("kid-2");
    const verifier = newVerifier(fixture, {
      clock: { now: () => now },
      cacheMaxAgeMs: 1,
    });
    await verifier.verify(request(await fixture.token()));
    await fixture.setJwksBody({
      keys: [await fixture.publicJwk("kid-1"), second.jwk],
    });
    now = new Date(fixture.now.getTime() + 2);
    assert.equal(
      (
        await verifier.verify(
          request(await fixture.token({ kid: "kid-2", key: second })),
        )
      ).subject,
      "auth0|subject",
    );
  } finally {
    await fixture.close();
  }
}

async function concurrentSameKeyMissesCoalesce() {
  const fixture = await jwtFixture();
  try {
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
  } finally {
    await fixture.close();
  }
}

async function distinctUnknownKeyPressureBounded() {
  const fixture = await jwtFixture();
  try {
    let fetchCount = 0;
    const verifier = newVerifier(fixture, {
      unknownKidCooldownMs: 60000,
      fetchJwks: async (input, init) => {
        fetchCount++;
        return fetch(input, init);
      },
    });
    await verifier.verify(request(await fixture.token()));
    fetchCount = 0;
    await rejects(
      verifier.verify(request(await fixture.token({ kid: "missing-a" }))),
    );
    await rejects(
      verifier.verify(request(await fixture.token({ kid: "missing-a" }))),
    );
    await rejects(
      verifier.verify(request(await fixture.token({ kid: "missing-b" }))),
    );
    assert(fetchCount <= 2);
  } finally {
    await fixture.close();
  }
}

async function outageCooldownAndLaterRetry() {
  const fixture = await jwtFixture();
  try {
    let now = fixture.now;
    let fail = false;
    let fetchCount = 0;
    const verifier = newVerifier(fixture, {
      clock: { now: () => now },
      cacheMaxAgeMs: 1,
      cooldownMs: 1000,
      fetchJwks: async (input, init) => {
        fetchCount++;
        if (fail) throw new Error("local outage");
        return fetch(input, init);
      },
    });
    await verifier.verify(request(await fixture.token()));
    now = new Date(fixture.now.getTime() + 2);
    fail = true;
    await verifier.verify(request(await fixture.token()));
    const duringCooldown = fetchCount;
    await verifier.verify(request(await fixture.token()));
    assert.equal(fetchCount, duringCooldown);
    fail = false;
    now = new Date(fixture.now.getTime() + 1200);
    await verifier.verify(request(await fixture.token()));
    assert(fetchCount > duringCooldown);
  } finally {
    await fixture.close();
  }
}

async function staleKnownKeyBoundaryAndExpiry() {
  const fixture = await jwtFixture();
  try {
    let now = fixture.now;
    const verifier = newVerifier(fixture, {
      clock: { now: () => now },
      cacheMaxAgeMs: 1,
      staleIfErrorMs: 20,
      fetchJwks: async (input, init) => {
        if (now > fixture.now) throw new Error("local outage");
        return fetch(input, init);
      },
    });
    const known = await fixture.token();
    await verifier.verify(request(known));
    now = new Date(fixture.now.getTime() + 2);
    await verifier.verify(request(known));
    now = new Date(fixture.now.getTime() + 25);
    await rejects(verifier.verify(request(known)));
  } finally {
    await fixture.close();
  }
}

async function malformedDuplicatePrivateNonRs256Rejection() {
  const fixture = await jwtFixture();
  try {
    await fixture.setJwksBody("not-json");
    await rejects(newVerifier(fixture).verify(request(await fixture.token())));
    await fixture.setJwksBody({
      keys: [
        await fixture.publicJwk("kid-1"),
        await fixture.publicJwk("kid-1"),
      ],
    });
    await rejects(newVerifier(fixture).verify(request(await fixture.token())));
    await fixture.setJwksBody({
      keys: [{ ...(await fixture.publicJwk("kid-1")), d: "private" }],
    });
    await rejects(newVerifier(fixture).verify(request(await fixture.token())));
    await fixture.setJwksBody({
      keys: [{ ...(await fixture.publicJwk("kid-1")), alg: "RS384" }],
    });
    await rejects(newVerifier(fixture).verify(request(await fixture.token())));
  } finally {
    await fixture.close();
  }
}

async function jwtFixture() {
  const now = new Date("2026-07-15T00:00:00.000Z");
  const keys = await generate("kid-1");
  let jwksBody: unknown = { keys: [keys.jwk] };
  const app = Fastify({ logger: false });
  app.get("/.well-known/jwks.json", async () => jwksBody);
  await app.listen({ host: "127.0.0.1", port: 0 });
  const port = (app.server.address() as { port: number }).port;
  const issuer = `http://127.0.0.1:${port}/`;
  const audience = "markei-api";
  return {
    now,
    issuer,
    audience,
    close: () => app.close(),
    setJwksBody: async (body: unknown) => {
      jwksBody = body;
    },
    publicJwk: async (kid: string) =>
      kid === "kid-1" ? keys.jwk : (await generate(kid)).jwk,
    rotate: generate,
    token: (
      options: {
        kid?: string;
        key?: Awaited<ReturnType<typeof generate>>;
      } = {},
    ) =>
      new SignJWT({})
        .setProtectedHeader({
          alg: "RS256",
          kid: options.kid ?? options.key?.jwk.kid ?? "kid-1",
        })
        .setIssuer(issuer)
        .setAudience(audience)
        .setSubject("auth0|subject")
        .setIssuedAt(Math.floor(now.getTime() / 1000))
        .setExpirationTime(Math.floor(now.getTime() / 1000) + 600)
        .sign((options.key ?? keys).privateKey),
  };
}

async function generate(kid: string) {
  const pair = await generateKeyPair("RS256", { extractable: true });
  const jwk = await exportJWK(pair.publicKey);
  return {
    privateKey: pair.privateKey,
    jwk: { ...jwk, kid, alg: "RS256", use: "sig" },
  };
}

function newVerifier(
  fixture: Fixture,
  options: Partial<ConstructorParameters<typeof Auth0JwtVerifier>[0]> = {},
) {
  return new Auth0JwtVerifier({
    issuer: fixture.issuer,
    audience: fixture.audience,
    jwksUri: `${fixture.issuer}.well-known/jwks.json`,
    clock: { now: () => fixture.now },
    ...options,
  });
}

function request(token: string) {
  return { headers: { authorization: `Bearer ${token}` } } as never;
}

async function rejects(value: Promise<unknown>) {
  await assert.rejects(value, HostedAuthError);
}
