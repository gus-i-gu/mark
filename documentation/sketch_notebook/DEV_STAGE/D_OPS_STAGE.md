# D_OPS_STAGE — C10-S03A-R2 Operational Materialization Authority

> Sequence: FLX-INV-02 → Codex materialization
> Baseline: `34bc032df26d4b6d727d3ba6f2e08bbb0b11e13f`
> Joint authority: J + D/E/F
> Boundary: local disposable proof only

## 1. Objective

Correct the contradicted R1 authorization, JWT/JWKS, route-registration and Flutter enrollment paths,
then prove them through deterministic local execution. Do not contact providers.

Required terminal result:

```text
C10-S03A_R2_LOCAL_SECURITY_PROVED
MCG-02_PROVIDER_PROOF_PENDING
```

If any decisive gate is incomplete, report `C10-S03A_R2_PARTIAL` and the exact blocker.

## 2. Repository safety

1. Confirm branch `intermid-cycle-recovery` and baseline ancestry.
2. Fetch and pull fast-forward-only.
3. Inspect status before editing; preserve unrelated/untracked files.
4. Never stash, clean, reset, discard, force-push or overwrite user work.
5. Stop on divergence, overlap, J/D/E/F contradiction or provider dependency.
6. Read no local Neon/Auth0/Render secret files.

## 3. Checkpoint O1 — Migration 005

Add one forward-only migration with the next repository-consistent identifier. Never edit 001–004.

Migration 005 must provide:

- a security-definer authorization-fence function that resolves and row-locks active external
  identity and membership state for the caller transaction;
- a security-definer readiness function limited to checking the required migration identifier;
- fixed safe `search_path`, qualified objects, no dynamic SQL and bounded return columns;
- owner/mode verification;
- `PUBLIC` execute revocation and explicit runtime execute grants only;
- no runtime `UPDATE` on external identities or memberships;
- no runtime direct read/write of `migration_ledger`;
- transactional ledger entry and migration rollback on any failure.

Tests must prove fresh 001→005, upgrade 001→004→005, duplicate application/ledger behavior,
failure rollback, function ownership/modes and runtime denials.

The disposable lab may create roles. Codex must not create or alter Neon roles.

## 4. Checkpoint O2 — Transactional authorization

All hosted protected operations must use one explicit transaction-authorizer port. Remove hosted
feature detection and any fallback that can commit authorization before the protected callback.
Fixture-only auth may remain explicitly discriminated.

Inside one serializable transaction:

```text
authorization fence
→ exactly one active membership
→ Account/identity context
→ active actor enrollment + active actor Device lock
→ target policy/lock when applicable
→ operation context
→ protected mutation/read
→ commit
```

Bound retry to existing serialization/deadlock policy. Unknown failures roll back.

## 5. Checkpoint O3 — Device status/revocation

Implement the Main policy exactly:

- owner may manage same-Account target Devices;
- member may manage only the authenticated actor Device;
- actor Device must be active and bound to the principal identity;
- header and path identifiers have distinct roles;
- lock actor/target deterministically;
- cross-Account/foreign targets fail without enumeration;
- repeated revoke is idempotent;
- enrollment and Device state change atomically;
- at most one matching security event is inserted.

## 6. Checkpoint O4 — Route authorization inventory

Make one typed registry drive or mechanically wrap actual registration. Inventory every non-health
route and its class. Construction/tests must detect:

- unclassified route;
- duplicate method/path;
- wrong operation identifier;
- hosted route registered without its required authorizer;
- protected route reaching fixture/precommitted fallback.

Health routes remain bounded and unauthenticated.

## 7. Checkpoint O5 — JWT/JWKS

Implement deterministic injected-Clock behavior for:

- issuer-origin-bound production HTTPS JWKS URI;
- fresh cache and finite stale-if-error window;
- hard rejection after stale expiry;
- coalesced refresh and cooldown after failures;
- per-key negative cooldown after unchanged unknown-`kid` refresh;
- rejection of every duplicate `kid`;
- genuine key rotation;
- bounded timeout/abort, response bytes, key count and fields;
- generic public/log failure output.

Use `jose`; do not implement cryptography.

## 8. Checkpoint O6 — HTTP/Flutter interoperability

Server:

- return typed HTTP 409 for enrollment request-hash conflict;
- use 2xx only for successful typed enrollment/status results;
- keep unknown/unavailable outcomes non-successful and bounded.

