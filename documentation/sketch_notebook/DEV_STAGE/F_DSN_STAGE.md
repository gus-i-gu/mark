# F_DSN_STAGE — C10-S03A-R3C Design Materialization Authority

> Sequence: FLX-ORD-01
> Controlling reconciliation: `51e1db09e9c00bf2650d1cf791b571cfa4f6a0c6`
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Boundary: local proof architecture and narrow evidence-driven correction

## 1. Selected architecture

R3C adds proof infrastructure around accepted production components:

```text
deterministic transaction barriers and state observer
+ immutable migration scenario runner
+ loopback HTTP/file-backed Drift system harness
+ versioned producer records and fail-closed aggregator
```

It does not select a new runtime architecture.

## 2. Dependency direction

Retain:

```text
accepted application/domain contracts
    ↑
production adapters and authorization services
    ↑
test/lab composition and deterministic controls
    ↑
machine-readable producer records
    ↑
truthful aggregator
```

Test hooks depend inward on explicitly exposed test seams or lab composition; production code must
not depend on the harness, producer or aggregator.

No new package, lockfile version, migration or Drift schema is selected.

## 3. Authorization proof architecture

Use test-only barrier interfaces at named phases equivalent to:

```text
principal verified
before identity/membership fence
after membership lock
before actor-Device lock
before target transition
before protected mutation
before commit
```

Barriers are injected only by local lab/test composition. Normal hosted, fixture and disabled roots
must not expose externally controllable hooks.

Use a reusable Account-scoped state observer returning only stable IDs, positions and counts for:

```text
facts/events
cursors/acknowledgements
recovery sessions/chunks
Devices/enrollments
security events
```

The observer compares before/after snapshots without logging fact content. Each scenario owns a
fresh transaction/setup or restores a deterministic fixture. Stable UUID ordering and bounded retry
remain production behavior.

## 4. Migration proof architecture

Canonical migrations are read-only inputs. Build a scenario runner that creates independent
disposable databases/roles for fresh, upgrade, duplicate and ACL cases.

For failure injection:

```text
copy canonical migration set to disposable temp directory
→ record canonical hashes
→ modify only copied migration
→ run copied failure scenario
→ prove transaction rollback
→ re-hash canonical sources
```

Inspect PostgreSQL catalog metadata for function arguments, owner, volatility, security mode,
search path and ACLs. Use distinct runtime/migrator sessions. Create hostile temp/public shadow
objects only in disposable databases and prove the qualified capability is unaffected.

The producer owns cleanup in `finally` and emits no credentials or connection data.

## 5. Flutter HTTP/file-backed architecture

Compose existing real components:

```text
temporary LocalDatabase.file (Drift v7)
→ HostedIdentityRepository
→ HostedEnrollmentCoordinator
→ HttpDeviceEnrollmentTransport
→ deterministic loopback Fastify responder
```

Use disposable PostgreSQL behind Fastify only when existing routes require it. Fixture
authentication is permitted solely in this loopback proof composition.

The loopback responder exposes internal test barriers for:

- delayed headers;
- controlled body chunks;
- response loss after server commit;
- redirect, malformed and oversized responses;
- query/replay result selection.

These controls are not public production routes.

Seed facts and pending outbox through existing repositories/application workflows. Compare stable
IDs and counts before the attempt, after it, and after database close/reopen.

Resource ownership:

- harness owns server and temporary files;
- transport owns factory-created attempt clients;
- caller owns borrowed clients;
- every client, server, database, iterator and temporary directory closes in `finally`;
- late callbacks are fenced from durable mutation after terminal attempt state.

## 6. Producer contract

Use one small versioned representation, equivalent to:

```text
ProofProducerResult {
  schemaVersion
  producer
  requiredCases
  resultsByCase
  blockers
  passed
}
```

Each producer exports its own exact required-case identifiers adjacent to its tests/harness. The
aggregator imports/consumes those contracts rather than maintaining a divergent second list.

Producer families:

```text
authorization-race
migration-006-lifecycle-acl
jwks-state-machine
route-inventory
flutter-http-file-backed
static-regression
```

Records may be JSON or another already supported deterministic format. Canonical ordering and
closed field validation are required. Do not place fact data or secret configuration in them.

## 7. Aggregator architecture

The aggregator:

1. loads only explicitly supplied local producer records;
2. validates schema/name/case structure;
3. rejects missing, duplicate and unknown inputs;
4. verifies exact required-case equality;
5. requires every case and producer boolean true;
6. emits safe blocker IDs and false on every incomplete state;
7. prints the R3 success diagnostic only after complete real inputs.

Aggregator unit fixtures prove rejection rules. The decisive harness must invoke actual producers,
collect their records and then invoke the aggregator.

## 8. Narrow correction rule

If a decisive test fails because accepted production code violates D/E:

1. preserve the failing test/case;
2. identify the smallest responsible production function;
3. correct only that function/adjacent type;
4. rerun focused and complete regression suites;
5. record the deviation in I.

Stop instead of changing architecture, dependencies, migrations, schema, protocols or provider
configuration.

## 9. Versions retained

```text
PostgreSQL migrations 001–006
event payload v3
cursor c10b:*
recovery snapshot format 1
hosted enrollment contract v1
Drift schema v7
JWT RS256
existing dependency/lockfile set
```

## 10. Security and teardown

- loopback and synthetic fixtures only;
- no Auth0, Neon, Render or public network request;
- no private helper/editor file access;
- no token, claims, keys, credentials, URLs or fact payloads in output;
- runtime and migrator remain distinct;
- temporary resources are inventoried and torn down;
- failure paths execute cleanup.

Credential containment is a separate human/provider sequence and is not an R3C producer.

## 11. Expected file boundary

Expected changes are test/lab harnesses, proof helpers/orchestrator, package-local scripts already
supported by the repository, and G/H/I. Production source changes require a captured proof failure.

Do not modify:

```text
migrations 001–006
dependency/lockfiles
Drift schema
methodology or permanent memory
A/B/C, J, D/E/F or Main-root continuity
private provider/helper files
```

## 12. Rollback and stop boundary

R3C rollback is one bounded implementation commit; no database rollback migration exists because
canonical migrations do not change.

Stop for Main when a proof requires provider behavior, a new dependency/version, migration 007,
Drift v8, public test hooks, a new product workflow or an architectural revision. Partial evidence
must remain explicitly false rather than being omitted from aggregation.
