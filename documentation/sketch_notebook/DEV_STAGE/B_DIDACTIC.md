<!-- TEMPORAL_MARKER:C10-S01B-DIDACTIC-INVESTIGATION-2026-07-14 -->

# B_DIDACTIC — C10-S01B Local Synchronization Convergence Completion

> Sequence: FLX-INV-02
> Role: Didactic/UX Chat [A]
> Round or unit: C10-S01B
> Branch: `intermid-cycle-recovery`
> Baseline / inspected HEAD: `1af8137e3f7db2d5ee3ecdf3796ae62808e0717c`
> Authority: Didactic/UX investigation only
> Writable surface: this file only
> Knowledge state: candidate / proposed / provisional
> Materialization authority: none
> Learner maturity: unchanged

## 1. Methodology retained

The complete route `INDEX → METHOD_FOUNDATIONS → FLUX → PROMOTION_RULES → CHAT_PROTOCOL` was loaded directly after both Agent Contracts.

Retained constraints:

- Didactic observes project behavior as learning and semantic meaning;
- this functional stage is provisional and cannot become canon by repetition;
- implementation evidence proves only the named repository behavior;
- passing tests do not prove wider runtime, provider, release or learner acceptance;
- source evidence must not advance KANBAN status without learner explanation, prediction or transfer evidence;
- no lecture-history event is authorized;
- only `DEV_STAGE/B_DIDACTIC.md` may be replaced;
- source, tests, permanent Didactic memory, Main stages and other domain stages remain untouched;
- Cycle 11 presentation work is outside this unit.

PRC-01 distinctions remain controlling: declared, implemented, executable, validated, blocked and deferred are not interchangeable.

## 2. Inspected semantic evidence

The inspected contracts and implementation establish:

- `SyncEvent` carries one complete Purchase payload, stable event identity, Account, Device, DeviceSequence, version and content hash;
- local Purchase registration can create a durable local Purchase, immutable event and pending outbox fact;
- an outbox lease creates or reuses a `SubmissionId` and moves pending rows to an uploading state;
- an unknown upload outcome can preserve the same Submission identity for retry;
- upload-result persistence can record accepted, unknown or failed local submission state;
- the API protocol declares typed outcome, retryability, safe action and correlation identity;
- the local inbox detects same EventId/same hash as duplicate-equivalent and different hash as conflict;
- inbox insertion and cursor recording occur in one local transaction;
- the API/PostgreSQL layer has server acceptance, sequence and isolation foundations;
- fixture authentication is limited to direct tests; normal runtime has no production AuthVerifier;
- the two-device harness directly invokes local abstractions and does not prove HTTP/PostgreSQL transfer;
- local remote apply records inbox and cursor evidence but does not reconstruct Product, Store and Purchase facts;
- acknowledgement is represented by a port and test ordering rule, but is not materially exercised through a complete runtime route;
- download is represented by contracts and route vocabulary, but no complete Device A → API/PostgreSQL → Device B fact path is proven.

Therefore C10-S01 produced synchronization foundations, not complete convergence.

## 3. Implemented versus merely declared vocabulary

| Term | Current evidence | Truthful interpretation |
| --- | --- | --- |
| saved locally | implemented and directly tested | Purchase and event facts committed in one local database |
| queued / waiting upload | implemented and directly tested | durable pending outbox fact exists |
| uploading | implemented as local lease/state transition | an attempt has been prepared; transport success is not implied |
| server accepted | implemented on local/API result paths; server foundations tested | the server accepted a Submission; no peer application follows from this |
| waiting peer | enum/proposed vocabulary | no material peer-progress observation currently earns this state |
| downloaded | contract/route vocabulary; incomplete executable path | a page may be represented, but real HTTP retrieval is not established |
| facts applied | stubbed for the Purchase aggregate | inbox/cursor is written; Product/Store/Purchase reconstruction is absent |
| acknowledged | port/schema/proposed behavior | no complete client-to-server acknowledgement proof exists |
| duplicate ignored | executable local inbox behavior | the same EventId and content hash causes no second inbox effect |
| conflict | executable local hash mismatch behavior; broader policy proposed | one typed mismatch is detected; entity reconciliation is unresolved |
| converged | proposed acceptance state only | cannot be claimed at the inspected HEAD |
| synchronized | prohibited current product claim | foundations do not establish peer equality, backup or recovery |

`downloaded-applied` is currently too strong for aggregate semantics. Until Purchase facts are reconstructed, diagnostics should distinguish `download received` from `facts applied`.

## 4. Synchronization state/evidence matrix

