import type { PoolClient } from "pg";
import {
  canonicalHash,
  type AuthContext,
  type ProtocolFailure,
} from "../domain/protocol.js";
import { decodeCursor, encodeCursor } from "../domain/cursor.js";

export type SubmissionRequest = {
  submissionId: string;
  deviceId: string;
  requestHash: string;
  events: Array<Record<string, unknown>>;
};

export type SubmissionResult = {
  status: "server-accepted" | "duplicate-ignored";
  cursors: string[];
};

export type DownloadPage = {
  after: string;
  nextCursor: string;
  events: Array<{ serverCursor: string; event: Record<string, unknown> }>;
};

export type AckResult = {
  status: "acknowledged" | "duplicate-ignored";
};

export async function acceptSubmission(
  client: PoolClient,
  auth: AuthContext,
  request: SubmissionRequest,
  correlationId = "sync-api",
): Promise<SubmissionResult | ProtocolFailure> {
  if (request.deviceId !== auth.deviceId) {
    return failure("device-revoked", "upload-submission", false, correlationId);
  }
  const existing = await client.query(
    "select request_hash, stored_result from submissions where account_id=$1 and device_id=$2 and submission_id=$3",
    [auth.accountId, auth.deviceId, request.submissionId],
  );
  if (existing.rowCount) {
    const row = existing.rows[0];
    if (row.request_hash !== request.requestHash) {
      return failure(
        "hash-mismatch",
        "upload-submission",
        false,
        correlationId,
      );
    }
    return row.stored_result as SubmissionResult;
  }

  const cursors: string[] = [];
  for (const event of request.events) {
    if (
      event.accountId !== auth.accountId ||
      event.deviceId !== auth.deviceId
    ) {
      return failure(
        "wrong-account",
        "upload-submission",
        false,
        correlationId,
      );
    }
    const eventContent = { ...event };
    delete eventContent.contentHash;
    if (event.contentHash !== canonicalHash(eventContent)) {
      return failure(
        "hash-mismatch",
        "upload-submission",
        false,
        correlationId,
      );
    }
    const eventId = String(event.eventId);
    const accepted = await client.query(
      "select content_hash, server_cursor from sync_events where account_id=$1 and event_id=$2",
      [auth.accountId, eventId],
    );
    if (accepted.rowCount) {
      if (accepted.rows[0].content_hash !== event.contentHash) {
        return failure(
          "hash-mismatch",
          "upload-submission",
          false,
          correlationId,
        );
      }
      cursors.push(encodeCursor(Number(accepted.rows[0].server_cursor)));
      continue;
    }
    const device = await client.query(
      "select next_expected_sequence from devices where account_id=$1 and device_id=$2 and status='active' for update",
      [auth.accountId, auth.deviceId],
    );
    if (!device.rowCount) {
      return failure(
        "device-revoked",
        "upload-submission",
        false,
        correlationId,
      );
    }
    if (
      Number(event.deviceSequence) !==
      Number(device.rows[0].next_expected_sequence)
    ) {
      return failure("sequence-gap", "upload-submission", false, correlationId);
    }
    const cursor = await client.query(
      "update account_cursor_state set next_cursor=next_cursor+1 where account_id=$1 returning next_cursor-1 as cursor",
      [auth.accountId],
    );
    const serverCursor = Number(cursor.rows[0].cursor);
    await client.query(
      "insert into sync_events(event_id, account_id, device_id, device_sequence, server_cursor, event_type, payload_version, occurrence_time, payload, content_hash) values($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)",
      [
        eventId,
        auth.accountId,
        auth.deviceId,
        event.deviceSequence,
        serverCursor,
        event.eventType,
        event.payloadVersion,
        event.occurrenceTime,
        event.payload,
        event.contentHash,
      ],
    );
    await client.query(
      "update devices set next_expected_sequence=next_expected_sequence+1 where account_id=$1 and device_id=$2",
      [auth.accountId, auth.deviceId],
    );
    cursors.push(encodeCursor(serverCursor));
  }
  const result: SubmissionResult = { status: "server-accepted", cursors };
  await client.query(
    "insert into submissions(account_id, device_id, submission_id, request_hash, stored_result) values($1,$2,$3,$4,$5)",
    [
      auth.accountId,
      auth.deviceId,
      request.submissionId,
      request.requestHash,
      result,
    ],
  );
  return result;
}

export async function downloadEvents(
  client: PoolClient,
  auth: AuthContext,
  after: string | undefined,
  limit: number,
): Promise<DownloadPage> {
  const boundedLimit = Math.min(Math.max(limit || 25, 1), 100);
  const afterNumber = decodeCursor(after);
  const rows = await client.query(
    `select event_id, account_id, device_id, device_sequence, server_cursor,
            event_type, payload_version, occurrence_time, payload, content_hash
       from sync_events
      where account_id=$1 and server_cursor > $2
      order by server_cursor asc
      limit $3`,
    [auth.accountId, afterNumber, boundedLimit],
  );
  const events = rows.rows.map((row) => {
    const event = {
      eventId: String(row.event_id),
      accountId: String(row.account_id),
      deviceId: String(row.device_id),
      deviceSequence: Number(row.device_sequence),
      eventType: String(row.event_type),
      payloadVersion: Number(row.payload_version),
      occurrenceTime: new Date(row.occurrence_time).toISOString(),
      payload: row.payload as Record<string, unknown>,
      contentHash: String(row.content_hash),
    };
    return { serverCursor: encodeCursor(Number(row.server_cursor)), event };
  });
  return {
    after: encodeCursor(afterNumber),
    nextCursor:
      events.length === 0
        ? encodeCursor(afterNumber)
        : events[events.length - 1].serverCursor,
    events,
  };
}

export async function acknowledgeCursor(
  client: PoolClient,
  auth: AuthContext,
  cursor: string,
): Promise<AckResult | ProtocolFailure> {
  const value = decodeCursor(cursor);
  const highWater = await client.query(
    "select next_cursor - 1 as high_water from account_cursor_state where account_id=$1",
    [auth.accountId],
  );
  if (!highWater.rowCount || value > Number(highWater.rows[0].high_water)) {
    return failure("cursor-expired", "acknowledgement", false, "sync-api");
  }
  const current = await client.query(
    "select greatest_contiguous_cursor from device_acknowledgements where account_id=$1 and device_id=$2",
    [auth.accountId, auth.deviceId],
  );
  if (
    current.rowCount &&
    value <= Number(current.rows[0].greatest_contiguous_cursor)
  ) {
    return { status: "duplicate-ignored" };
  }
  await client.query(
    `insert into device_acknowledgements(account_id, device_id, greatest_contiguous_cursor)
     values($1,$2,$3)
     on conflict(account_id, device_id) do update
       set greatest_contiguous_cursor=excluded.greatest_contiguous_cursor,
           updated_at=now()`,
    [auth.accountId, auth.deviceId, value],
  );
  return { status: "acknowledged" };
}

function failure(
  code: string,
  operation: string,
  retryable: boolean,
  correlationId: string,
): ProtocolFailure {
  return {
    code,
    operation,
    outcome: "not-applied",
    retryable,
    safeAction: retryable
      ? "retry the same identity"
      : "stop and preserve evidence",
    correlationId,
  };
}
