# Operational State

> Checkpoint refreshed from Cycle 05 Sprint 01 Windows Desktop Installation evidence.

## Current Milestone

```text
Cycle 05
Sprint 01 — Windows Desktop Installation
```

Sprint 01 has materialized and validated the frozen one-folder application runtime. The installer is configured but the compiled installer and installed lifecycle remain unvalidated because Inno Setup `ISCC.exe` was unavailable.

## Current Implementation State

Preserved application boundary:

```text
Desktop UI
→ ProductService
→ Repository
→ SQLite
```

Public desktop pages remain:

- Register
- Lists
- History
- Settings

Implemented:

- PyInstaller one-folder runtime.
- Frozen Python execution support.
- Working-directory-independent bundled schema discovery.
- Schema-only production initialization.
- Seed-free empty production business database.
- User database under `%LOCALAPPDATA%\Markei`.
- First receipt workflow without a seeded store.
- Startup failure logging.
- Pinned PySide6 and PyInstaller dependencies.
- Inno Setup per-user installer configuration.

Production runtime contains:

```text
schema.sql
```

Production runtime excludes:

```text
seed.sql
market.sqlite
SQLite WAL/SHM files
sample business records
```

Verified first-launch database state:

```text
products: 0
purchases: 0
stores: 0
categories: 0
settings: 6
```

## Validation Classification

### Validated

- PyInstaller one-folder build completed.
- Frozen executable launched successfully.
- Frozen application constructed Register, Lists, History, and Settings.
- Schema discovery was independent of the process working directory.
- First launch created the writable database under `%LOCALAPPDATA%\Markei`.
- Production first launch created no sample products, purchases, stores, or categories.
- Six default settings were initialized.
- A first receipt could be registered without a seeded store.
- Startup failure logging behavior was exercised.
- Runtime dependency versions were pinned.

### Configured But Unvalidated

- Inno Setup per-user installer definition.
- Installation placement.
- Start Menu shortcut creation.
- Uninstall registration.
- Upgrade identity and replacement behavior.
- Preservation of external user data through installed upgrade, uninstall, and reinstall.

### Blocked

- Installer compilation.
- Installed lifecycle validation.

Primary blocker:

```text
Inno Setup ISCC.exe was unavailable.
```

### Deferred

- SmartScreen and antivirus behavior.
- Production code signing.
- Rollback design.
- Automatic updating.
- Sprint 02 mobile preparation.
- API, backend, account, and synchronization work.

## Remaining Operational Work

- Install or otherwise provide Inno Setup `ISCC.exe`.
- Compile the installer artifact.
- Validate Start Menu launch.
- Validate installation under a clean Windows user profile with no Python or repository checkout.
- Validate installed upgrade preserves `%LOCALAPPDATA%\Markei`.
- Validate uninstall preserves user data.
- Validate reinstall recovers compatible retained data.
- Observe and record SmartScreen and antivirus behavior.
- Perform full manual interactive UI walkthrough for Register, Lists, History analytics, Settings, and Product View.
- Perform human Settings save-feedback QA for valid and invalid values.
- Perform human store create/update UI QA and confirm dependent-page refresh.
- Validate Lists double-click behavior in every internal view.
- Validate receipt save refreshes Lists and History in real UI interaction.
- Retain prior analytics, date-format, legacy-setting, inert `pages.order`, and transitional-page risks until separately resolved.

## Known Operational Limitations

- A successful PyInstaller build is not a fully validated installed release.
- The installer definition is source configuration, not a compiled installer artifact.
- Installed upgrade, uninstall, and reinstall preservation are not yet proven.
- SmartScreen and antivirus behavior remain unknown.
- Full manual interactive UI validation remains incomplete.
- Current purchases remain date-only, so operational-day time behavior is not materially exercised by existing History rows.
- Legacy `history.month_boundary_rule` may remain in persisted data as compatibility residue.
- `pages.order` remains persisted but inert.
- Invalid analytics date input still behaves like an omitted date boundary.
- Same-day purchases can produce sub-day frame average timelapse values.
- Existing unsupported date formats are reported, not repaired.
- Old Storage/Shortage/Market page files remain transitional.
- Full automated PySide6 interaction coverage is absent.

## Active Operational Risks

- Installer source may still contain environment-specific or lifecycle defects that only compiled installation testing can reveal.
- Upgrade or uninstall behavior must not be inferred from external data placement alone.
- Unsigned binaries may trigger SmartScreen or antivirus warnings.
- Manual UI interaction defects may remain despite successful frozen runtime construction.
- Development and installed-release data paths must remain deliberately separated during validation.
- Release completion must remain blocked until the installer artifact and installed lifecycle are validated.
