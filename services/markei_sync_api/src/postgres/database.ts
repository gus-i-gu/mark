import pg from "pg";
import type { AuthContext } from "../domain/protocol.js";

export type Database = {
  pool: pg.Pool;
};

export async function inTransaction<T>(
  database: Database,
  auth: AuthContext,
  action: (client: pg.PoolClient) => Promise<T>,
): Promise<T> {
  return inTransactionWithContext(database, auth, action);
}

export async function inTransactionWithContext<T>(
  database: Database,
  context: Partial<AuthContext> & { identityId?: string },
  action: (client: pg.PoolClient) => Promise<T>,
): Promise<T> {
  const deadline = Date.now() + 5000;
  for (let attempt = 1; attempt <= 3; attempt++) {
    const client = await database.pool.connect();
    try {
      await client.query("begin isolation level serializable");
      await client.query("select set_config('markei.account_id', $1, true)", [
        context.accountId ?? "",
      ]);
      await client.query("select set_config('markei.device_id', $1, true)", [
        context.deviceId ?? "",
      ]);
      await client.query("select set_config('markei.identity_id', $1, true)", [
        context.identityId ?? "",
      ]);
      const result = await action(client);
      await client.query("commit");
      return result;
    } catch (error) {
      await client.query("rollback").catch(() => undefined);
      if (attempt < 3 && Date.now() < deadline && isRetryableSql(error)) {
        continue;
      }
      throw error;
    } finally {
      client.release();
    }
  }
  throw new Error("transaction retry exhausted");
}

function isRetryableSql(error: unknown): boolean {
  const code = (error as { code?: string }).code;
  return code === "40001" || code === "40P01";
}
