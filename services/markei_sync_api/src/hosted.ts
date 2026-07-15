import pg from "pg";
import {
  HostedIdentityService,
  HostedTransactionAuthorizer,
} from "./application/hosted_authorization.js";
import { RefusingAuthVerifier } from "./application/auth.js";
import { parseHostedConfig } from "./application/hosted_config.js";
import { systemClock } from "./application/hosted_contracts.js";
import { Auth0JwtVerifier } from "./application/jwt_verifier.js";
import { buildApp } from "./http/app.js";

const config = parseHostedConfig(process.env);
const pool = new pg.Pool({
  connectionString: config.databaseUrl,
  max: 8,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
});

const database = { pool };
const verifier = new Auth0JwtVerifier({
  issuer: config.issuer,
  audience: config.audience,
  jwksUri: config.jwksUri,
  clock: systemClock,
});
const hosted = new HostedIdentityService(database, verifier, systemClock);
const app = buildApp({
  auth: new RefusingAuthVerifier(),
  hostedAuthorizer: new HostedTransactionAuthorizer(database, verifier),
  database,
  hosted,
});

try {
  await app.listen({ host: "0.0.0.0", port: config.port });
  process.stdout.write("MARKEI_HOSTED_SYNC_READY\n");
} catch {
  await pool.end().catch(() => undefined);
  process.stderr.write("MARKEI_HOSTED_SYNC_START_FAILED\n");
  process.exit(1);
}

const close = async () => {
  await app.close().catch(() => undefined);
  await pool.end().catch(() => undefined);
};

process.once("SIGTERM", () => {
  close().finally(() => process.exit(0));
});
process.once("SIGINT", () => {
  close().finally(() => process.exit(0));
});
