import pg from "pg";

export type AccountStateSnapshot = {
  memberships: unknown[];
  submissions: unknown[];
  syncEvents: unknown[];
  cursorState: unknown[];
  acknowledgements: unknown[];
  recoverySessions: unknown[];
  recoveryChunks: unknown[];
  devices: unknown[];
  enrollmentRequests: unknown[];
  securityEvents: unknown[];
};

export async function observeAccountState(
  pool: pg.Pool,
  accountId: string,
): Promise<AccountStateSnapshot> {
  const client = await pool.connect();
  try {
    await client.query("begin read only");
    const snapshot: AccountStateSnapshot = {
      memberships: await rows(
        client,
        `select account_id::text, identity_id::text, role, status, membership_version::text
           from account_memberships
          where account_id=$1`,
        [accountId],
      ),
      submissions: await rows(
        client,
        `select account_id::text, device_id::text, submission_id::text,
                request_hash, stored_result->>'status' as stored_status
           from submissions
          where account_id=$1`,
        [accountId],
      ),
      syncEvents: await rows(
        client,
        `select event_id::text, account_id::text, device_id::text,
                device_sequence::text, server_cursor::text, event_type,
                payload_version, content_hash
           from sync_events
          where account_id=$1`,
        [accountId],
      ),
      cursorState: await rows(
        client,
        `select account_id::text, next_cursor::text
           from account_cursor_state
          where account_id=$1`,
        [accountId],
      ),
      acknowledgements: await rows(
        client,
        `select account_id::text, device_id::text,
                greatest_contiguous_cursor::text
           from device_acknowledgements
          where account_id=$1`,
        [accountId],
      ),
      recoverySessions: await rows(
        client,
        `select account_id::text, device_id::text, recovery_session_id::text,
                snapshot_id::text, request_hash, state, last_chunk_index,
                completed_cursor::text
           from rebootstrap_sessions
          where account_id=$1`,
        [accountId],
      ),
      recoveryChunks: await rows(
        client,
        `select account_id::text, snapshot_id::text, chunk_index,
                byte_length, content_hash
           from recovery_snapshot_chunks
          where account_id=$1`,
        [accountId],
      ),
      devices: await rows(
        client,
        `select account_id::text, device_id::text, status,
                next_expected_sequence::text
           from devices
          where account_id=$1`,
        [accountId],
      ),
      enrollmentRequests: await rows(
        client,
        `select account_id::text, identity_id::text,
                enrollment_request_id::text, installation_id::text,
                request_hash, state, device_id::text,
                stored_result->>'status' as stored_status
           from device_enrollment_requests
          where account_id=$1`,
        [accountId],
      ),
      securityEvents: await rows(
        client,
        `select event_id::text, account_id::text, actor_identity_id::text,
                target_device_id::text, event_type, correlation_id
           from device_security_events
          where account_id=$1`,
        [accountId],
      ),
    };
    await client.query("commit");
    return snapshot;
  } catch (error) {
    await client.query("rollback").catch(() => undefined);
    throw error;
  } finally {
    client.release();
  }
}

export function protectedStateMatchesExceptMembership(
  before: AccountStateSnapshot,
  after: AccountStateSnapshot,
): boolean {
  return (
    stableJson(withoutMemberships(before)) ===
    stableJson(withoutMemberships(after))
  );
}

export function stableJson(value: unknown): string {
  return JSON.stringify(canonical(value));
}

function withoutMemberships(snapshot: AccountStateSnapshot) {
  const rest: Omit<AccountStateSnapshot, "memberships"> = {
    acknowledgements: snapshot.acknowledgements,
    cursorState: snapshot.cursorState,
    devices: snapshot.devices,
    enrollmentRequests: snapshot.enrollmentRequests,
    recoveryChunks: snapshot.recoveryChunks,
    recoverySessions: snapshot.recoverySessions,
    securityEvents: snapshot.securityEvents,
    submissions: snapshot.submissions,
    syncEvents: snapshot.syncEvents,
  };
  return rest;
}

async function rows(
  client: pg.PoolClient,
  sql: string,
  values: readonly unknown[],
) {
  const result = await client.query(sql, [...values]);
  return result.rows.map(canonical).sort((left, right) => {
    const a = JSON.stringify(left);
    const b = JSON.stringify(right);
    return a.localeCompare(b);
  });
}

function canonical(value: unknown): unknown {
  if (Array.isArray(value)) return value.map(canonical).sort(compareJson);
  if (value && typeof value === "object") {
    return Object.fromEntries(
      Object.entries(value as Record<string, unknown>)
        .sort(([left], [right]) => left.localeCompare(right))
        .map(([key, item]) => [key, canonical(item)]),
    );
  }
  return value;
}

function compareJson(left: unknown, right: unknown) {
  return JSON.stringify(left).localeCompare(JSON.stringify(right));
}
