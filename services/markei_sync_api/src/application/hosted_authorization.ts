import { randomUUID } from "node:crypto";
import type { FastifyRequest } from "fastify";
import type { PoolClient } from "pg";
import type { AuthVerifier } from "./auth.js";
import {
  canonicalHash,
  type AuthContext,
  type ProtocolFailure,
} from "../domain/protocol.js";
import {
  inTransactionWithContext,
  type Database,
} from "../postgres/database.js";
import {
  HostedAuthError,
  type Clock,
  type DeviceEnrollmentResult,
  type EnrollmentRequest,
  type ExternalPrincipal,
  type IdentityResult,
  type Membership,
  type PrincipalVerifier,
} from "./hosted_contracts.js";

export class HostedAuthVerifier implements AuthVerifier {
  constructor(
    private readonly database: Database,
    private readonly verifier: PrincipalVerifier,
  ) {}

  async verify(request: FastifyRequest): Promise<AuthContext> {
    const principal = await this.verifier.verify(request);
    const deviceId = requestedDeviceId(request);
    if (!deviceId) throw new HostedAuthError("device-enrollment-required", 403);
    return inTransactionWithContext(this.database, {}, async (client) => {
      const membership = await resolveOneMembership(client, principal);
      await client.query("select set_config('markei.account_id', $1, true)", [
        membership.accountId,
      ]);
      await client.query("select set_config('markei.device_id', $1, true)", [
        deviceId,
      ]);
      const device = await client.query(
        `select state from device_enrollments
          where account_id=$1 and device_id=$2 and identity_id=$3`,
        [membership.accountId, deviceId, membership.identityId],
      );
      if (!device.rowCount || device.rows[0].state !== "active") {
        throw new HostedAuthError("device-revoked", 403);
      }
      return { accountId: membership.accountId, deviceId };
    });
  }
}

export class HostedIdentityService {
  constructor(
    private readonly database: Database,
    private readonly verifier: PrincipalVerifier,
    private readonly clock: Clock,
  ) {}

  async identity(request: FastifyRequest): Promise<IdentityResult> {
    const principal = await this.verifier.verify(request);
    return inTransactionWithContext(this.database, {}, async (client) => {
      const identity = await resolveIdentity(client, principal);
      if (!identity)
        return { contractVersion: 1, state: "membership-required" };
      await setIdentity(client, identity.identityId);
      const memberships = await activeMemberships(client, identity.identityId);
      if (memberships.length === 0) {
        return { contractVersion: 1, state: "membership-required" };
      }
      if (memberships.length > 1) {
        return { contractVersion: 1, state: "account-selection-required" };
      }
      return {
        contractVersion: 1,
        state: "membership-confirmed",
        accountId: memberships[0].accountId,
        identityId: identity.identityId,
        role: memberships[0].role,
      };
    });
  }

