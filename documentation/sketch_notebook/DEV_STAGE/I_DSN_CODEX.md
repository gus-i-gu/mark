# I_DSN_CODEX

Authority marker: C10-MCG02-ACCOUNT-CURSOR-PROVISIONING-REPAIR_20260722

Final dependency direction:
- PostgreSQL migration 007 owns the Account cursor provisioning invariant.
- Server readiness checks depend on `public.markei_hosted_runtime_ready_v2()`.
- Enrollment, re-enrollment, first Sync, Flutter and provider scripts do not repair missing cursor state.
- Sync service still advances existing cursor state and fails closed if the row is absent.

Migration objects:
- File: `services/markei_sync_api/migrations/007_account_cursor_provisioning.sql`
- Ledger migration_id: `007_account_cursor_provisioning`
- Ledger checksum: `c10-mcg02-account-cursor-provisioning-v1`
- Trigger function: `public.markei_provision_account_cursor_state()`
- Trigger: `accounts_provision_cursor_state_after_insert`
- Readiness function: `public.markei_hosted_runtime_ready_v2()`

Trigger and security:
- Timing: AFTER INSERT on `public.accounts`, because `public.account_cursor_state.account_id` references the parent Account.
- Function mode: SECURITY DEFINER, owned by migrator in disposable proof.
- Search path: fixed `pg_catalog, public`.
- References: fully qualified `public.account_cursor_state`; no dynamic SQL.
- Direct execution: denied to PUBLIC and runtime; execution is through the Account trigger.
- Atomicity: Account INSERT and cursor provisioning commit or roll back together.

Backfill behavior:
- Only missing Accounts are backfilled.
- Missing/no-events Account gets next_cursor 1.
- Missing/with-events Account gets max(`sync_events.server_cursor`) + 1.
- Existing cursor rows keep their exact pre-migration next_cursor.
- Mixed complete/incomplete Accounts preserve complete state and repair only incomplete state.

ACL/RLS behavior:
- Runtime cursor INSERT and DELETE revoked.
- Runtime scoped cursor SELECT and `next_cursor` UPDATE preserved under existing Account RLS.
- Runtime Account INSERT remains denied.
- Runtime ledger, DDL and role-administration operations denied.
- Object-shadowing resistance validated by temp-table shadow attempt against readiness-v2.

Readiness compatibility:
- `public.markei_hosted_runtime_ready()` is unchanged for old-binary rollback compatibility.
- New application code calls only `public.markei_hosted_runtime_ready_v2()`.
- New binary plus database through 006 is not ready because v2 is absent.
- New binary plus exact 006+007 state is ready.
- False, absent or malformed v2 results fail closed as not-ready.
- Old readiness remains callable after 007.

Fixture adaptations:
- Hosted local harness and Flutter producer migration lists include 007.
- Post-007 Account fixtures rely on the trigger instead of manual cursor insert.
- Manual cursor insert remains only in pre-007/incomplete-state or historical harness contexts.

Preserved invariants:
- No PostgreSQL migrations 001-006 edited.
- No Flutter schema, Drift migration, UI or sync protocol payload change.
- No event identity, sequence, content hash, Account/Device authorization, JWT/JWKS validation, route inventory or exact-retry behavior changed.
- Existing missing-state HTTP 503 defense remains as defense in depth and produces no partial Sync application.

Residual design risks:
- Provider deployment ordering remains a future gate: apply migration 007, redeploy new server code, then perform human-controlled provider verification.
- The aggregate `r3_local_orchestrator` still reports the existing Flutter producer `query-replay-same-request-id` case as failed; direct Flutter suite and opt-in convergence/recovery harnesses passed.
- Package-lock was minimally updated to patched transitive `fast-uri` versions to satisfy required production audit without changing declared dependencies.
