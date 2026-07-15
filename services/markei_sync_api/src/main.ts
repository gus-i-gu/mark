import pg from "pg";
import { buildApp } from "./http/app.js";

const connectionString = process.env.MARKEI_SYNC_DATABASE_URL;
if (!connectionString) {
  throw new Error("MARKEI_SYNC_DATABASE_URL is required");
}

const app = buildApp({
  authorization: { kind: "disabled" },
  database: { pool: new pg.Pool({ connectionString }) },
});

await app.listen({ host: "127.0.0.1", port: Number(process.env.PORT ?? 3100) });