  async enroll(
    request: FastifyRequest,
    body: EnrollmentRequest,
  ): Promise<DeviceEnrollmentResult | ProtocolFailure> {
    validateEnrollment(body);
    const principal = await this.verifier.verify(request);
    return inTransactionWithContext(this.database, {}, async (client) => {
      const membership = await resolveOneMembership(client, principal);
      await setAccount(client, membership.accountId);
      const hash = canonicalHash(body);
      const existing = await client.query(
        `select request_hash, stored_result, state
           from device_enrollment_requests
          where account_id=$1 and identity_id=$2 and enrollment_request_id=$3`,
        [membership.accountId, membership.identityId, body.enrollmentRequestId],
      );
      if (existing.rowCount) {
        if (existing.rows[0].request_hash !== hash) {
          return failure("conflict", "enroll-device", request.id);
        }
        if (existing.rows[0].stored_result) {
          return existing.rows[0].stored_result as DeviceEnrollmentResult;
        }
      }
      const active = await client.query(
        `select device_id, generation from device_enrollments
          where account_id=$1 and installation_id=$2 and state='active'
          for update`,
        [membership.accountId, body.installationId],
      );
      let deviceId: string;
      let generation = 1;
      if (active.rowCount) {
        deviceId = String(active.rows[0].device_id);
        generation = Number(active.rows[0].generation);
      } else {
        deviceId = randomUUID();
        await setDevice(client, deviceId);
        await client.query(
          `insert into devices(account_id, device_id, status, next_expected_sequence)
           values($1,$2,'active',1)`,
          [membership.accountId, deviceId],
        );
        await client.query(
          `insert into device_enrollments(
             account_id, installation_id, device_id, identity_id, state
           ) values($1,$2,$3,$4,'active')`,
          [
            membership.accountId,
            body.installationId,
            deviceId,
            membership.identityId,
          ],
        );
        await client.query(
          `insert into device_security_events(
             event_id, account_id, actor_identity_id, target_device_id,
             event_type, correlation_id
           ) values($1,$2,$3,$4,'device-enrolled',$5)`,
          [
            randomUUID(),
            membership.accountId,
            membership.identityId,
            deviceId,
            request.id,
          ],
        );
      }
      const result: DeviceEnrollmentResult = {
        contractVersion: 1,
        status: active.rowCount ? "duplicate-equivalent" : "device-enrolled",
        accountId: membership.accountId,
        installationId: body.installationId,
        deviceId,
        generation,
      };
      await client.query(
        `insert into device_enrollment_requests(
           account_id, identity_id, enrollment_request_id, installation_id,
           request_hash, state, device_id, stored_result, expires_at
         ) values($1,$2,$3,$4,$5,'completed',$6,$7,$8)
         on conflict(account_id, identity_id, enrollment_request_id) do update
           set stored_result=excluded.stored_result, updated_at=now()`,
        [
          membership.accountId,
          membership.identityId,
          body.enrollmentRequestId,
          body.installationId,
          hash,
          deviceId,
          result,
          new Date(this.clock.now().getTime() + 900000),
        ],
      );
      return result;
    });
  }

  async enrollmentStatus(
    request: FastifyRequest,
    requestId: string,
  ): Promise<DeviceEnrollmentResult | ProtocolFailure> {
    const principal = await this.verifier.verify(request);
    return inTransactionWithContext(this.database, {}, async (client) => {
      const membership = await resolveOneMembership(client, principal);
      await setAccount(client, membership.accountId);
      const row = await client.query(
        `select stored_result from device_enrollment_requests
          where account_id=$1 and identity_id=$2 and enrollment_request_id=$3`,
        [membership.accountId, membership.identityId, requestId],
      );
      if (!row.rowCount || !row.rows[0].stored_result) {
        return failure("service-unavailable", "query-enrollment", request.id);
      }
      return row.rows[0].stored_result as DeviceEnrollmentResult;
    });
  }

  async deviceStatus(request: FastifyRequest, deviceId: string) {
    const principal = await this.verifier.verify(request);
    return inTransactionWithContext(this.database, {}, async (client) => {
      const membership = await resolveOneMembership(client, principal);
      await setAccount(client, membership.accountId);
      await setDevice(client, deviceId);
      const row = await client.query(
        `select state, generation from device_enrollments
          where account_id=$1 and device_id=$2`,
        [membership.accountId, deviceId],
      );
      if (!row.rowCount) throw new HostedAuthError("forbidden", 404);
      return {
        contractVersion: 1,
        deviceId,
        status: row.rows[0].state,
        generation: Number(row.rows[0].generation),
      };
    });
  }

