# Markei Neon connection configuration

This file contains only non-secret connection settings. It may be committed.
`NEON_CHECK.ps1` requests the selected role's password through a masked Windows
credential prompt. Never put a password or complete connection URL in this file.

Replace each `<...>` placeholder before running the helper.

```text
Host: ep-raspy-brook-afhm7zmw.c-2.us-west-2.aws.neon.tech
Port: 5432
Database: markei_sync_dev
RuntimeUser: markei_runtime
MigratorUser: markei_migrator
DbOwnerUser: neondb_owner
```

Where to find each value:

- `Host`: Neon dashboard → project → development branch → Connect → Direct
  connection. Copy only the hostname. Do not include `postgresql://`, username,
  password, `@`, database path, or query parameters.
- `Port`: normally `5432`.
- `Database`: the disposable development database, currently
  `markei_sync_dev`.
- `RuntimeUser`: the least-privilege application role.
- `MigratorUser`: the migration/inspection role.
- `DbOwnerUser`: the Neon administrative owner role. Use only when an action
  genuinely requires ownership authority.
- Password: do not place it here. Enter it only in the masked prompt opened by
  `NEON_CHECK.ps1`.

Secret-storage rules:

- Never commit passwords, tokens, or complete PostgreSQL URLs.
- Never paste them into chat, screenshots, Markdown, SQL, or shell history.
- Use the direct endpoint for migrations and administrative checks.
- Keep production credentials separate from this development configuration.

