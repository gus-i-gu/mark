import sensible from "@fastify/sensible";
import Fastify from "fastify";
import type {
  FastifyInstance,
  FastifyReply,
  FastifyRequest,
  RouteHandlerMethod,
} from "fastify";
import type { AuthVerifier } from "../application/auth.js";
import { HostedAuthError } from "../application/hosted_contracts.js";
import type {
  HostedIdentityService,
  HostedTransactionAuthorizer,
} from "../application/hosted_authorization.js";
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
import type { AuthContext, ProtocolFailure } from "../domain/protocol.js";
import type { PoolClient } from "pg";

type AuthorizationClass =
  | "principal-only"
  | "active-membership"
  | "active-actor-device-management"
  | "transaction-scoped-operation";

type RouteDescriptor = {
  method: "GET" | "POST";
  path: string;
  operation: string;
  authorizationClass: AuthorizationClass;
  hostedOnly?: boolean;
  handler: RouteHandlerMethod;
};

type RouteAuthorizationDescriptor = Omit<RouteDescriptor, "handler">;

export const ROUTE_AUTHORIZATION_DESCRIPTORS: readonly RouteAuthorizationDescriptor[] =
  [
    {
      method: "GET",
      path: "/v1/identity",
      operation: "identity-resolution",
      authorizationClass: "principal-only",
      hostedOnly: true,
    },
    {
      method: "POST",
      path: "/v1/devices/enroll",
      operation: "enroll-device",
      authorizationClass: "active-membership",
      hostedOnly: true,
    },
    {
      method: "GET",
      path: "/v1/devices/enrollments/:requestId",
      operation: "query-enrollment",
      authorizationClass: "active-membership",
      hostedOnly: true,
    },
    {
      method: "GET",
      path: "/v1/devices/:deviceId/status",
      operation: "device-status",
      authorizationClass: "active-actor-device-management",
      hostedOnly: true,
    },
    {
      method: "POST",
      path: "/v1/devices/:deviceId/revoke",
      operation: "device-revoke",
      authorizationClass: "active-actor-device-management",
      hostedOnly: true,
    },
    {
      method: "POST",
      path: "/v1/sync/submissions",
      operation: "upload-submission",
      authorizationClass: "transaction-scoped-operation",
    },
    {
      method: "GET",
      path: "/v1/sync/events",
      operation: "download-events",
      authorizationClass: "transaction-scoped-operation",
    },
    {
      method: "POST",
      path: "/v1/sync/acknowledgements",
      operation: "acknowledgement",
      authorizationClass: "transaction-scoped-operation",
    },
    {
      method: "GET",
      path: "/v1/sync/capabilities",
      operation: "capabilities",
      authorizationClass: "transaction-scoped-operation",
    },
    {
      method: "POST",
      path: "/v1/sync/rebootstrap",
      operation: "start-rebootstrap",
      authorizationClass: "transaction-scoped-operation",
    },
    {
      method: "GET",
      path: "/v1/sync/rebootstrap/:sessionId",
      operation: "query-rebootstrap",
      authorizationClass: "transaction-scoped-operation",
    },
    {
      method: "GET",
      path: "/v1/sync/rebootstrap/:sessionId/chunks/:index",
      operation: "download-rebootstrap-chunk",
      authorizationClass: "transaction-scoped-operation",
    },
    {
      method: "POST",
      path: "/v1/sync/rebootstrap/:sessionId/complete",
      operation: "complete-rebootstrap",
      authorizationClass: "transaction-scoped-operation",
    },
  ] as const;

