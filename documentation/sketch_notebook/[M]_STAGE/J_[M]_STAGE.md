# J_[M]_STAGE — Cycle 06 Sprint 02 Post-Codex Reconciliation

> Status: Active Main post-materialization reconciliation
> Authority: Main Chat [M]
> Repository: `gus-i-gu/markei`
> Required branch: `sketch-notebook-recovery`
> Inputs: `DEV_STAGE/G_OPS_CODEX.md`, `DEV_STAGE/H_DDC_CODEX.md`, `DEV_STAGE/I_DSN_CODEX.md`, current implementation delta
> Knowledge state: Reconciled staging; not permanent domain canon
> Milestone: Fully executable and installable Windows primary beta

---

# 1. Main Reconciliation Summary

Cycle 06 Sprint 02 crossed the installer and installed-runtime boundary.

Current evidence supports:

```text
configured: validated
built: validated
launched: validated — frozen and installed shortcut launch
installed: validated — automated per-user lifecycle
validated: partial-to-strong technical evidence
accepted: no
```

The following previously blocked gates now have evidence:

```text
Inno Setup available
→ installer compiled
→ installer artifact inspected and hashed
→ per-user installation completed
→ Start Menu shortcut created and launched
→ installed database initialized
→ Register-equivalent workflow persisted data
→ Lists / History / Settings projections returned expected evidence
→ installed close and immediate reopen passed
→ same-version reinstall preserved data
→ uninstall preserved user data
→ reinstall recovered retained data
```

Cycle 06 is not yet globally closed because final human-visible workflow acceptance and human-visible SmartScreen/security observation remain incomplete. Main must not equate automated service-backed workflow evidence with a full manual UI walkthrough.

# 2. Materialization Verified

The Sprint 02 implementation delta is bounded to:

```text
scripts/build_installer.ps1
    adds discovery of per-user Inno Setup installation

app/core/database.py
    adds required structural defaults
    category F / General
    store 1 / Default Store

tests/test_release_configuration.py
    verifies structural defaults
    preserves zero sample products and purchases

G/H/I
    report execution and domain evidence
```

The accepted application boundary remains:

```text
Desktop UI
→ ProductService
→ Repository
→ Database Manager
→ SQLite
```

No broad architecture, transaction, schema, service, repository, mobile, backend, synchronization, authentication, or cloud expansion occurred.

# 3. Accepted Sprint 02 Evidence

## 3.1 Toolchain and build

Accepted:

- Inno Setup 6.7.3 was installed through `winget` in a per-user location.
- `scripts/build_installer.ps1` was corrected to discover the per-user `ISCC.exe` path.
- source compilation passed;
- five standard-library tests passed;
- the frozen runtime rebuilt;
- the installer compiled.

Installer artifact evidence:

```text
dist\installer\Markei-Setup-0.1.0-x64.exe
SHA256 122A772D66BBE7D5522EF2262E7E89D6D2E332B6318135BB25D55A27F75F4623
size 34,448,651 bytes
```

Frozen executable evidence:

```text
dist\Markei\Markei.exe
SHA256 E13E276139E5F680D91A9816FC79776EB9837CA901C2DEBCF6B9CFAF8594A282
```

The Inno Setup warning that `x64` is deprecated in favor of `x64compatible` is non-blocking implementation debt and must not be confused with compilation failure.

## 3.2 Structural production defaults

The installed Register workflow initially failed because the schema-only production database lacked category `F` and store `1`, which current Register defaults require.

The bounded correction adds only:

```text
category F / General
store 1 / Default Store
```

These are now classified as structural application defaults, not demonstration/sample business data.

The production policy remains:

```text
schema.sql included
seed.sql excluded
structural defaults created idempotently
zero sample products
zero sample purchases
```

## 3.3 Installed lifecycle

Accepted technical evidence:

- silent per-user install exited successfully;
- installed executable existed under `%LOCALAPPDATA%\Programs\Markei`;
- Start Menu shortcut existed and launched the installed executable;
- first installed launch created `%LOCALAPPDATA%\Markei\market.sqlite`;
- installed process closed successfully;
- data persisted through immediate reopen;
- same-version reinstall retained data;
- uninstall removed application registration/files while retaining the database;
- reinstall reopened retained compatible data.

The test dataset included one product and one purchase, with corresponding Lists, History, and Settings projection evidence.

# 4. Evidence Boundaries and Reconciliation Warnings

## 4.1 Automated workflow evidence versus human UI acceptance

G reports Register, Lists, History, and Settings as validated through the installed user database and the same ProductService/database path used by the application. This is valid technical workflow evidence.

However, the validation was not a complete human visual walkthrough of every UI interaction.

Main classification:

```text
installed technical workflow path: validated
human-visible UI workflow acceptance: pending
```