| State or capability | Classification | Evidence boundary | Missing completion evidence |
| --- | --- | --- | --- |
| local Purchase save | implemented | Drift repository tests | none within local-save scope |
| immutable local event | implemented | repository inspection and tests | none within event-creation scope |
| pending outbox | implemented | Drift tests | none within queue scope |
| Submission identity | implemented | local repository and retry test | real timeout-after-server-commit replay |
| uploading state | executable but indirectly tested | lease transition | live transport observation |
| server acceptance | executable but indirectly integrated | API tests and PostgreSQL probes | Flutter HTTP upload against running API |
| stored replay result | implemented server concept | API-side tests | end-to-end uncertain retry |
| download route | stubbed / thin | route and port declarations | real server page returned to Device B |
| inbox deduplication | implemented | local tests | cross-process duplicate delivery |
| cursor advancement | implemented locally | transaction test | ordered server page and invalid-order rejection |
| complete Purchase apply | stubbed | payload exists; aggregate apply absent | Product, Store, references and Purchase reconstructed |
| acknowledgement | proposed / partially executable | port and ordering test | HTTP request, durable server ack and replay behavior |
| production authentication | externally blocked | fixture escape prevention | selected provider and production verifier |
| revoked Device handling | proposed / server vocabulary | failure contracts | production identity and revocation lifecycle |
| cross-process two-device harness | stubbed | local abstraction harness only | HTTP/PostgreSQL path with isolated Drift files |
| deterministic convergence | proposed | expected comparison criteria | reopened A/B fact and projection equality |
| MCG-01 | externally blocked | local provider-free evidence only | human Neon setup and reconciled redacted probe |
| MCG-02 | deferred behind MCG-01 | runtime prerequisites documented | deployable API and production auth boundary |
| Cycle 11 sync presentation | deferred | explicitly outside scope | Main-authorized UX unit |

## 5. Typed failures and safe-action hypotheses

Minimum diagnostics should be neutral, structured and non-visual. Each result should expose:

```text
operation
code
outcome: applied | duplicate-equivalent | not-applied | unknown
retryable: true | false
safeAction
correlationId
optional eventId / submissionId / field
```

Provisional failure meanings:

| Situation | Outcome | Retry | Safe action |
| --- | --- | --- | --- |
| timeout after request, commit unknown | unknown | yes | retry the same SubmissionId and identical request hash |
| same SubmissionId and same hash replayed | duplicate-equivalent | no | accept the stored result; do not create a new Submission |
| same SubmissionId with different hash | not-applied | no | stop and preserve local facts; report submission conflict |
| same EventId and same hash delivered twice | duplicate-equivalent | no | ignore the second effect and continue cursor processing |
| same EventId with different hash | not-applied | no | quarantine/stop; never overwrite automatically |
| cursor order invalid or gap observed | not-applied | policy-dependent | stop page application; retain previous cursor and request valid replay |
| remote Product/Store/Purchase collision | not-applied | no automatic retry | preserve both evidence sets and require a typed Main-approved policy |
| authentication unavailable | not-applied | after credentials restored | keep local work; require production authentication before transfer |
| Device revoked | not-applied | no automatic retry | stop network mutation; preserve local data and require re-enrolment policy |
| server unavailable before acceptance | not-applied | yes | keep queued facts and retry later |
| server outcome unavailable after timeout | unknown | yes | verify by replaying the identical Submission, not by creating a replacement |
| unsupported protocol version | not-applied | no | require a compatible client/server version |

No diagnostic may recommend deleting local facts, resetting the database, changing identity or issuing a new event merely to escape uncertainty.

## 6. Truthful convergence criteria

A complete Purchase is converged only when named evidence proves all of the following:

1. Device A commits the Purchase and its immutable event locally.
2. A uploads through the real Flutter transport to the running API.
3. PostgreSQL accepts the Submission atomically with Event, sequence and cursor state.
4. An unknown timeout is replayed with the same SubmissionId and returns the stored equivalent result.
5. Device B downloads the Event through the real HTTP route after its prior cursor.
6. B validates identity, version, hash and cursor order.
7. B atomically records inbox evidence, reconstructs Product, Store, references and Purchase facts, and advances its cursor.
8. A duplicate delivery causes no second Purchase or projection effect.
9. B sends the greatest contiguous applied cursor through the acknowledgement route.
10. The server durably records that Device acknowledgement.
11. Both clients close and reopen without losing the accepted facts.
12. Stable Purchase facts compare deterministically across A and B.
13. Rebuildable Lists derived from those facts compare under the same deterministic fixture.

Server acceptance alone proves step 3, not convergence. Inbox insertion plus cursor movement without Purchase reconstruction proves bookkeeping, not fact application.

## 7. Minimum neutral functional diagnostics

Cycle 10 tests need machine-readable or plain-text output only:

- fixture/device aliases, never personal labels;
- operation and typed code;
- SubmissionId/EventId aliases or redacted suffixes;
- cursor before/after;
- event counts, applied counts and duplicate counts;
- Purchase fact comparison pass/fail;
- acknowledgement cursor and server-recorded value;
- correlation ID and elapsed timing;
- retry identity equality;
- database reopen comparison;
- explicit `CONVERGED=false|true` based on the full criteria.

