# G_OPS_CODEX — Cycle 06 Sprint 02 Operational Codex Report

> Status: Codex implementation evidence
> Branch: `sketch-notebook-recovery`
> Source stages: `D_OPS_STAGE.md`, `E_DDC_STAGE.md`, `F_DSN_STAGE.md`
> Date: 2026-07-12

## Bootstrap

- `AGENTS.md` loaded and applied.
- `documentation/sketch_notebook/INDEX.md` loaded.
- Methodology boot sequence completed: `METHOD_FOUNDATIONS.md`, `FLUX.md`, `PROMOTION_RULES.md`, `CHAT_PROTOCOL.md`.
- Current state recovered from `00_PROJECT_STATE.md`, `06_SESSION_SCHEME.md`, and `[M]_STAGE/J_[M]_STAGE.md`.
- Sprint 02 implementation authority read from D/E/F before implementation inspection.

## Files Changed

Modified source/configuration:

- `scripts/build_installer.ps1`
- `app/core/database.py`
- `tests/test_release_configuration.py`

Modified report files:

- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

Generated but not committed:

- `dist/installer/Markei-Setup-0.1.0-x64.exe`

## Bounded Corrections

### Installer Compiler Discovery

Failure:

- `.\scripts\build_installer.ps1` initially failed because `ISCC.exe` was not found.
- Inno Setup 6.7.3 was installed by `winget` under the per-user path:
  `C:\Users\gusrm\AppData\Local\Programs\Inno Setup 6\ISCC.exe`.

Correction:

- Added `$env:LOCALAPPDATA\Programs\Inno Setup 6\ISCC.exe` to `scripts/build_installer.ps1`.

### Fresh Production Register Defaults

Failure:

- Fresh installed production workflow failed with `sqlite3.IntegrityError: FOREIGN KEY constraint failed`.
- Evidence showed Register defaults require category `F` and store `1`, while the production package intentionally excludes sample `seed.sql`.

Correction:

- Added migration-time structural defaults only:
  - category `F` / `General`
  - store `1` / `Default Store`
- No sample products or purchases were introduced.
- Release configuration tests now verify those structural defaults and still verify zero products and purchases.

## Commands And Evidence

```text
git branch --show-current
```

Result: `sketch-notebook-recovery`.

```text
winget install --id JRSoftware.InnoSetup --silent --accept-package-agreements --accept-source-agreements
```

Result: Inno Setup installed. `winget list --id JRSoftware.InnoSetup` reported version `6.7.3`.

```text
python -m compileall app main.py
```

Result: passed after corrections.

```text
python -m unittest discover -s tests
```

Result: passed, 5 tests.

```text
.\scripts\build_windows.ps1
```

Result: passed after structural-default correction.

```text
.\scripts\build_installer.ps1
```

Result: passed after per-user `ISCC.exe` path correction.

Observed Inno warning:

```text
Architecture identifier "x64" is deprecated. Substituting "x64os"; "x64compatible" preferred in most cases.
```

The warning did not block compilation.

## Artifacts

Frozen executable:

```text
dist\Markei\Markei.exe
SHA256: E13E276139E5F680D91A9816FC79776EB9837CA901C2DEBCF6B9CFAF8594A282
Size: 2,173,220 bytes
```

Installer:

```text
dist\installer\Markei-Setup-0.1.0-x64.exe
SHA256: 122A772D66BBE7D5522EF2262E7E89D6D2E332B6318135BB25D55A27F75F4623
Size: 34,448,651 bytes
```

Distribution inspection:

- `dist\Markei\Markei.exe` present.
- `_internal\app\database\schema.sql` present.
- `seed.sql`, `market.sqlite`, WAL/SHM files, and startup logs were not present in the frozen distribution after restore/inspection.

## Installed Lifecycle Gates

Environment:

- Automated lifecycle validation used the current ordinary Windows user.
- Existing `%LOCALAPPDATA%\Markei` was backed up before clean-install testing and restored afterward.
- Restored evidence: `%LOCALAPPDATA%\Markei\market.sqlite` exists; temporary backup path no longer exists.

Clean per-user install:

```text
installed
```

Evidence:

- Silent installer exited with code `0`.
- Installed executable existed at `%LOCALAPPDATA%\Programs\Markei\Markei.exe`.
- Start Menu shortcut existed at `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Markei\Markei.lnk`.

Start Menu launch:

```text
launched
```

Evidence:

- Shortcut launch started the installed process.
- First launch created `%LOCALAPPDATA%\Markei\market.sqlite`.
- No startup diagnostic log was produced during normal startup.
- `CloseMainWindow()` returned `true`.

Register / Lists / History / Settings validation:

```text
validated
```

Evidence:

- Installed user database contained one category, one store, one product, and one purchase after Register-equivalent `ProductService` workflow.
- Product evidence: `T006` / `Cycle 06 Test Product`.
- List projection returned product row with quantity `2 unit`, latest price `3.5`, status `in-house`, and label `$ 3.50`.
- History projection returned expected keys including `months`, `settings`, and `unparsed_rows`.
- Settings evidence showed `week_boundary` as `wednesday`.

Close and immediate reopen:

```text
validated
```

Evidence:

- Installed app reopened twice after close.
- `CloseMainWindow()` returned `true` on each close.
- Database persisted across reopen with counts:
  `categories=1`, `stores=1`, `products=1`, `purchases=1`.

Same-version reinstall:

```text
validated
```

Evidence:

- Same-version reinstall exited with code `0`.
- `%LOCALAPPDATA%\Markei\market.sqlite` remained present.
- Test product and purchase remained present after reinstall.

Uninstall with retained user data:

```text
validated
```

Evidence:

- Uninstall exited with code `0`.
- `%LOCALAPPDATA%\Markei\market.sqlite` remained present after uninstall.
- Data counts remained:
  `categories=1`, `stores=1`, `products=1`, `purchases=1`.

Reinstall and retained-data recovery:

```text
validated
```

Evidence:

- Reinstall exited with code `0`.
- Installed app launched after reinstall and closed cleanly.
- Data counts and `Cycle 06 Test Product` remained present.

SmartScreen / antivirus:

```text
unknown
```

Evidence:

- Microsoft Defender status showed antivirus and real-time protection enabled.
- Installer and executable Authenticode status: `NotSigned`.
- No SmartScreen prompt was observed during silent installation or programmatic launch.
- Human-visible SmartScreen behavior remains unvalidated because the installer was executed silently.

## Evidence Status

```text
configured: validated
built: validated
launched: validated
installed: validated
validated: validated for automated installed lifecycle
accepted: unknown
blocked: human-visible SmartScreen and dedicated-account validation if required
```

No beta acceptance is claimed.

## Deviations Or Limits

- A dedicated separate Windows test account was not used; automated validation used the current ordinary Windows user with existing Markei data backed up and restored.
- Visual/manual UI confirmation of Register, Lists, History, and Settings remains human validation. Automated installed lifecycle evidence exercised the same `ProductService` and database path used by the installed desktop application.
- The Inno architecture warning remains as non-blocking implementation debt.

## Prohibited Scope Check

No mobile, backend, API, synchronization, authentication, cloud, schema redesign, transaction redesign, broad service/repository decomposition, one-file packaging, auto-update, signing, rollback framework, optional uninstall data deletion UX, or permanent Sketch Notebook promotion was introduced.
