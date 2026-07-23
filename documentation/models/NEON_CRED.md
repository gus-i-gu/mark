# Markei Neon connection coordinates

> This file contains connection coordinates, never credentials.
> It may be committed only while every password, token, and complete URL remains absent.

```text
Environment: development
ProjectAlias: <NEON_PROJECT_ALIAS>
BranchAlias: markei-cycle10-development
Region: aws-us-west-2
PostgreSQLVersion: 18
Host: <DIRECT_EP_HOSTNAME>.neon.tech
Port: 5432
Database: markei_sync_dev
RuntimeUser: markei_runtime
MigratorUser: markei_migrator
DbOwnerUser: neondb_owner
```

## Where each value comes from

- `ProjectAlias`: Neon project overview.
- `BranchAlias`: Neon development branch name.
- `Region`: project region; Markei currently uses US West 2.
- `PostgreSQLVersion`: project PostgreSQL major version.
- `Host`: Neon **Direct connection** hostname for the intended branch. Copy only
  the `ep-....neon.tech` hostname.
- `Database`: disposable development database.
- `RuntimeUser`: least-privilege hosted application role.
- `MigratorUser`: migration and catalog-inspection role.
- `DbOwnerUser`: administrative owner; use only for an explicitly owner-only task.

## Credentials

`NEON_CHECK.ps1` requests the selected role password through a masked Windows
credential dialog. Supply:

| Selected role | Username | Password required |
| --- | --- | --- |
| `runtime` | `markei_runtime` | Current runtime-role password |
| `migrator` | `markei_migrator` | Current migrator-role password |
| `dbowner` | `neondb_owner` | Current development-owner password |

Do not put a password or complete PostgreSQL URL in this file, Git, chat,
screenshots, SQL, notebook files, or shell history.

## Target guard

Before any mutation, independently confirm in Neon:

```text
Environment = development
BranchAlias = markei-cycle10-development
Database = markei_sync_dev
```

The database name alone does not prove the branch.