Flutter:

- coordinator obtains one token per attempt and passes it into transport;
- transport never obtains a second token;
- token remains memory-only;
- use bounded timeout and streamed/bounded response reading;
- decode a closed success/failure schema;
- own or explicitly borrow/close the HTTP client;
- preserve local state/outbox on denial, timeout, malformed, oversized or unknown response.

## 9. Deterministic barrier matrix

Add test-only hooks/barriers without production sleeps. Every race uses bounded timeouts and
post-transaction state queries.

Required cases:

1. membership disable/remove against upload, download, acknowledgement and each recovery class;
2. external identity disable against a mutating protected operation;
3. actor Device revoke against upload/download/ack/recovery;
4. owner target revoke against member/owner status or revoke;
5. equivalent concurrent enrollments;
6. same request identity with different hash;
7. same installation with different request identities;
8. response loss after commit and query/replay;
9. restart after durable request state;
10. JWT cache expiry/outage/stale expiry/recovery;
11. unknown-key burst and genuine rotation;
12. denied operations leave facts/events/cursors/acks/sessions/security-event counts unchanged.

The controlled membership/identity writer must acquire the same migration-005 fence before update.

## 10. Least-privilege harness

Use disposable PostgreSQL with distinct generated migrator and runtime roles. Assert—not merely
configure—that:

```text
migrator current_user != runtime current_user
runtime cannot CREATE/ALTER/DROP schema objects
runtime cannot create/alter/grant roles
runtime cannot directly read/write migration_ledger
runtime cannot mutate external identities/memberships
runtime cannot invoke worker snapshot/cleanup authority
runtime without context sees no tenant facts
cross-Account and cross-Device access is denied
readiness succeeds only through the narrow function
Fastify receives only the runtime pool
```

Do not print connection strings, passwords, tokens, claims, facts or JWKS documents.

## 11. Real Flutter proof

Run a real `HttpDeviceEnrollmentTransport` against loopback Fastify, not a fake transport. Use a
file-backed Drift database and prove:

- successful enrollment and equivalent query/replay;
- 409 conflict maps to `conflict` without accepted local mutation;
- timeout/malformed/oversized response maps to unknown/unavailable safely;
- coordinator token is the request bearer token, without logging it;
- a real pending outbox row and authoritative local facts are unchanged by failure;
- enrollment progress and result survive close/reopen;
- HTTP client/service/database teardown completes.

## 12. Truthful diagnostic ownership

Each diagnostic must be emitted only after its own assertions pass. A TypeScript process cannot
claim Flutter proof unless an explicit aggregator executes and consumes the Flutter gate.

Recommended diagnostics:

```text
AUTHORIZATION_RACE_MATRIX=true
ROUTE_AUTHORIZATION_INVENTORY=true
JWT_JWKS_FAILURE_FLOOR=true
LEAST_PRIVILEGE_HTTP=true
FLUTTER_HOSTED_HTTP=true
R2_LOCAL_SECURITY_PROVED=true
```

Skipped gates must never print `true`.

## 13. Validation floor

Run, where applicable:

```text
npm run format:check
npm run lint
npm run typecheck
npm test
npm run build
npm audit --omit=dev
explicit migration/dual-role/race/hosted-local harness
dart format --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build apk --debug
flutter build windows --release (host-supported)
python -m unittest discover -s tests
git diff --check
tracked/staged secret scan
disposable-resource teardown verification
```

Record exact commands, environments, counts, pass/fail and exclusions. Builds do not prove runtime
acceptance. Host-blocked checks remain host-unvalidated.

## 14. Reports, commit and stopping rules

Replace only G/H/I as reports. G must include baseline/final SHA, Git-derived changed paths,
migration identifier/checksum, exact validation, role denials, barrier results, HTTP/file-reopen
evidence, diagnostic producers, secret scan and teardown.

Do not edit permanent memory, methodology, A/B/C, J or unrelated code. Do not contact providers,
deploy, install Auth0 SDKs, implement production signup/UI, begin MCG-03/04 or claim Cycle closure.

Commit one bounded R2 unit and push only `intermid-cycle-recovery` without force. Stop and report
partial on any privilege broadening, migration mutation, non-deterministic race proof, provider
dependency, secret exposure or decisive failing gate.