Do not log Purchase payloads, Product names, Store names, credentials, tokens, connection strings or raw authorization headers.

## 8. Privacy and secret-handling language

Truthful developer-facing wording:

`Neon is a managed PostgreSQL provider used only behind the Markei API. Flutter must never receive a database connection string or privileged database role. Connection strings, tokens and provider URLs belong only in local or deployment secret storage. Git, notebook files, chat, screenshots, test fixtures and ordinary logs may contain redacted aliases and pass/fail evidence, never secret values.`

Additional boundaries:

- provider configuration is coordination infrastructure, not user analytics;
- absence of analytics does not mean no synchronization payload reaches the API/database;
- relay persistence is not a backup guarantee;
- provider backups are not a Markei restore contract until explicitly designed and tested;
- Account isolation must derive from verified server identity, not payload AccountId;
- fixture authentication is synthetic test evidence and must never be described as production sign-in;
- provider region, role names, migration hash and timestamps may be reported only when non-secret.

## 9. MCG-01 and MCG-02 learning prerequisites

Before MCG-01, the developer must understand:

- Neon project/branch/database/role versus Git branch and Markei Account;
- migration role versus least-privilege runtime role;
- server-only connection strings and redacted evidence;
- provider limits, expiry, cost and teardown ownership;
- why a successful connection is not authorization or convergence;
- why no secret is needed in Flutter, Git or notebook memory.

Before MCG-02, the developer must additionally understand:

- client/API/database trust boundaries;
- production AuthVerifier responsibility;
- runtime secret injection versus public API endpoint configuration;
- TLS, deployment identity and migration separation;
- Account/Device authorization and revocation;
- retry identity, unknown outcome and idempotent replay;
- download/apply/ack order and the evidence required to call a Purchase converged.

Configuration success remains project evidence. It does not change learner maturity.

## 10. Misconceptions and misleading claims to avoid

- `server accepted` means neither peer-applied nor synchronized;
- `downloaded` means neither valid nor committed;
- inbox/cursor bookkeeping alone is not Purchase application;
- acknowledgement is not universal delivery;
- one Device acknowledgement is not all-Device convergence;
- synchronization is not backup, restore, export or disaster recovery;
- queued data is not uploaded data;
- retry is not creation of a new business event;
- duplicate-equivalent is not conflict;
- a Device UUID is not a credential or hardware fingerprint;
- fixture authentication is not production authentication;
- a local two-file harness is not a cross-process protocol proof;
- a server cursor is not a Device sequence or Purchase time;
- relay retention is not indefinite history;
- Neon availability is not Markei availability or recoverability;
- `all devices`, `everywhere`, `always delivered`, `fully backed up`, `recoverable` and `never lost` are prohibited without separate guarantees.

## 11. Cycle 10 / Cycle 11 boundary

C10-S01B may stabilize contracts, typed failures, test timelines and minimum diagnostics needed to prove functional truth.

It must not design pages, status dashboards, pairing or enrolment flows, navigation, banners, cards, icons, animations, visual polish, accessibility redesign, native sharing or Analytics.

Questions of placement, wording hierarchy, interaction timing, visual severity, progress display and user-controlled retry presentation belong to Cycle 11 after the underlying states become truthful.

## 12. Unresolved Main decisions

1. Exact invalid cursor-order and gap policy.
2. Entity-specific collision policy for Product, Store, references and Purchase.
3. Whether acknowledgement means persisted local apply, projection rebuild, or another boundary.
4. Which Devices count toward any future account-level convergence statement.
5. Device revocation, re-enrolment and historical acknowledgement eligibility.
6. Production AuthVerifier/provider selection and credential lifecycle.
7. Retention, cursor expiry, rebootstrap, snapshots and account deletion.
8. Exact safe action for terminal remote-fact conflict.
9. Whether derived Lists comparison is required inside MCG-01 or a later gate.
10. The exact Main acceptance evidence separating MCG-01 from MCG-02.

## 13. Disposition

```text
implemented:
  local save, event/outbox, Submission identity, local retry preservation,
  server acceptance foundations, local inbox deduplication and cursor bookkeeping

executable but indirectly tested:
  API/PostgreSQL acceptance components and some typed failure behavior

stubbed:
  real download, complete Purchase aggregate apply, acknowledgement and
  cross-process two-device convergence harness

proposed:
  typed safe actions, minimum neutral diagnostics and full convergence criteria

externally blocked:
  production authentication and MCG-01 Neon evidence

deferred:
  MCG-02 deployment work and all Cycle 11 presentation/UX refinement

learner maturity:
  unchanged; no KANBAN transition and no lecture-history entry authorized
```
