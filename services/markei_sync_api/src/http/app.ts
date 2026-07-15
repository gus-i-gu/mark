import sensible from "@fastify/sensible";
import Fastify from "fastify";
import type { AuthVerifier } from "../application/auth.js";
import { HostedAuthError } from "../application/hosted_contracts.js";
import type { HostedIdentityService } from "../application/hosted_authorization.js";
import {
  acceptSubmission,
  acknowledgeCursor,
  downloadEvents,
} from "../application/sync_service.js";
import {
  completeRebootstrap,
  getCapabilities,
  getRebootstrapChunk,
  getRebootstrapStatus,
  startRebootstrap,
  type RecoveryComposition,
} from "../application/recovery_service.js";
import { inTransaction, type Database } from "../postgres/database.js";

export function buildApp(options: {
  auth: AuthVerifier;
  database?: Database;
  recovery?: RecoveryComposition;
  hosted?: HostedIdentityService;
}) {
  const app = Fastify({ logger: false });
  app.register(sensible);

  app.get("/health/live", async () => ({ status: "live" }));
  app.get("/health/ready", async () => ({
    status: await readyStatus(options.database),
  }));

  app.setErrorHandler((error, request, reply) => {
    if (error instanceof HostedAuthError) {
      return reply.code(error.statusCode).send({
        code: error.code,
        operation: "hosted-authorization",
        outcome: "not-applied",
        retryable: false,
        safeAction: "preserve local state",
        correlationId: request.id,
      });
    }
    return reply.code(500).send({
      code: "service-unavailable",
      operation: "server",
      outcome: "unknown",
      retryable: true,
      safeAction: "retry later",
      correlationId: request.id,
    });
  });

  if (options.hosted) {
    app.get("/v1/identity", async (request) =>
      options.hosted!.identity(request),
    );
    app.post("/v1/devices/enroll", async (request) =>
      options.hosted!.enroll(request, request.body as never),
    );
    app.get("/v1/devices/enrollments/:requestId", async (request) => {
      const params = request.params as { requestId: string };
      return options.hosted!.enrollmentStatus(request, params.requestId);
    });
    app.get("/v1/devices/:deviceId/status", async (request) => {
      const params = request.params as { deviceId: string };
      return options.hosted!.deviceStatus(request, params.deviceId);
    });
    app.post("/v1/devices/:deviceId/revoke", async (request) => {
      const params = request.params as { deviceId: string };
      return options.hosted!.revoke(request, params.deviceId);
    });
  }

  app.post("/v1/sync/submissions", async (request, reply) => {
    if (!options.database) {
      return reply.code(503).send({
        code: "service-unavailable",
        operation: "upload-submission",
        outcome: "unknown",
        retryable: true,
        safeAction: "retry the same SubmissionId later",
        correlationId: request.id,
      });
    }
    const auth = await options.auth.verify(request);
    const result = await inTransaction(options.database, auth, (client) =>
      acceptSubmission(client, auth, request.body as never, request.id),
    );
    return reply.send(result);
  });

  app.get("/v1/sync/events", async (request, reply) => {
    if (!options.database) {
      return reply.code(503).send({
        code: "service-unavailable",
        operation: "download-events",
        outcome: "unknown",
        retryable: true,
        safeAction: "retry later",
        correlationId: request.id,
      });
    }
    const auth = await options.auth.verify(request);
    const query = request.query as { after?: string; limit?: string };
    const result = await inTransaction(options.database, auth, (client) =>
      downloadEvents(client, auth, query.after, Number(query.limit ?? 25)),
    );
    return reply.send(result);
  });

  app.post("/v1/sync/acknowledgements", async (request, reply) => {
    if (!options.database) {
      return reply.code(503).send({
        code: "service-unavailable",
        operation: "acknowledgement",
        outcome: "unknown",
        retryable: true,
        safeAction: "retry later",
        correlationId: request.id,
      });
    }
    const auth = await options.auth.verify(request);
    const body = request.body as { greatestContiguousCursor: string };
    const result = await inTransaction(options.database, auth, (client) =>
      acknowledgeCursor(client, auth, body.greatestContiguousCursor),
    );
    return reply.send(result);
  });

  app.get("/v1/sync/capabilities", async (request, reply) => {
    if (!options.database || !options.recovery) {
      return reply.code(503).send(unavailable("capabilities", request.id));
    }
    const auth = await options.auth.verify(request);
    const result = await inTransaction(options.database, auth, (client) =>
      getCapabilities(client, auth, options.recovery!),
    );
    return reply.send(result);
  });

  app.post("/v1/sync/rebootstrap", async (request, reply) => {
    if (!options.database || !options.recovery) {
      return reply.code(503).send(unavailable("start-rebootstrap", request.id));
    }
    const auth = await options.auth.verify(request);
    const result = await inTransaction(options.database, auth, (client) =>
      startRebootstrap(client, auth, request.body as never, options.recovery!),
    );
    return reply.send(result);
  });

  app.get("/v1/sync/rebootstrap/:sessionId", async (request, reply) => {
    if (!options.database || !options.recovery) {
      return reply.code(503).send(unavailable("query-rebootstrap", request.id));
    }
    const auth = await options.auth.verify(request);
    const params = request.params as { sessionId: string };
    const result = await inTransaction(options.database, auth, (client) =>
      getRebootstrapStatus(client, auth, params.sessionId, options.recovery!),
    );
    return reply.send(result);
  });

  app.get(
    "/v1/sync/rebootstrap/:sessionId/chunks/:index",
    async (request, reply) => {
      if (!options.database || !options.recovery) {
        return reply
          .code(503)
          .send(unavailable("download-rebootstrap-chunk", request.id));
      }
      const auth = await options.auth.verify(request);
      const params = request.params as { sessionId: string; index: string };
      const result = await inTransaction(options.database, auth, (client) =>
        getRebootstrapChunk(
          client,
          auth,
          params.sessionId,
          Number(params.index),
          options.recovery!,
        ),
      );
      return reply.send(result);
    },
  );

  app.post(
    "/v1/sync/rebootstrap/:sessionId/complete",
    async (request, reply) => {
      if (!options.database || !options.recovery) {
        return reply
          .code(503)
          .send(unavailable("complete-rebootstrap", request.id));
      }
      const auth = await options.auth.verify(request);
      const params = request.params as { sessionId: string };
      const body = request.body as Record<string, unknown>;
      const result = await inTransaction(options.database, auth, (client) =>
        completeRebootstrap(
          client,
          auth,
          { ...body, recoverySessionId: params.sessionId } as never,
          options.recovery!,
        ),
      );
      return reply.send(result);
    },
  );

  return app;
}

function unavailable(operation: string, correlationId: string) {
  return {
    code: "service-unavailable",
    operation,
    outcome: "unknown",
    retryable: true,
    safeAction: "retry later",
    correlationId,
  };
}

async function readyStatus(database: Database | undefined) {
  if (!database) return "not-ready";
  try {
    const result = await database.pool.query(
      "select 1 from migration_ledger where migration_id=$1",
      ["004_hosted_identity_enrollment"],
    );
    return result.rowCount ? "ready" : "not-ready";
  } catch {
    return "not-ready";
  }
}
