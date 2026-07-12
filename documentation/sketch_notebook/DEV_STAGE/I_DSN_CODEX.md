# I_DSN_CODEX — Cycle 06 Sprint 02 Design Codex Report

> Status: Codex evidence report
> Branch: `sketch-notebook-recovery`
> Source stage: `F_DSN_STAGE.md`
> Date: 2026-07-12

## Design Materialization Status

Permanent Design files were not modified.

This report records whether Sprint 02 installed lifecycle validation preserved accepted Design boundaries. It does not update permanent Design memory or reopen Main decisions.

## Boundaries Preserved

- Desktop UI remained the application surface.
- Desktop workflow continued through `ProductService`.
- `ProductService` continued through `Repository`.
- `Repository` continued through the database layer.
- SQLite remained the persistence store.
- `%LOCALAPPDATA%\Markei` remained the writable per-user data location.
- `schema.sql` remained the bundled production resource.
- `seed.sql` remained excluded from the production frozen package.
- `market.sqlite` remained user data and was not bundled.
- Installer uninstall behavior retained user data by default.
- Startup diagnostics remained under `%LOCALAPPDATA%\Markei\logs`.
- Installer identity and shortcut behavior remained centralized in `installer/Markei.iss`.
- Frozen packaging remained centralized in `Markei.spec`, with `scripts/build_windows.ps1` acting as a wrapper.

## Bounded Design-Relevant Corrections

### Installer Wrapper

`scripts/build_installer.ps1` now discovers the Inno Setup per-user install path. This preserves one authoritative installer configuration and changes only compiler discovery.

### Structural Production Defaults

`app/core/database.py` now creates only required structural defaults during migration:

- category `F` / `General`
- store `1` / `Default Store`

This preserves the accepted production seed policy because sample products and purchases are still absent from fresh production databases.

## Installed Lifecycle Evidence

Clean install:

```text
installed
```

Start Menu launch:

```text
launched
```

Register / Lists / History / Settings data path:

```text
validated
```

Close and immediate reopen:

```text
validated
```

Same-version reinstall:

```text
validated
```

Uninstall with retained user data:

```text
validated
```

Reinstall and retained-data recovery:

```text
validated
```

SmartScreen / antivirus:

```text
unknown
```

No installed lifecycle gate required a redesign of the Desktop, ProductService, Repository, Database Manager, or SQLite boundaries.

## Artifact And Identity Evidence

Installer artifact:

```text
dist\installer\Markei-Setup-0.1.0-x64.exe
SHA256: 122A772D66BBE7D5522EF2262E7E89D6D2E332B6318135BB25D55A27F75F4623
```

Frozen executable:

```text
dist\Markei\Markei.exe
SHA256: E13E276139E5F680D91A9816FC79776EB9837CA901C2DEBCF6B9CFAF8594A282
```

Installed executable:

```text
%LOCALAPPDATA%\Programs\Markei\Markei.exe
```

Start Menu shortcut:

```text
%APPDATA%\Microsoft\Windows\Start Menu\Programs\Markei\Markei.lnk
```

## Explicit Deferrals Preserved

No mobile, backend/API, synchronization, authentication, cloud persistence, auto-update, signing, rollback framework, migration ledger, broad `ProductService`/`Repository` decomposition, UI/navigation redesign, optional uninstall data-removal UX, or one-file packaging was introduced.

## Remaining Design Follow-Up

Design Chat may later decide how to absorb the installed lifecycle evidence into permanent Design memory. Codex did not perform semantic promotion or beta acceptance.
