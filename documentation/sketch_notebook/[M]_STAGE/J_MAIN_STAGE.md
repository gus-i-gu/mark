# J_MAIN_STAGE — Hosted Transport Observability Coordination

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-TRANSPORT-OBSERVABILITY_20260721
> Required ancestor: `f8557105ad478c85c82b99b6b60b371d2cb9ddd8`
> Status: **TRANSPORT OBSERVABILITY D/E/F ACTIVE; SYNC BLOCKED**

## 1. Reconciled runtime evidence

The unknown-recovery implementation passed repository validation and its cancelled preflight passed
manual Windows verification. One subsequently authorized controlled retry was invoked exactly once.

After that invocation:

~~~text
local attempt: sync-interrupted / transport-or-closure
local unknown events: 2, Device sequences 1–2
next local Device sequence: 3
Render application request evidence: absent
Neon: accounts 1 / devices 1 / cursor 0 / submissions 0 / events 0 / acknowledgements 0
~~~

The events remain preserved and no hosted duplication or corruption is evidenced. The result does
not prove whether the request failed before transport, timed out during a sleeping-service wake,
reached Render's edge but not application logging, failed token acquisition, or stopped in local
Closure orchestration. `transport-or-closure` is therefore too broad for the next controlled test.

## 2. Source reconciliation

Repository inspection confirms three relevant conditions:

- the API already exposes `/health/live` and `/health/ready`;
- its Fastify composition currently disables logging with `logger: false`;
- Flutter Sync uses a five-second default transport timeout and Closure collapses the terminal
  interruption into one broad phase.

These facts make a free-instance cold start plausible but not proved. They also show that the
repository can gain decisive evidence without risking another submission: instrument the boundary
and exercise the existing health routes first.

## 3. Human operational decision

The human selects a paid Render web-service instance for Markei's early MVP phases because an
always-on hosted API is the sober operating baseline for continuing development. This is an
accepted environment/cost decision, not retroactive proof that sleeping caused the failed retry.

Codex must not purchase, configure or deploy the service. After implementation and reconciliation,
the human will apply the Render instance change and deploy through the existing controlled workflow.

## 4. Active unit

The next bounded unit is:

`C10-MCG02-TRANSPORT-OBSERVABILITY`

Only D/E/F bearing `C10-MCG02-TRANSPORT-OBSERVABILITY_20260721` authorize materialization.
G/H/I remain prior-unit observational evidence and must be replaced.

The unit must:

1. add a non-mutating Closure hosted-connection check using existing live/ready routes;
2. preserve exactly one sanitized durable diagnostic attempt per invocation;
3. distinguish token, request creation/start, response, parsing, timeout/cancellation, bounded
   transport failures, authorization rejection, protocol failure and local closure failure;
4. correlate the client display with sanitized hosted request lifecycle logs;
5. compare enrollment and Sync origin/path/deadline behavior;
6. preserve unknown-outcome and exact-retry identity semantics;
7. validate everything without contacting Auth0, Render or Neon.

## 5. Evidence classification

| Claim | Current state |
| --- | --- |
| Unknown recovery invocation occurred | Accepted local observational evidence |
| Events 1–2 were applied by hosted API | Not evidenced; Neon remained empty |
| Request never reached any Render boundary | Not proved; application logs are insufficient |
| Free Render sleeping caused the interruption | Plausible hypothesis only |
| Paid Render is selected for MVP operation | Accepted human operational decision |
| Existing health routes can support a safe probe | Repository fact; implementation pending |
| MCG-02 hosted convergence is complete | Rejected; Sync remains blocked |

## 6. Post-materialization gate

After Codex returns G/H/I:

1. Main reconciles the implementation, migration, privacy and validation evidence.
2. Human updates the Windows checkout and Render service instance/deployment through the existing
   private configuration workflow.
3. Human opens Closure and runs only `Check hosted connection` once.
4. Client and Render correlation fingerprints, stages and results are compared.
5. Neon counts remain read-only comparison evidence.
6. Only after live and ready checks are observable and the transport taxonomy is proven may Main
   consider one further exact-identity unknown retry.

Until then, do not press ordinary Sync, retry the unresolved submission, Enroll, Query, Clear
diagnostic history, edit the local database, or create new synchronized purchase work.

Success terminal for Codex:

`C10_MCG02_TRANSPORT_OBSERVABILITY_IMPLEMENTED`