Permanent memory must preserve this distinction.

## 4.2 Current user versus dedicated test account

The lifecycle used the current ordinary Windows user, with existing Markei data backed up and restored. A dedicated account was not used.

Main classification:

```text
ordinary per-user install semantics: evidenced
clean dedicated-account isolation: not evidenced
```

A dedicated account is no longer automatically a release blocker unless Operational or human review identifies contamination or ambiguity in the captured results.

## 4.3 SmartScreen and antivirus

Defender was enabled and the binaries are unsigned. No SmartScreen prompt was observed during silent/programmatic execution.

Main classification:

```text
Defender enabled: observed
Authenticode: NotSigned
human-visible SmartScreen behavior: unknown
```

This remains a human observation gate, not proof of an application defect.

## 4.4 Generated installer repository drift

G states that the installer was generated but not committed. Direct branch comparison shows:

```text
dist/installer/Markei-Setup-0.1.0-x64.exe
    added to the branch
```

This is a report/repository contradiction.

Main does not decide the final artifact-retention policy here. Operational documentation must classify whether release binaries are intentionally versioned or should be removed and ignored. Until resolved, permanent memory should state that the artifact exists in the branch while the report incorrectly described it as uncommitted.

# 5. Current Cycle 06 Closure Position

Technically completed:

```text
packaging configuration
frozen build
installer compilation
per-user installation
installed shortcut launch
installed data path
technical workflow persistence
installed close/reopen
same-version reinstall
uninstall retention
reinstall recovery
```

Still pending before final Main/human acceptance:

```text
human-visible installer wizard observation
human-visible Register / Lists / History / Settings walkthrough
human-visible close/reopen confirmation
SmartScreen / antivirus interaction observation
human acceptance of the package for controlled beta use
artifact-versioning contradiction resolution
```

Cycle 06 may be technically release-candidate ready, but it is not yet declared accepted or closed.

# 6. Operational [O] Permanent Documentation Update Prompt

You are continuing as Operational Chat [O] for Cycle 06.

Use only branch:

```text
sketch-notebook-recovery
```

The methodology is already loaded. Read:

```text
00_PROJECT_STATE.md
06_SESSION_SCHEME.md
[M]_STAGE/J_[M]_STAGE.md
DEV_STAGE/D_OPS_STAGE.md
DEV_STAGE/G_OPS_CODEX.md
operational/12_OPERATIONAL_MODEL.md
operational/04_TODO.md
operational/10_OPERATIONAL_STATE.md
operational/11_OPERATIONAL_RECORD.md
```

Inspect only the exact Sprint 02 implementation delta and artifact-presence evidence when required:

```text
scripts/build_installer.ps1
app/core/database.py
tests/test_release_configuration.py
dist/installer/Markei-Setup-0.1.0-x64.exe
```

Your task is semantic reconciliation into permanent Operational memory.

Update only:

```text
operational/12_OPERATIONAL_MODEL.md
operational/04_TODO.md
operational/10_OPERATIONAL_STATE.md
operational/11_OPERATIONAL_RECORD.md
```

Required outcomes:

1. Record installer compiler discovery, compile, artifact, hash, and installed lifecycle evidence.
2. Record structural defaults as required application defaults distinct from sample seed data.
3. Mark install, Start Menu launch, technical workflows, close/reopen, reinstall, uninstall retention, and recovery as technically validated within the reported environment.
4. Preserve human-visible UI walkthrough, SmartScreen observation, and final acceptance as pending.
5. Classify current-user-with-backup validation accurately; do not claim dedicated-account evidence.
6. Reconcile the contradiction that G says the installer was uncommitted while GitHub shows the installer binary added to the branch.
7. Decide within Operational ownership whether generated release artifacts should be versioned, ignored, or removed; if the decision requires Main/human approval, state the exact decision instead of modifying the artifact.
8. Retain the Inno `x64` deprecation warning as non-blocking debt.
9. Retain workflow atomicity as inherited debt.
10. Use precise evidence language and do not declare beta acceptance.

Semantic roles:

```text
12_OPERATIONAL_MODEL.md — stable reusable release/lifecycle rules
04_TODO.md              — remaining human and cleanup work
10_OPERATIONAL_STATE.md — compact current checkpoint
11_OPERATIONAL_RECORD.md — append Sprint 02 chronology and evidence
```

Do not modify source, artifacts, Main-root files, methodology, or another domain.

Commit one coherent Operational documentation update and report the files, status changes, remaining gates, artifact-policy conclusion, and commit SHA.

# 7. Didactic [A] Permanent Documentation Update Prompt

You are continuing as Didactic Chat [A] for Cycle 06.

Use only branch:

```text
sketch-notebook-recovery
```

Read:

