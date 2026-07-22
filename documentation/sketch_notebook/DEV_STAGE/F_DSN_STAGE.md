# F_DSN_STAGE — Protected Submission Failure Boundary

> Unit: C10-MCG02-SUBMISSION-500-DIAGNOSIS_20260722
> Sequence: FLX-ORD-01
> Authority: Main Chat
> Status: READY FOR MATERIALIZATION

## 1. Architecture objective

Trace and correct the smallest failing boundary in the existing dependency direction:

```text
Closure retry command
  -> token/authentication port
  -> Sync coordinator and exact stored submission
  -> HTTP Sync transport
  -> Fastify protected route
  -> hosted authorization
  -> transaction/context boundary
  -> Sync application service
  -> PostgreSQL adapter
```

The widget must not gain HTTP, provider or database knowledge. The client diagnostic ledger remains a
record of client-observed evidence; structured server logs remain server-observed evidence; Main
reconciliation may correlate them without merging their ownership.

## 2. Failure localization

Instrument or refine bounded stage observation at the actual boundaries. A lifecycle event may be
emitted only after that boundary is crossed. In particular, do not infer transaction start from
operation validation, and do not infer rollback merely from a final `500` unless the transaction
adapter observed it.

Preserve one transient correlation value from client request through server completion. Persist and
display only its existing short fingerprint. Logging failures must not affect response or transaction
behavior.

## 3. Error mapping

Keep domain/protocol failures separate from unexpected implementation failures:

- typed authentication, validation, conflict and sequence outcomes retain their bounded responses;
- database failures roll back and map through a stable sanitized class;
- unexpected defects return a bounded `500` without raw details;
- structured logging records the true terminal status and observed stage;
- the client maps an observed response by status/protocol and maps a missed deadline as client-side
  observation loss without claiming non-application.

The `request-failed status 200` / final `500` inconsistency must be removed at its source, not hidden
in presentation.

## 4. Timing boundary

Treat server processing time and client observation deadline as separate policies. Tests must cover
response completion on both sides of the deadline. Any deadline adjustment must remain finite,
cancellable and owned by the transport/application layer, not the widget. It must not turn a server
defect into apparent success or weaken exact-idempotent retry behavior.

## 5. Database and migration boundary

Prefer correction in current application/adapter code when schema contracts are already correct. If
local fresh/upgrade reproduction proves a schema defect, add one forward-only migration after 006.
Keep ownership, search path, RLS and runtime least privilege explicit. Never edit 001–006 or grant the
runtime role broad schema/role capability.

## 6. Preserved invariants

Preserve:

- original Submission identity, request hash, ordered membership and events 1–2;
- immutable Account/Device/Event identity and Device sequences;
- unknown-outcome semantics until a stable terminal result is observed and persisted;
- JWT/JWKS, hosted authorization, route inventory and callback validation;
- RLS and runtime/migrator separation;
- sanitized correlation and no-secret logging;
- offline-first operation and Closure/Settings separation.

## 7. Design evidence required in I

Report:

- the exact failing call boundary and reproduction;
- changed ports/adapters/services and dependency direction;
- error-to-status and lifecycle-event mapping;
- transaction/rollback/commit observation placement;
- deadline decision and cancellation behavior;
- schema/migration decision;
- preserved invariants, validation and residual risks.
