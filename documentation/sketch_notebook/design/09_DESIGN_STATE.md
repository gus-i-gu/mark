# 09_DESIGN_STATE.md

> Version: 0.6-cycle07-sprint03-unit01
> Status: Active Checkpoint
> Persistence Class: Checkpoint
> Knowledge Class: Design State
> Authority: Design Chat [D]
> Scope: Current Design state after Sprint 03 Unit 01 Flutter foundation
> Sources: J section 19, C_DESIGN, I_DSN_CODEX, repository materialization evidence

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above preserves prior checkpoints. This is the single current Design checkpoint.

# Cycle 07 Sprint 05 Design Checkpoint

> Branch: `cycle-07-mobile-preparation`  
> Evidence: `DEV_STAGE/I_DSN_CODEX.md`  
> Main reconciliation: `[M]_STAGE/J_[M]_STAGE.md`, §24  
> Intent/directive: `DEV_STAGE/C_DESIGN.md`, `DEV_STAGE/F_DSN_STAGE.md`  
> Repository truth: Android host, async composition, Device repository, Drift v2, tests, and functional scaffold

## Current architecture

Sprint 05 established an Android-local debug slice without changing the accepted shared-client direction:

```text
Windows / Android Flutter hosts
→ shared entrypoint and asynchronous composition
→ presentation
→ application commands/query ports
→ independent Dart domain
→ local repository adapters
→ Drift schema v2 / application-private SQLite
```

Android/Kotlin remains a host. It owns no Product, Purchase, Event, sequence, analytics, or repository behavior. Cycle 06 Python/PySide6 and its database remain protected and recoverable.

## Implemented and validated

- Android namespace/application ID: `com.gusigu.markei`; label: `Markei`;
- Flutter embedding v2 and minimal `FlutterActivity` host;
- asynchronous composition loads Device identity before event-producing commands;
- database-owned UUID v4 replaces production `windows-device` injection;
- UUID persists across reopen; fresh databases differ;
- sequence continues 1→2 for the persisted Device;
- historical non-UUID Device rows are preserved and not reused;
- no schema migration was needed because Drift v2 already owns Device and sequence fields;
- `SafeArea` and staged BRL total extend the functional scaffold;
- 27 Flutter tests and analysis passed;
- debug APK built; identity badging passed;
- API 36 emulator boot/install/launch passed;
- Android app-private database and Device/Purchase facts were observed;
- human Android Purchase registration was confirmed;
- Windows build and five Python regressions passed.

## Accepted Design boundaries

- stable application ID owns Android installation/update and sandbox continuity;
- application label is presentation metadata, not identity;
- Account remains the provisional `local-account` placeholder;
- Device is an app-private UUID v4 with sequence attached to its database row;
- Device is not hardware-, platform-, Account-, email-, or application-ID-derived;
- Product, Purchase, Item, Event, and catalogue identity rules remain unchanged;
- compile/target SDK 36 and host tool versions are Operational configuration, not domain architecture;
- SafeArea and staged total are bounded scaffold choices, not final UI acceptance;
- local queue/event preparation is not synchronization.

## Prototype-only debt

`LocalDeviceIdentityRepository` scans only the first 20 Account Devices by creation time and selects the earliest UUID v4. This is acceptable for the bounded single-installation prototype only.

Before real synchronization or multiple-Device history, Design requires an explicit current-installation relation with exactly one referenced Device, idempotent concurrent bootstrap, uniqueness protection, and preserved historical Devices. Exact physical schema and migration remain open.

## Evidence limits

```text
validated
    debug Android build and one emulator execution
    sandbox persistence observation
    Device bootstrap/reopen/sequence tests
    human Purchase registration
    Windows/Python regression

partial or host-unvalidated
    keyboard and Back behavior
    rotation and background/resume
    larger text and accessibility
    complete force-stop/cold-relaunch matrix
    physical device compatibility

not accepted/deferred
    final UI/UX
    production signing/release/store
    backup policy
    authentication/API/Neon/synchronization
    central catalogue/import/iOS/PySide6 retirement
```

Automated ADB form entry was blocked by emulator input overlays, while manual registration passed. Phone-width widget tests do not establish final visual quality or complete Android lifecycle behavior.

## Next valid route

