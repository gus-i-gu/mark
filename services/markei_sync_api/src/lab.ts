import pg from "pg";
import { FixtureAuthVerifier } from "./application/auth.js";
import { buildApp } from "./http/app.js";

const connectionString = process.env.MARKEI_SYNC_DATABASE_URL;
const accountId = process.env.MARKEI_SYNC_LAB_ACCOUNT_ID;
const deviceId = process.env.MARKEI_SYNC_LAB_DEVICE_ID;
const host = process.env.HOST ?? "127.0.0.1";
const port = Number(process.env.PORT ?? 0);

if (!connectionString || !accountId || !deviceId) {
  throw new Error("lab runtime requires database, Account and Device claims");
}
if (host !== "127.0.0.1" && host !== "::1" && host !== "localhost") {
  throw new Error("fixture lab authentication is loopback-only");
}

const pool = new pg.Pool({ connectionString, max: 4 });
const app = buildApp({
  auth: new FixtureAuthVerifier({ accountId, deviceId }),
  database: { pool },
});

await app.listen({ host, port });
const address = app.server.address();
const selectedPort =
  typeof address === "object" && address ? address.port : port;
process.stdout.write(`MARKEI_SYNC_LAB_READY ${selectedPort}\n`);

const close = async () => {
  await app.close();
  await pool.end();
};

process.once("SIGTERM", () => {
  close().finally(() => process.exit(0));
});
