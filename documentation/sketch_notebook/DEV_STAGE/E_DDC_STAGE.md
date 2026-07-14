# E_DDC_STAGE — C10-S01 Synchronization Semantics Contract

> Status: ACTIVE — CODEX IMPLEMENTATION AUTHORIZED WITH D/F
> Scope: project language, typed outcomes, privacy and recovery semantics
> Learner maturity: unchanged
> Cycle 11 visual/interaction design: protected

## 1. Semantic objective

Materialize truthful protocol/application vocabulary for one local `purchase.registered` proof.
Code, contracts, tests and minimal diagnostic output must distinguish local persistence, transport,
server acceptance, peer application, acknowledgement, conflict and unknown outcome.

No new polished page, banner system, synchronization dashboard, accessibility redesign or target-
image composition is authorized. Cycle 10 tests may observe results through typed objects, lab tools
and minimal existing-surface diagnostics only when required by D/F.

## 2. Required distinctions

```text
Account          != local-account placeholder != Person != Device
Installation     != Device != hardware identifier
EventId          != SubmissionId != DeviceSequence != ServerCursor
saved locally    != queued != uploading != accepted by server
server accepted  != applied by another Device != acknowledged by all eligible Devices
duplicate        != conflict != validation failure
offline          != unreachable != authentication failure
synchronization  != export != backup
server retention != analytics or unrelated developer use
```

Never expose Device UUID as a secret or claim it authenticates the Device.

## 3. Stable status codes and meanings

| Code | Meaning | Required user-safe explanation |
| --- | --- | --- |
| `saved-local` | fact committed only to this local DB | Saved on this device; it may not exist elsewhere. |
| `waiting-upload` | durable outbox Event has no active attempt | Safe locally; waiting for a future attempt. |
| `uploading` | one transport attempt is active | Local fact remains safe; acceptance is not known yet. |
| `server-accepted` | server durably accepted or equivalent-duplicated Event | Another Device may not have applied it. |
| `waiting-peer` | accepted but named eligible peer has not acknowledged | Offline Devices can be behind. |
| `downloaded-applied` | inbox/facts/cursor committed locally | This Device now contains the update. |
| `duplicate-ignored` | equivalent replay caused no second effect | Existing accepted/applied result was reused. |
| `conflict` | same identity disagrees or entity policy cannot apply both facts | No automatic merge; preserve facts and recovery evidence. |
| `auth-required` | credentials absent/expired/rejected | Sign-in/auth configuration is required; not an offline error. |
| `device-revoked` | authenticated Account cannot use this Device identity | Stop retry; enrollment recovery is required. |
| `cursor-expired` | requested history is no longer directly available | Stop incremental apply; explicit rebootstrap is required. |
| `protocol-upgrade-required` | version is unsupported | Update/migrate before retrying. |
| `unknown-outcome` | response was lost after request may have committed | Retry the same SubmissionId; do not create replacement facts. |

Internal storage enum names do not earn these claims unless the corresponding operation exists.

## 4. Typed protocol failure shape

Every API/application failure must provide machine-readable fields equivalent to:

```text
code
operation
field? / eventId? / submissionId?
outcome: applied | duplicate-equivalent | not-applied | unknown
retryable: true | false
safeAction
correlationId (non-secret)
```

Raw exceptions, SQL details, stack traces, credentials and payload content never cross into client
messages. HTTP status alone is insufficient. Unknown outcomes must explicitly preserve the same
retry identity.

Required mappings include validation, unauthorized, forbidden Account, unknown/revoked Device,
sequence gap, hash mismatch, duplicate-equivalent, protocol version, batch/size limit, cursor expiry,
serialization retry exhausted, service unavailable and internal unknown.

## 5. Event and aggregate language

`purchase.registered` v3 is an immutable fact that a Purchase aggregate was registered by one
Device for one Account. It contains stable IDs and complete facts needed to reproduce the aggregate.

It does not mean:

- the Purchase was edited or deleted;
- the server owns the only copy;
- every Device has applied it;
- Product identity may be merged automatically;
- Lists projections should be transmitted as facts.

When a Product/code/exact-identity collision differs in content, use `conflict`; do not say
“similar product” or silently select one. Optional Person/Payment absence remains valid.

## 6. Privacy and logging contract

Minimum truthful development disclosure:

> The C10-S01 lab uses synthetic data and a local disposable server. Normal Markei use remains
> local-only unless synchronization is explicitly configured in a later authorized unit.

Logs/reports may include non-secret IDs, status codes, cursor values, counts, timings and shortened
hashes. They must not include:

- database URLs, passwords, bearer/enrollment tokens or keys;
- complete request/response headers;
- Purchase/Product/Person/Payment payloads or notes;
- ordinary user database paths or screenshots containing user facts;
- misleading “anonymous analytics” claims.

No telemetry or developer analytics dependency is authorized.

## 7. Minimum recovery semantics

- Offline: local registration succeeds and queues one Event.
- Unreachable before commit: keep pending and retry according to bounded policy.
- Timeout after possible commit: mark unknown and retry same SubmissionId/EventIds.
- Equivalent duplicate: reuse stored response and do not duplicate facts.
- Hash/identity mismatch: terminal conflict; quarantine evidence; no retry-as-new.
- Download crash: replay safely because inbox+facts+cursor is one transaction.
- Cursor gap/expiry: stop; never silently jump; report rebootstrap required.
- Revoked Device: stop upload/ack; preserve local facts/outbox for explicit recovery.
- API absent: app remains usable locally; no destructive fallback/reset.

## 8. Lab/test naming

Use neutral synthetic labels such as `test-account`, `device-a`, `device-b`, `purchase-a` only in
fixtures. Do not reuse real store, person, payment or purchase data.

Test names must describe evidence boundaries, for example:

- `server acceptance does not claim peer application`;
- `unknown outcome retries same submission`;
- `duplicate event is applied once`;
- `cursor advances only with atomic apply`;
- `local registration works when transport is absent`.

## 9. Cycle 11 boundary

Do not decide cards, banners, icons, colors, navigation, background-sync controls, pairing screens,
Device-management pages, status history, accessibility composition or final user copy placement.

If minimal diagnostic text is needed for a test, keep it semantically correct and visually neutral.
Do not expand Home/Lists/Purchase/History/Catalogue layouts.

## 10. H evidence requirements

Replace only `DEV_STAGE/H_DDC_CODEX.md`. Report:

- terms/codes materialized and exact owning files;
- tests proving distinct state meanings;
- user-visible or diagnostic copy added, if any;
- privacy/log-redaction evidence;
- misleading terms removed or retained;
- Cycle 11 surfaces intentionally untouched;
- learner maturity unchanged;
- skipped live-provider and production-auth semantics.

## 11. Acceptance

E is satisfied only when automated tests prevent conflating local save, server acceptance, peer
application and acknowledgement; failures preserve retry/recovery meaning; logs are payload/secret
safe; and no project test is promoted as learner mastery or polished UX acceptance.