export function buildApp(options: {
  auth: AuthVerifier;
  hostedAuthorizer?: HostedTransactionAuthorizer;
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

  const routes: RouteDescriptor[] = [];
  if (options.hosted) {
    routes.push(
      route(
        "GET",
        "/v1/identity",
        "identity-resolution",
        "principal-only",
        async (request: FastifyRequest) => options.hosted!.identity(request),
      ),
      route(
        "POST",
        "/v1/devices/enroll",
        "enroll-device",
        "active-membership",
        async (request: FastifyRequest, reply: FastifyReply) => {
          const result = await options.hosted!.enroll(
            request,
            request.body as never,
          );
          return sendHostedResult(reply, result);
        },
      ),
      route(
        "GET",
        "/v1/devices/enrollments/:requestId",
        "query-enrollment",
        "active-membership",
        async (request: FastifyRequest, reply: FastifyReply) => {
          const params = request.params as { requestId: string };
          const result = await options.hosted!.enrollmentStatus(
            request,
            params.requestId,
          );
          return sendHostedResult(reply, result);
        },
      ),
      route(
        "GET",
        "/v1/devices/:deviceId/status",
        "device-status",
        "active-actor-device-management",
        async (request: FastifyRequest) => {
          const params = request.params as { deviceId: string };
          return options.hosted!.deviceStatus(request, params.deviceId);
        },
      ),
      route(
        "POST",
        "/v1/devices/:deviceId/revoke",
        "device-revoke",
        "active-actor-device-management",
        async (request: FastifyRequest) => {
          const params = request.params as { deviceId: string };
          return options.hosted!.revoke(request, params.deviceId);
        },
      ),
    );
  }

  routes.push(
    route(
      "POST",
      "/v1/sync/submissions",
      "upload-submission",
      "transaction-scoped-operation",
      async (request: FastifyRequest, reply: FastifyReply) => {
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
        const result = await protectedOperation(
          options.database,
          options.auth,
          options.hostedAuthorizer,
          request,
          "upload-submission",
          (client, auth) =>
            acceptSubmission(client, auth, request.body as never, request.id),
        );
        return reply.send(result);
      },
    ),

    route(
      "GET",
      "/v1/sync/events",
      "download-events",
      "transaction-scoped-operation",
      async (request: FastifyRequest, reply: FastifyReply) => {
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
        const query = request.query as { after?: string; limit?: string };
        const result = await protectedOperation(
          options.database,
          options.auth,
          options.hostedAuthorizer,
          request,
          "download-events",
          (client, auth) =>
            downloadEvents(
              client,
              auth,
              query.after,
              Number(query.limit ?? 25),
            ),
        );
        return reply.send(result);
      },
    ),

    route(
      "POST",
      "/v1/sync/acknowledgements",
      "acknowledgement",
      "transaction-scoped-operation",
      async (request: FastifyRequest, reply: FastifyReply) => {
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
        const body = request.body as { greatestContiguousCursor: string };
        const result = await protectedOperation(
          options.database,
          options.auth,
          options.hostedAuthorizer,
          request,
          "acknowledgement",
          (client, auth) =>
            acknowledgeCursor(client, auth, body.greatestContiguousCursor),
        );
        return reply.send(result);
      },
    ),

    route(
      "GET",
      "/v1/sync/capabilities",
      "capabilities",
      "transaction-scoped-operation",
      async (request: FastifyRequest, reply: FastifyReply) => {
        if (!options.database || !options.recovery) {
          return reply.code(503).send(unavailable("capabilities", request.id));
        }
        const result = await protectedOperation(
          options.database,
          options.auth,
          options.hostedAuthorizer,
          request,
          "capabilities",
          (client, auth) => getCapabilities(client, auth, options.recovery!),
        );
        return reply.send(result);
      },
    ),

    route(
      "POST",
      "/v1/sync/rebootstrap",
      "start-rebootstrap",
      "transaction-scoped-operation",
      async (request: FastifyRequest, reply: FastifyReply) => {
        if (!options.database || !options.recovery) {
          return reply
            .code(503)
            .send(unavailable("start-rebootstrap", request.id));
        }
        const result = await protectedOperation(
          options.database,
          options.auth,
          options.hostedAuthorizer,
          request,
          "start-rebootstrap",
          (client, auth) =>
            startRebootstrap(
              client,
              auth,
              request.body as never,
              options.recovery!,
            ),
        );
        return reply.send(result);
      },
    ),

    route(
      "GET",
      "/v1/sync/rebootstrap/:sessionId",
      "query-rebootstrap",
      "transaction-scoped-operation",
      async (request: FastifyRequest, reply: FastifyReply) => {
        if (!options.database || !options.recovery) {
          return reply
            .code(503)
            .send(unavailable("query-rebootstrap", request.id));
        }
        const params = request.params as { sessionId: string };
        const result = await protectedOperation(
          options.database,
          options.auth,
          options.hostedAuthorizer,
          request,
          "query-rebootstrap",
          (client, auth) =>
            getRebootstrapStatus(
              client,
              auth,
              params.sessionId,
              options.recovery!,
            ),
        );
        return reply.send(result);
      },
    ),

    route(
      "GET",
      "/v1/sync/rebootstrap/:sessionId/chunks/:index",
      "download-rebootstrap-chunk",
      "transaction-scoped-operation",
      async (request: FastifyRequest, reply: FastifyReply) => {
        if (!options.database || !options.recovery) {
          return reply
            .code(503)
            .send(unavailable("download-rebootstrap-chunk", request.id));
        }
        const params = request.params as { sessionId: string; index: string };
        const result = await protectedOperation(
          options.database,
          options.auth,
          options.hostedAuthorizer,
          request,
          "download-rebootstrap-chunk",
          (client, auth) =>
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
    ),

    route(
      "POST",
      "/v1/sync/rebootstrap/:sessionId/complete",
      "complete-rebootstrap",
      "transaction-scoped-operation",
      async (request: FastifyRequest, reply: FastifyReply) => {
        if (!options.database || !options.recovery) {
          return reply
            .code(503)
            .send(unavailable("complete-rebootstrap", request.id));
        }
        const params = request.params as { sessionId: string };
        const body = request.body as Record<string, unknown>;
        const result = await protectedOperation(
          options.database,
          options.auth,
          options.hostedAuthorizer,
          request,
          "complete-rebootstrap",
          (client, auth) =>
            completeRebootstrap(
              client,
              auth,
              { ...body, recoverySessionId: params.sessionId } as never,
              options.recovery!,
            ),
        );
        return reply.send(result);
      },
    ),
  );

  assertRouteDescriptors(routes, Boolean(options.hosted));
  for (const descriptor of routes) {
    app.route({
      method: descriptor.method,
      url: descriptor.path,
      handler: descriptor.handler,
    });
  }
  assertFastifyRouteInventory(app, routes);

  return app;
}

async function protectedOperation<T>(
  database: Database,
  authVerifier: AuthVerifier,
  authorizer: HostedTransactionAuthorizer | undefined,
  request: Parameters<AuthVerifier["verify"]>[0],
  operation: string,
  action: (client: PoolClient, auth: AuthContext) => Promise<T>,
): Promise<T> {
  if (authorizer) {
    return authorizer.authorizeOperation(request, operation, action);
  }
  const auth = await authVerifier.verify(request);
  return inTransaction(database, auth, (client) => action(client, auth));
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
      "select markei_required_migration_present($1) as ready",
      ["005_hosted_authorization_fence"],
    );
    return result.rows[0]?.ready ? "ready" : "not-ready";
  } catch {
    return "not-ready";
  }
}

function route(
  method: RouteDescriptor["method"],
  path: string,
  operation: string,
  authorizationClass: AuthorizationClass,
  handler: RouteDescriptor["handler"],
): RouteDescriptor {
  return { method, path, operation, authorizationClass, handler };
}

function sendHostedResult(reply: FastifyReply, result: unknown) {
  if (isProtocolFailure(result)) {
    return reply.code(statusForFailure(result)).send(result);
  }
  return reply.send(result);
}

function isProtocolFailure(result: unknown): result is ProtocolFailure {
  return (
    Boolean(result) &&
    typeof result === "object" &&
    typeof (result as ProtocolFailure).code === "string" &&
    (result as ProtocolFailure).outcome === "not-applied"
  );
}

function statusForFailure(failure: ProtocolFailure): number {
  if (failure.code === "conflict") return 409;
  if (failure.code === "service-unavailable") return 503;
  return 400;
}

function assertRouteDescriptors(
  routes: RouteDescriptor[],
  hostedEnabled: boolean,
) {
  const expected = ROUTE_AUTHORIZATION_DESCRIPTORS.filter(
    (descriptor) => hostedEnabled || !descriptor.hostedOnly,
  );
  const expectedKeys = expected.map(descriptorKey).sort();
  const actualKeys = routes.map(descriptorKey).sort();
  if (new Set(actualKeys).size !== actualKeys.length) {
    throw new Error("duplicate route authorization descriptor");
  }
  if (JSON.stringify(actualKeys) !== JSON.stringify(expectedKeys)) {
    throw new Error("route authorization inventory mismatch");
  }
}

function assertFastifyRouteInventory(
  app: FastifyInstance,
  routes: RouteDescriptor[],
) {
  for (const descriptor of routes) {
    if (!app.hasRoute({ method: descriptor.method, url: descriptor.path })) {
      throw new Error(
        `route missing from Fastify inventory: ${descriptorKey(descriptor)}`,
      );
    }
  }
}

function descriptorKey(
  descriptor: Pick<
    RouteDescriptor,
    "method" | "path" | "operation" | "authorizationClass"
  >,
) {
  return `${descriptor.method} ${descriptor.path} ${descriptor.operation} ${descriptor.authorizationClass}`;
}
