# D_OPS_STAGE — Cycle 07 Sprint 03 Flutter Foundation

> Cycle: 07 | Sprint: 03 | Unit: 01
> Status: Main-approved materialization stage
> Branch: `cycle-07-mobile-preparation`
> Baseline: `f6414fbe7394453387067a5a34ca6cc7621bbed3`
> Sources: `[M]_STAGE/J_[M]_STAGE.md` §§17–18; `00_PROJECT_STATE.md`; `05_SESSION_LOG.md`; `06_SESSION_SCHEME.md`

---

# 1. Authorized outcome

Materialize the first additive Flutter/Dart foundation at `clients/markei_flutter/` and language-neutral fixtures at `contracts/shared_beta/v1/`. Preserve the Python/PySide6 beta without moving, renaming, deleting, importing, or migrating it.

This unit ends with a fresh Drift local schema, immutable Dart domain/value objects, deterministic fixture-backed tests, and an atomic repository test for one Purchase containing one or more Purchase Items plus one pending `purchase.registered` event. UI workflow, TypeScript, authentication, Neon, networking, and release builds are outside this unit.

# 2. Preflight

Record before editing:

```text
git status --short --branch
git branch --show-current
git rev-parse HEAD
git merge-base --is-ancestor f6414fbe7394453387067a5a34ca6cc7621bbed3 HEAD
flutter --version
dart --version
flutter doctor -v
```

Stop without source edits if the branch or ancestry is wrong, overlapping user changes exist, Flutter/Dart is unavailable, or the authorized paths cannot remain isolated. Do not install system toolchains, provision cloud resources, or fix unrelated environment problems without fresh authorization.

# 3. Authorized creation

- Create one Flutter app named `markei` under `clients/markei_flutter/`, generating Android, iOS, and Windows platform directories when supported by the installed tool.
- Commit `pubspec.lock`; record the actually executed stable Flutter/Dart versions in G/H/I.
- Evaluate Drift as the sole persistence candidate. Add only dependencies needed for Drift, UUID/value handling, app-private paths, code generation, and tests.
- Create the fixture package under `contracts/shared_beta/v1/`.
- Version conventional generated Dart source; exclude build output, IDE state, local databases, secrets, and caches.

# 4. Required validation

Run and report:

```text
flutter pub get
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

Run the already-documented Python test command if discoverable without new installation. A precise blocker is acceptable; Python changes made only to manufacture a pass are not.

Evidence must cover fixture parsing; packaged/bulk normalization; explicit quantity dimensions; ISO currency plus integer minor units; atomic Purchase/Items/event persistence; full rollback for an invalid Item; close/reopen persistence; and proof the ordinary Cycle 06 database was not opened or modified.

# 5. Stop and rollback gates

Stop if implementation requires Python IPC, direct Neon credentials, network work inside a database transaction, Cycle 06 schema edits, or deferred product features. Rollback may remove only new files from this unit. Never reset, clean, or overwrite user work.

# 6. Reports

Update only existing G/H/I:

- `G_OPS_CODEX.md`: commands, environment, paths, validation, failure evidence, final scope;
- `H_DDC_CODEX.md`: fixtures, concepts evidenced, concepts still unvalidated;
- `I_DSN_CODEX.md`: topology, dependency direction, schema, transaction boundary, deviations.

Do not update permanent documentation, KANBAN maturity, 00, 05, 06, J, or methodology.