Main may close Sprint 05 if current debug-development evidence is sufficient, or authorize one bounded supplemental Android checklist for keyboard, Back, rotation, background/resume, larger text, and cold relaunch. Broad UI/UX formalization must remain a later sprint. The explicit installation-Device invariant must be resolved before real synchronization.

Additional implementation remains inactive until Main/human authority is expressed through fresh D/E/F.

## Recovery pointers

- Canonical: `design/01_ARCHITECTURE.md`, §§16–19.
- Derived: `design/14_MODEL_OVERVIEW.md`, current post-marker segment.
- Observational: `design/03_DECISION_LOG.md`, Event 17.
- Evidence: `DEV_STAGE/I_DSN_CODEX.md`.
- Main: `[M]_STAGE/J_[M]_STAGE.md`, §24.

---

<!-- TEMPORAL_MARKER:C08-ENTRY-2026-07-12 -->
> Temporal boundary — Cycle 08 begins here. Content above belongs to Cycle 07 or earlier reviewed project history; content below belongs to Cycle 08 work and later reconciliation.

---

<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here (2026-07-14). Content above is historical. This is the current Cycle 09 checkpoint.

# Cycle 09 Design Checkpoint

> Branch: `intermid-cycle-recovery`
> Inspected implementation: `e37cb700feeca4001cc7835b584c46bb81926af3`
> Sequence: FLX-PRM-04
> Evidence: C/F/I, post-Codex J, and targeted handwritten source
> Generated Drift evidence: derived only

## Current architecture

```text
Flutter presentation
→ application ports/read models/failures
→ independent Dart domain
← local adapters
→ handwritten Drift schema v3 / app-private SQLite
```

Cycle 09 expands the local product beta without changing the inward dependency direction or protected Python/PySide6 boundary.

## Accepted and implemented

- Home-first responsive navigation and static descriptors.
- schema v3 People, PaymentMethods, AccountPreferences and nullable Purchase references.
- nullable package count for BULK.
- normalization v3, exact-collision preflight and deterministic legacy-code backfill.
- transient `personal-cycle-v1` Lists projections without persisted List/cache.
- History selected IDs, stable export DTOs, deterministic CSV and PDF bytes.
- exact Product lookup ports and Product-detail query.
- typed application failures.
- optional references preserve archived historical labels.
- registered Purchase edit/delete, Analytics and Household remain inactive.

## Required classifications

| Claim | Current state |
| --- | --- |
| BULK price-per-unit UI | contradicted completion: Line total remains the input |
| active-only nickname uniqueness | contradicted: current key also limits archived duplicates |
| Product-code columns | resolved as nullable compatibility storage; NOT NULL contradicted |
| PDF generation | implemented |
| OS-native/save-dialog sharing | deferred; temporary-file/manual flow only |
| exact lookup ports | implemented |
| exact lookup presentation | partial |
| Product detail card/query | implemented bounded form |
| adaptive shared Product details | partial/deferred |
| complete typed error presentation | partial |
| History double-click/select-all | partial |

## Evidence boundary

Reported: 39 Flutter tests, clean analysis, Windows release build and bounded launch, file-backed migration/reopen evidence, and five Python regressions.

Not established: Android recovery/runtime, native share, injected migration-failure behavior, full manual workflow, comprehensive accessibility/responsive acceptance, or release readiness.

## Remaining Design conflicts

1. correct nickname uniqueness without losing archived history;
2. implement BULK unit-price input and half-up line-total derivation;
3. expose exact lookup in Catalogue UI;
4. establish shared adaptive Product-details navigation;
5. complete typed failure mapping;
6. define user-controlled save/native-share behavior and cleanup;
7. finish History selection conveniences.

Deferred: auth/API/Neon/synchronization, Store redesign, SubmissionId, persisted drafts, Product merge/correction, registered Purchase mutation, Analytics/Household behavior and production release.

## Next Main handoff

Main should classify the two contradicted items as a focused correction unit, decide whether exact lookup/adaptive details/native share remain deferred or enter that unit, and preserve Android/manual/release gaps as Operational evidence boundaries. Fresh D/E/F are required before source or schema changes.

## Recovery pointers

- Canonical: `design/01_ARCHITECTURE.md`, section 21.
- Observational: `design/03_DECISION_LOG.md`, Event 19.
- Derived: `design/14_MODEL_OVERVIEW.md`, Cycle 09 map.
- Evidence: C/F/I and post-Codex `J_MAIN_STAGE.md`.
