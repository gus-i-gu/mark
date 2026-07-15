import sensible from "@fastify/sensible";
import Fastify from "fastify";
import type { AuthVerifier } from "../application/auth.js";
import {
  acceptSubmission,
  acknowledgeCursor,
  downloadEvents,
} from "../application/sync_service.js";
import { inTransaction, type Database } from "../postgres/database.js";

export function buildApp(options: { auth: AuthVerifier; database?: Database }) {
  const app = Fastify({ logger: false });
  app.register(sensible);

  app.get("/health/live", async () => ({ status: "live" }));
  app.get("/health/ready", async () => ({
    status: options.database ? "ready" : "not-ready",
  }));

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

  return app;
}
