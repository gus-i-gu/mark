import { createHash, randomUUID } from "node:crypto";
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

export type LifecycleLogEvent = {
  timestamp: string;
  event:
    | "request-received"
    | "operation-validation-started"
    | "authentication-accepted"
    | "authentication-rejected"
    | "database-transaction-started"
    | "response-completed"
    | "request-failed";
  routeClass: string;
  operation: string;
  method: string;
  correlationFingerprint: string;
  elapsedBand?: string;
  status?: number;
  result?: string;
};

export type LifecycleObserver = (event: LifecycleLogEvent) => void;

export type AuthorizationComposition =
  | {
      kind: "hosted";
      identityService: HostedIdentityService;
      transactionAuthorizer: HostedTransactionAuthorizer;
    }
  | { kind: "fixture"; verifier: AuthVerifier }
  | { kind: "disabled" };

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
  authorization: AuthorizationComposition;
  database?: Database;
  recovery?: RecoveryComposition;
  lifecycleObserver?: LifecycleObserver;
  registerUnclassifiedRouteForTest?: (app: FastifyInstance) => void;
}) {
  const lifecycleObserver = options.lifecycleObserver;
  const requestStarts = new WeakMap<FastifyRequest, number>();
  const app = Fastify({
    logger: false,
    genReqId: (request) =>
      sanitizeCorrelation(
        Array.isArray(request.headers["x-correlation-id"])
          ? request.headers["x-correlation-id"][0]
          : request.headers["x-correlation-id"],
      ) ?? randomUUID(),
  });
  const actualRoutes: Array<{ method: string; path: string }> = [];
  app.addHook("onRoute", (routeOptions) => {
    const methods = Array.isArray(routeOptions.method)
      ? routeOptions.method
      : [routeOptions.method];
    for (const method of methods) {
      actualRoutes.push({
        method: method.toUpperCase(),
        path: routeOptions.url,
      });
    }
  });

  app.get("/health/live", async () => ({ status: "live" }));
  app.get("/health/ready", async () => ({
    status: await readyStatus(options.database),
  }));
  app.register(sensible);
  app.addHook("onRequest", async (request) => {
    requestStarts.set(request, Date.now());
    emitLifecycle(lifecycleObserver, {
      event: "request-received",
      request,
    });
  });
  app.addHook("preValidation", async (request) => {
    emitLifecycle(lifecycleObserver, {
      event: "operation-validation-started",
      request,
    });
  });
  app.addHook("onResponse", async (request, reply) => {
    emitLifecycle(lifecycleObserver, {
      event: "response-completed",
      request,
      status: reply.statusCode,
      elapsedMs: Date.now() - (requestStarts.get(request) ?? Date.now()),
    });
  });
  app.addHook("onError", async (request, reply) => {
    emitLifecycle(lifecycleObserver, {
      event: "request-failed",
      request,
      status: reply.statusCode,
      elapsedMs: Date.now() - (requestStarts.get(request) ?? Date.now()),
    });
  });

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
  if (options.authorization.kind === "hosted") {
    routes.push(
      route(
        "GET",
        "/v1/identity",
        "identity-resolution",
        "principal-only",
        async (request: FastifyRequest) =>
          options.authorization.kind === "hosted"
            ? options.authorization.identityService.identity(request)
            : unreachableHostedRoute(),
      ),
      route(
        "POST",
        "/v1/devices/enroll",
        "enroll-device",
        "active-membership",
        async (request: FastifyRequest, reply: FastifyReply) => {
          if (options.authorization.kind !== "hosted") {
            return unreachableHostedRoute();
          }
          const result = await options.authorization.identityService.enroll(
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
          if (options.authorization.kind !== "hosted") {
            return unreachableHostedRoute();
          }
          const result =
            await options.authorization.identityService.enrollmentStatus(
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
          return options.authorization.kind === "hosted"
            ? options.authorization.identityService.deviceStatus(
                request,
                params.deviceId,
              )
            : unreachableHostedRoute();
        },
      ),
      route(
        "POST",
        "/v1/devices/:deviceId/revoke",
        "device-revoke",
        "active-actor-device-management",
        async (request: FastifyRequest) => {
          const params = request.params as { deviceId: string };
          return options.authorization.kind === "hosted"
            ? options.authorization.identityService.revoke(
                request,
                params.deviceId,
              )
            : unreachableHostedRoute();
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
          options.authorization,
          request,
          "upload-submission",
          (client, auth) =>
            acceptSubmission(client, auth, request.body as never, request.id),
          lifecycleObserver,
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
          options.authorization,
          request,
          "download-events",
          (client, auth) =>
            downloadEvents(
              client,
              auth,
              query.after,
              Number(query.limit ?? 25),
            ),
          lifecycleObserver,
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
          options.authorization,
          request,
          "acknowledgement",
          (client, auth) =>
            acknowledgeCursor(client, auth, body.greatestContiguousCursor),
          lifecycleObserver,
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
          options.authorization,
          request,
          "capabilities",
          (client, auth) => getCapabilities(client, auth, options.recovery!),
          lifecycleObserver,
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
          options.authorization,
          request,
          "start-rebootstrap",
          (client, auth) =>
            startRebootstrap(
              client,
              auth,
              request.body as never,
              options.recovery!,
            ),
          lifecycleObserver,
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
          options.authorization,
          request,
          "query-rebootstrap",
          (client, auth) =>
            getRebootstrapStatus(
              client,
              auth,
              params.sessionId,
              options.recovery!,
            ),
          lifecycleObserver,
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
          options.authorization,
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
          lifecycleObserver,
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
          options.authorization,
          request,
          "complete-rebootstrap",
          (client, auth) =>
            completeRebootstrap(
              client,
              auth,
              { ...body, recoverySessionId: params.sessionId } as never,
              options.recovery!,
            ),
          lifecycleObserver,
        );
        return reply.send(result);
      },
    ),
  );

  assertRouteDescriptors(routes, options.authorization.kind === "hosted");
  for (const descriptor of routes) {
    app.route({
      method: descriptor.method,
      url: descriptor.path,
      handler: descriptor.handler,
    });
  }
  options.registerUnclassifiedRouteForTest?.(app);
  app.addHook("onReady", async () => {
    assertFastifyRouteInventory(actualRoutes, routes);
  });

  return app;
}

async function protectedOperation<T>(
  database: Database,
  authorization: AuthorizationComposition,
  request: FastifyRequest,
  operation: string,
  action: (client: PoolClient, auth: AuthContext) => Promise<T>,
  lifecycleObserver?: LifecycleObserver,
): Promise<T> {
  if (authorization.kind === "hosted") {
    try {
      const result =
        await authorization.transactionAuthorizer.authorizeOperation(
          request,
          operation,
          action,
        );
      emitLifecycle(lifecycleObserver, {
        event: "authentication-accepted",
        request,
        operation,
        result: "accepted",
      });
      return result;
    } catch (error) {
      if (error instanceof HostedAuthError) {
        emitLifecycle(lifecycleObserver, {
          event: "authentication-rejected",
          request,
          operation,
          result: error.code,
        });
      }
      throw error;
    }
  }
  if (authorization.kind === "disabled") {
    emitLifecycle(lifecycleObserver, {
      event: "authentication-rejected",
      request,
      operation,
      result: "authentication-required",
    });
    throw new HostedAuthError("authentication-required", 401);
  }
  let auth: AuthContext;
  try {
    auth = await authorization.verifier.verify(request);
    emitLifecycle(lifecycleObserver, {
      event: "authentication-accepted",
      request,
      operation,
      result: "accepted",
    });
  } catch {
    emitLifecycle(lifecycleObserver, {
      event: "authentication-rejected",
      request,
      operation,
      result: "authentication-required",
    });
    throw new HostedAuthError("authentication-required", 401);
  }
  emitLifecycle(lifecycleObserver, {
    event: "database-transaction-started",
    request,
    operation,
  });
  return inTransaction(database, auth, (client) => action(client, auth));
}

type PendingLifecycleEvent = {
  event: LifecycleLogEvent["event"];
  request: FastifyRequest;
  operation?: string;
  status?: number;
  result?: string;
  elapsedMs?: number;
};

function emitLifecycle(
  observer: LifecycleObserver | undefined,
  pending: PendingLifecycleEvent,
) {
  if (!observer) return;
  try {
    observer({
      timestamp: new Date().toISOString(),
      event: pending.event,
      routeClass: routeClass(pending.request),
      operation: pending.operation ?? operationClass(pending.request),
      method: pending.request.method,
      correlationFingerprint: shortCorrelationFingerprint(pending.request.id),
      elapsedBand:
        pending.elapsedMs === undefined
          ? undefined
          : bandElapsed(pending.elapsedMs),
      status: pending.status,
      result: pending.result,
    });
  } catch {
    // Observability must not change protocol behavior.
  }
}

export function consoleLifecycleObserver(): LifecycleObserver {
  return (event) => {
    console.info(JSON.stringify(event));
  };
}

function unreachableHostedRoute(): never {
  throw new HostedAuthError("forbidden", 403);
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

function sanitizeCorrelation(value: string | undefined) {
  if (!value) return undefined;
  const sanitized = value.replace(/[^\w.:-]/g, "").slice(0, 96);
  return sanitized || undefined;
}

function shortCorrelationFingerprint(value: string) {
  return createHash("sha256")
    .update(sanitizeCorrelation(value) ?? "")
    .digest("hex")
    .slice(0, 8);
}

function bandElapsed(elapsedMs: number) {
  if (elapsedMs < 250) return "lt-250ms";
  if (elapsedMs < 1000) return "lt-1s";
  if (elapsedMs < 3000) return "lt-3s";
  if (elapsedMs < 10000) return "lt-10s";
  if (elapsedMs < 30000) return "lt-30s";
  return "gte-30s";
}

function routeClass(request: FastifyRequest) {
  const path = request.routeOptions.url ?? "";
  if (path.startsWith("/health/")) return path;
  if (path.startsWith("/v1/sync/rebootstrap/")) {
    if (path.endsWith("/chunks/:index")) {
      return "/v1/sync/rebootstrap/:sessionId/chunks/:index";
    }
    if (path.endsWith("/complete")) {
      return "/v1/sync/rebootstrap/:sessionId/complete";
    }
    return "/v1/sync/rebootstrap/:sessionId";
  }
  if (path.startsWith("/v1/devices/enrollments/")) {
    return "/v1/devices/enrollments/:requestId";
  }
  if (path.startsWith("/v1/devices/") && path.endsWith("/status")) {
    return "/v1/devices/:deviceId/status";
  }
  if (path.startsWith("/v1/devices/") && path.endsWith("/revoke")) {
    return "/v1/devices/:deviceId/revoke";
  }
  return path || "unclassified";
}

function operationClass(request: FastifyRequest) {
  const route = routeClass(request);
  if (route === "/health/live") return "health-live";
  if (route === "/health/ready") return "health-ready";
  const descriptor = ROUTE_AUTHORIZATION_DESCRIPTORS.find(
    (item) => item.path === route && item.method === request.method,
  );
  return descriptor?.operation ?? "unclassified";
}

async function readyStatus(database: Database | undefined) {
  if (!database) return "not-ready";
  try {
    const result = await database.pool.query(
      "select public.markei_hosted_runtime_ready() as ready",
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
  actualRoutes: Array<{ method: string; path: string }>,
  routes: RouteDescriptor[],
) {
  const expected = routes
    .map((route) => `${route.method} ${route.path}`)
    .sort();
  const actual = normalizeActualRoutes(actualRoutes).sort();
  if (new Set(actual).size !== actual.length) {
    throw new Error("duplicate actual route registration");
  }
  if (JSON.stringify(actual) !== JSON.stringify(expected)) {
    throw new Error("actual route authorization inventory mismatch");
  }
}

function normalizeActualRoutes(
  routes: Array<{ method: string; path: string }>,
) {
  const raw = routes
    .filter((route) => !isHealthRoute(route))
    .map((route) => `${route.method} ${route.path}`);
  const getRoutes = new Set(
    raw
      .filter((key) => key.startsWith("GET "))
      .map((key) => key.replace(/^GET /, "")),
  );
  return raw.filter((key) => {
    if (!key.startsWith("HEAD ")) return true;
    return !getRoutes.has(key.replace(/^HEAD /, ""));
  });
}

function isHealthRoute(route: { method: string; path: string }) {
  return (
    (route.method === "GET" || route.method === "HEAD") &&
    (route.path === "/health/live" || route.path === "/health/ready")
  );
}

function descriptorKey(
  descriptor: Pick<
    RouteDescriptor,
    "method" | "path" | "operation" | "authorizationClass"
  >,
) {
  return `${descriptor.method} ${descriptor.path} ${descriptor.operation} ${descriptor.authorizationClass}`;
}