  async revoke(request: FastifyRequest, deviceId: string) {
    const principal = await this.verifier.verify(request);
    return inTransactionWithContext(this.database, {}, async (client) => {
      const membership = await resolveOneMembership(client, principal);
      await setAccount(client, membership.accountId);
      await setDevice(client, deviceId);
      if (
        membership.role !== "owner" &&
        requestedDeviceId(request) !== deviceId
      ) {
        throw new HostedAuthError("forbidden", 403);
      }
      const updated = await client.query(
        `update device_enrollments
            set state='revoked', updated_at=now()
          where account_id=$1 and device_id=$2 and state='active'`,
        [membership.accountId, deviceId],
      );
      await client.query(
        "update devices set status='revoked' where account_id=$1 and device_id=$2",
        [membership.accountId, deviceId],
      );
      if (updated.rowCount) {
        await client.query(
          `insert into device_security_events(
             event_id, account_id, actor_identity_id, target_device_id,
             event_type, correlation_id
           ) values($1,$2,$3,$4,'device-revoked',$5)`,
          [
            randomUUID(),
            membership.accountId,
            membership.identityId,
            deviceId,
            request.id,
          ],
        );
      }
      return { contractVersion: 1, status: "revoked", deviceId };
    });
  }
}

async function resolveOneMembership(
  client: PoolClient,
  principal: ExternalPrincipal,
): Promise<Membership> {
  const identity = await resolveIdentity(client, principal);
  if (!identity) throw new HostedAuthError("membership-required", 403);
  await setIdentity(client, identity.identityId);
  const memberships = await activeMemberships(client, identity.identityId);
  if (memberships.length === 0) {
    throw new HostedAuthError("membership-required", 403);
  }
  if (memberships.length > 1) {
    throw new HostedAuthError("account-selection-required", 409);
  }
  return memberships[0];
}

async function resolveIdentity(
  client: PoolClient,
  principal: ExternalPrincipal,
) {
  const row = await client.query(
    `select identity_id from external_identities
      where issuer=$1 and subject=$2 and status='active'`,
    [principal.issuer, principal.subject],
  );
  if (!row.rowCount) return null;
  return { identityId: String(row.rows[0].identity_id) };
}

async function activeMemberships(client: PoolClient, identityId: string) {
  const rows = await client.query(
    `select account_id, identity_id, role
       from account_memberships
      where identity_id=$1 and status='active'
      order by account_id`,
    [identityId],
  );
  return rows.rows.map((row) => ({
    accountId: String(row.account_id),
    identityId: String(row.identity_id),
    role: row.role as "owner" | "member",
  }));
}

function requestedDeviceId(request: FastifyRequest): string | null {
  const value = request.headers["x-markei-device-id"];
  return typeof value === "string" && uuid(value) ? value : null;
}

function validateEnrollment(body: EnrollmentRequest) {
  if (body.contractVersion !== 1) throw new HostedAuthError("conflict", 400);
  if (!uuid(body.installationId) || !uuid(body.enrollmentRequestId)) {
    throw new HostedAuthError("conflict", 400);
  }
  if (!["android", "windows", "test"].includes(body.platform)) {
    throw new HostedAuthError("conflict", 400);
  }
  bounded(body.applicationId, 1, 128);
  bounded(body.applicationVersion, 1, 64);
}

function bounded(value: string, min: number, max: number) {
  if (typeof value !== "string" || value.length < min || value.length > max) {
    throw new HostedAuthError("conflict", 400);
  }
}

function uuid(value: string): boolean {
  return /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i.test(
    value,
  );
}

async function setIdentity(client: PoolClient, identityId: string) {
  await client.query("select set_config('markei.identity_id', $1, true)", [
    identityId,
  ]);
}

async function setAccount(client: PoolClient, accountId: string) {
  await client.query("select set_config('markei.account_id', $1, true)", [
    accountId,
  ]);
}

async function setDevice(client: PoolClient, deviceId: string) {
  await client.query("select set_config('markei.device_id', $1, true)", [
    deviceId,
  ]);
}

function failure(
  code: string,
  operation: string,
  correlationId: string,
): ProtocolFailure {
  return {
    code,
    operation,
    outcome: "not-applied",
    retryable: false,
    safeAction: "stop and preserve evidence",
    correlationId,
  };
}