```text
[M]_STAGE/J_[M]_STAGE.md
DEV_STAGE/E_DDC_STAGE.md
DEV_STAGE/H_DDC_CODEX.md
DEV_STAGE/G_OPS_CODEX.md
didactics/02_KANBAN.md
didactics/07_GLOSSARY.md
didactics/08_CONCEPT_MAP.md
didactics/13_LECTURE_REGISTER.md
```

Inspect exact implementation files only for project examples.

Update only:

```text
didactics/02_KANBAN.md
didactics/07_GLOSSARY.md
didactics/08_CONCEPT_MAP.md
didactics/13_LECTURE_REGISTER.md
```

No new KANBAN concept is expected.

Required outcomes:

1. Reinforce `&&&05` with the now-observed progression from installer configuration through installed lifecycle validation.
2. Reinforce `&&%04` with actual installed shortcut execution distinct from frozen execution.
3. Reinforce `&%%06` with the compiled installer, installed application files, uninstall, reinstall, and retained-data recovery stages.
4. Reinforce `%%%06` with Inno Setup as an installer-time dependency installed per-user and not required by the installed application.
5. Reinforce `%%%05` with observed separation between replaceable installed files and retained user data.
6. Reinforce initialization/migration/seeding distinctions using structural defaults versus sample data.
7. Preserve the distinction between automated technical workflow validation and human-visible UI acceptance.
8. Preserve SmartScreen as an unknown environmental/reputation observation.
9. Do not promote any concept to Green automatically.
10. Consider Red-to-Yellow movement only if supported by the existing Didactic maturity protocol and explicit learner evidence; software success alone is insufficient.

Semantic roles:

```text
02_KANBAN.md          — canonical concepts and project examples
07_GLOSSARY.md        — derived terminology
08_CONCEPT_MAP.md     — current learning checkpoint
13_LECTURE_REGISTER.md — append observational learning event
```

Do not modify source, artifacts, Main-root files, methodology, or another domain.

Commit one coherent Didactic documentation update and report maturity decisions, reinforced concepts, remaining learner checks, and commit SHA.

# 8. Design [D] Permanent Documentation Update Prompt

You are continuing as Design Chat [D] for Cycle 06.

Use only branch:

```text
sketch-notebook-recovery
```

Read:

```text
[M]_STAGE/J_[M]_STAGE.md
DEV_STAGE/F_DSN_STAGE.md
DEV_STAGE/I_DSN_CODEX.md
DEV_STAGE/G_OPS_CODEX.md
design/01_ARCHITECTURE.md
design/14_MODEL_OVERVIEW.md
design/09_DESIGN_STATE.md
design/03_DECISION_LOG.md
```

Inspect only:

```text
scripts/build_installer.ps1
app/core/database.py
installer/Markei.iss
app/desktop/main_window.py
```

Update only:

```text
design/01_ARCHITECTURE.md
design/14_MODEL_OVERVIEW.md
design/09_DESIGN_STATE.md
design/03_DECISION_LOG.md
```

Required outcomes:

1. Absorb the compiled-installer and installed-lifecycle evidence.
2. Record the per-user Inno compiler discovery correction as tooling, not architecture.
3. Classify category `F` and store `1` as structural defaults required by current Register behavior, distinct from sample business data.
4. Record that installed program files, writable data, logs, shortcuts, uninstall registration, and retained data behaved according to the accepted boundary.
5. Record that same-version reinstall, uninstall preservation, and reinstall recovery passed technically.
6. Preserve the distinction between technical installed workflow evidence and human visual UI acceptance.
7. Preserve SmartScreen behavior as unknown.
8. Record that no installed gate required broad architectural redesign.
9. Keep workflow atomicity and broader migration strategy as inherited unresolved debt.
10. Do not declare final beta acceptance or Cycle closure.

Semantic roles:

```text
01_ARCHITECTURE.md  — accepted stable deployment and application boundaries
14_MODEL_OVERVIEW.md — derived source/build/install/user-state/lifecycle map
09_DESIGN_STATE.md  — current checkpoint and remaining human gates
03_DECISION_LOG.md  — append Sprint 02 decisions, corrections, and evidence chronology
```

Do not modify source, artifacts, Main-root files, methodology, or another domain.

Commit one coherent Design documentation update and report absorbed boundaries, remaining validation limits, and commit SHA.

# 9. Main Continuity After Domain Updates

After [O], [A], and [D] complete permanent documentation updates, Main must:

```text
read updated domain checkpoints
→ reconcile artifact-versioning policy
→ perform human-visible installer/UI/security observations
→ decide beta acceptance
→ update 00_PROJECT_STATE.md
→ append 05_SESSION_LOG.md
→ prepare the next 06_SESSION_SCHEME.md
```

No domain may independently close Cycle 06 or declare the beta accepted.
