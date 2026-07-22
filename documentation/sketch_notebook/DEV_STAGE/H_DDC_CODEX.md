# H_DDC_CODEX

Authority marker: C10-MCG02-ACCOUNT-CURSOR-PROVISIONING-REPAIR_20260722

Didactic result:
- Validated concept: hosted Account lifecycle now has a database-enforced local invariant: every Account inserted after migration 007 receives exactly one `account_cursor_state` row in the same transaction.
- Historical correction: migration 007 backfills only missing rows. Missing rows use high-water derivation from existing `sync_events.server_cursor`; Accounts without events get next_cursor 1.
- Existing cursor rows are preserved exactly. The migration does not reset, decrease, recompute or overwrite valid cursor state.
- Runtime least privilege is tightened: runtime retains scoped SELECT and `next_cursor` UPDATE, but loses cursor INSERT and DELETE.

Bounded vocabulary:
- `ready`: readiness-v2 returned boolean true.
- `not-ready`: readiness-v2 absent, false, malformed, or query failure.
- `service-unavailable` / `not-applied`: defense-in-depth protected submission result when an Account still lacks cursor state.

Semantic tests added or retained:
- `pre007-account-can-commit-without-cursor`
- `pre007-incomplete-account-remains-incomplete`
- `pre007-old-readiness-true`
- `pre007-runtime-cursor-insert-allowed`
- `fresh-001-to-007`
- `missing-row-no-events-next-cursor-1`
- `missing-row-existing-events-high-water-plus-1`
- `existing-cursor-row-preserved`
- `concurrent-account-creation-provisions-cursors`
- `migration-failure-rolls-back-all-007-effects`
- `runtime-account-and-cursor-insert-denied`
- `runtime-scoped-cursor-select-update-allowed`
- `readiness-v2-true-false-absent`
- `old-readiness-remains-available`
- `first-submission-after-provisioning-allocates-cursor`
- `missing-state-503-defense-in-depth`
- `health readiness calls v2 and preserves v1 rollback compatibility by not calling it`
- `health readiness fails closed for absent, false, and malformed v2 results`

Evidence classification:
- Observed: early dirty implementation existed before authority re-debut and was reviewed as candidate work.
- Validated: migration/backfill/trigger/ACL/RLS/readiness behavior in disposable PostgreSQL; Flutter and server regression suites; local hosted authorization harness; opt-in disposable convergence/recovery harnesses.
- Inferred: production Account creation through future migrations or administrative provisioning will invoke the trigger when 007 is applied.
- Provisional: provider behavior after Neon migration and Render redeploy remains untested.
- Unavailable: pytest was unavailable because pytest is not installed.
- Not performed: provider migration, deployment, real Sync, human database inspection, human unresolved-submission retry.

Learning boundary:
- This unit proves local database provisioning behavior and application readiness adaptation.
- It does not prove Neon has migration 007, Render is running new code, or the preserved real submission can now be retried.
- No learner maturity or permanent notebook promotion is claimed.
