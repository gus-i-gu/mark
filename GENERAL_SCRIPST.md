# Markei General Scripts

> Reusable operational index for Git, Neon migrations, Render, Auth0, and build checks.
>
> Repository: `gus-i-gu/markei`  
> Branch: `intermid-cycle-recovery`

## 0. Safety rules

- Never paste passwords, database URLs, bearer tokens, API tokens, client secrets, or private IDs into Git, chat, screenshots, logs, or notebooks.
- Keep provider values in a private secrets note and load them locally as environment variables.
- Use the Neon development branch/database for migration work. Stop if the target might be production.
- Use `markei_migrator` for migrations and catalog verification. Render uses `markei_runtime`.
- Never put `MARKEI_SYNC_MIGRATOR_DATABASE_URL` in Render; the hosted service deliberately rejects it.
- Run one migration once. If execution reports an error, inspect the ledger and catalog before retrying statements.
- Apply database migration before deploying code that depends on it.
- Health checks are read-only. Sync, enrollment, revocation, and replay routes are not health checks.

## 1. Private coordinates checklist

Store the following **values** outside the repository. This file records only their names.

### Git/GitHub

- Repository: `gus-i-gu/markei`
- Branch: `intermid-cycle-recovery`
- Local repository path
- Authorized deployment full commit SHA

### Neon development

- Project alias
- Branch alias
- Region
- PostgreSQL version
- Database name
- Direct migrator URL for `markei_migrator`
- Pooled runtime URL for `markei_runtime`
- Direct runtime URL, if used for diagnostics
- Latest password-rotation date for each role

### Render

- Service name
- Service ID
- Public service origin, without a trailing slash
- Watched repository and branch
- Render management API token, if management inspection is automated

### Auth0

- Tenant/domain
- Issuer URL, normally `https://<tenant-domain>/`
- API audience/identifier
- JWKS URL, normally `https://<tenant-domain>/.well-known/jwks.json`
- Native application client ID
- Allowed callback/logout/web-origin values
- Signing algorithm: `RS256`

Do **not** store Auth0 client secrets in the mobile client. A public/native application normally uses a client ID plus PKCE.

## 2. Load private values in PowerShell

Set values only in the current terminal session:

```powershell
$env:MARKEI_NEON_MIGRATOR_URL = Read-Host "Neon migrator URL"
$env:MARKEI_NEON_RUNTIME_URL  = Read-Host "Neon runtime URL"
$env:MARKEI_RENDER_ORIGIN     = Read-Host "Render origin"
$env:MARKEI_AUTH_ISSUER       = Read-Host "Auth0 issuer"
$env:MARKEI_AUTH_AUDIENCE     = Read-Host "Auth0 audience"
```

Avoid commands that print environment variables. Close the terminal when finished.

## 3. Git synchronization check

```powershell
git fetch --prune origin
git status --short --branch
git branch --show-current
git rev-parse HEAD
git rev-parse origin/intermid-cycle-recovery
git rev-list --left-right --count origin/intermid-cycle-recovery...HEAD
```

Interpret divergence:

| Output | Meaning |
| --- | --- |
| `0 0` | Local and remote agree |
| `0 N` | Local is ahead by `N` commits |
| `N 0` | Local is behind by `N` commits |
| `N M` | Histories diverged; stop and investigate |

Before a fast-forward pull with local modifications:

```powershell
git diff --name-only HEAD..origin/intermid-cycle-recovery
git pull --ff-only
```

Stop if the remote commit overlaps a locally modified file.

Record full SHAs:

```powershell
$LocalSha  = git rev-parse HEAD
$RemoteSha = git rev-parse origin/intermid-cycle-recovery
[pscustomobject]@{ Local = $LocalSha; Remote = $RemoteSha }
```

## 4. General migration application

### 4.1 Identify and hash the migration

Run from the repository root:

```powershell
$Migration = "services/markei_sync_api/migrations/007_account_cursor_provisioning.sql"
git ls-files --error-unmatch $Migration
git status --short -- $Migration
git log -1 --format="%H %s" -- $Migration
Get-FileHash -Algorithm SHA256 $Migration
```

The Git blob/file SHA-256 and the migration ledger checksum are different evidence classes. Do not compare them as if they were the same value.

### 4.2 Verify the connection without revealing it

Using `psql`:

```powershell
psql "$env:MARKEI_NEON_MIGRATOR_URL" `
  -X -v ON_ERROR_STOP=1 `
  -c "select current_user, current_database(), current_setting('ssl') as ssl;"
```

Required classification:

- user is `markei_migrator`;
- database and branch are the intended disposable development target;
- SSL is `on`.

The database name alone does not prove the Neon branch. Confirm the branch in the Neon dashboard before execution.

### 4.3 Generic read-only ledger preflight

```sql
begin transaction read only;

select migration_id, checksum, applied_at
from public.migration_ledger
order by migration_id;

select
  to_regprocedure('public.markei_hosted_runtime_ready_v2()') as readiness_v2,
  to_regprocedure('public.markei_provision_account_cursor_state()') as provisioning_function;

rollback;
```

### 4.4 Apply an exact repository migration with `psql`

```powershell
psql "$env:MARKEI_NEON_MIGRATOR_URL" `
  -X -v ON_ERROR_STOP=1 `
  -f "services/markei_sync_api/migrations/007_account_cursor_provisioning.sql"
```

The migration file contains `begin;` and `commit;`. Do not wrap it in another manual transaction.

### 4.5 Neon SQL Editor alternative

1. Open the intended development branch and database in Neon.
2. Confirm the editor target again.
3. Run:

```sql
select current_user, current_database(), current_setting('ssl') as ssl;
```

4. Require `current_user = markei_migrator`. If the editor uses `neondb_owner`, prefer the direct `psql` method rather than weakening role evidence.
5. Open the exact committed migration file:
   `services/markei_sync_api/migrations/007_account_cursor_provisioning.sql`.
6. Paste the entire file unchanged and press **Run once**.
7. If the editor reports an error or appears to time out, do not press Run again until post-state is inspected.

## 5. Milestone 03 — migration 007

Current migration identity:

```text
migration_id = 007_account_cursor_provisioning
ledger checksum = c10-mcg02-account-cursor-provisioning-v1
required predecessor = 006_hosted_authorization_r3
required predecessor checksum = c10-s03a-r3-hosted-authorization-v1
```

### 5.1 Pre-migration query

```sql
begin transaction read only;

select current_user, current_database(), current_setting('ssl') as ssl;

select migration_id, checksum, applied_at
from public.migration_ledger
where migration_id in (
  '006_hosted_authorization_r3',
  '007_account_cursor_provisioning'
)
order by migration_id;

select
  to_regprocedure('public.markei_hosted_runtime_ready_v2()') as readiness_v2,
  to_regprocedure('public.markei_provision_account_cursor_state()') as provisioning_function,
  (
    select count(*)
    from pg_trigger
    where tgname = 'accounts_provision_cursor_state_after_insert'
      and not tgisinternal
  ) as provisioning_trigger_count;

select
  (select count(*) from public.accounts) as account_count,
  (select count(*) from public.account_cursor_state) as cursor_state_count,
  (
    select count(*)
    from public.accounts a
    left join public.account_cursor_state cs using (account_id)
    where cs.account_id is null
  ) as accounts_missing_cursor_state;

rollback;
```

Required pre-state:

- migration 006 exists with the exact expected checksum;
- migration 007 is absent;
- readiness-v2, provisioning function, and trigger are absent;
- record sanitized counts for comparison.

If migration 007 or readiness-v2 already exists unexpectedly, stop and reconcile before applying anything.

### 5.2 Execute migration 007

Preferred:

```powershell
psql "$env:MARKEI_NEON_MIGRATOR_URL" `
  -X -v ON_ERROR_STOP=1 `
  -f "services/markei_sync_api/migrations/007_account_cursor_provisioning.sql"
```

### 5.3 Post-migration verification query

```sql
begin transaction read only;

select migration_id, checksum, applied_at
from public.migration_ledger
where migration_id = '007_account_cursor_provisioning';

select public.markei_hosted_runtime_ready_v2() as readiness_v2;

select
  to_regprocedure('public.markei_provision_account_cursor_state()') as provisioning_function,
  (
    select count(*)
    from pg_trigger
    where tgname = 'accounts_provision_cursor_state_after_insert'
      and tgrelid = 'public.accounts'::regclass
      and not tgisinternal
  ) as provisioning_trigger_count;

select
  (select count(*) from public.accounts) as account_count,
  (select count(*) from public.account_cursor_state) as cursor_state_count,
  (
    select count(*)
    from public.accounts a
    left join public.account_cursor_state cs using (account_id)
    where cs.account_id is null
  ) as accounts_missing_cursor_state,
  (
    select count(*)
    from public.account_cursor_state cs
    left join public.accounts a using (account_id)
    where a.account_id is null
  ) as orphan_cursor_state_rows;

select
  has_table_privilege('markei_runtime', 'public.account_cursor_state', 'SELECT')
    as runtime_select,
  has_table_privilege('markei_runtime', 'public.account_cursor_state', 'INSERT')
    as runtime_insert,
  has_table_privilege('markei_runtime', 'public.account_cursor_state', 'DELETE')
    as runtime_delete,
  has_column_privilege(
    'markei_runtime',
    'public.account_cursor_state',
    'next_cursor',
    'UPDATE'
  ) as runtime_update_next_cursor,
  has_function_privilege(
    'markei_runtime',
    'public.markei_hosted_runtime_ready_v2()',
    'EXECUTE'
  ) as runtime_execute_readiness_v2,
  has_function_privilege(
    'markei_runtime',
    'public.markei_provision_account_cursor_state()',
    'EXECUTE'
  ) as runtime_execute_provisioning;

select
  p.proname,
  pg_get_userbyid(p.proowner) as owner,
  p.prosecdef as security_definer
from pg_proc p
join pg_namespace n on n.oid = p.pronamespace
where n.nspname = 'public'
  and p.proname in (
    'markei_hosted_runtime_ready_v2',
    'markei_provision_account_cursor_state'
  )
order by p.proname;

rollback;
```

Required post-state:

- exactly one ledger row with the expected migration ID/checksum;
- `readiness_v2 = true`;
- provisioning function exists;
- provisioning trigger count is `1`;
- missing and orphan cursor-state counts are `0`;
- runtime: `SELECT=true`, `INSERT=false`, `DELETE=false`;
- runtime may update only `next_cursor`;
- runtime can execute readiness-v2;
- runtime cannot execute the provisioning function;
- functions are owned by the intended migration owner and use the expected security mode.

### 5.4 Runtime smoke check

Use the runtime connection separately:

```powershell
psql "$env:MARKEI_NEON_RUNTIME_URL" `
  -X -v ON_ERROR_STOP=1 `
  -c "select current_user, current_database(), public.markei_hosted_runtime_ready_v2() as ready;"
```

Expected: `current_user = markei_runtime` and `ready = true`.

## 6. Render configuration and deployment

### 6.1 Required runtime environment names

The current Sync API reads:

```text
NODE_ENV
PORT
MARKEI_SYNC_DATABASE_URL
MARKEI_AUTH_ISSUER
MARKEI_AUTH_AUDIENCE
MARKEI_PUBLIC_ORIGIN
MARKEI_LOG_LEVEL
MARKEI_AUTH_JWKS_URI        optional; derived from issuer when omitted
```

`MARKEI_SYNC_DATABASE_URL` must be the runtime URL, normally pooled. Never configure the migrator URL in Render.

### 6.2 Local API validation before deployment

```powershell
Push-Location services/markei_sync_api
npm ci --include=dev
npm run format:check
npm run lint
npm run typecheck
npm test
npm run build
Pop-Location
```

### 6.3 Select and record the authorized commit

After pulling:

```powershell
git fetch --prune origin
$AuthorizedSha = git rev-parse origin/intermid-cycle-recovery
$AuthorizedSha
git merge-base --is-ancestor 0c8b37a63c1003431474df0972b846d3c8531a1a $AuthorizedSha
```

Exit code `0` from `merge-base` proves the authorized commit contains the migration-007 implementation baseline. Record the full SHA, not only the seven-character abbreviation.

### 6.4 Deploy exactly once

With auto-deploy off:

1. Confirm migration 007 post-verification passed.
2. Confirm no deployment is running.
3. Confirm Render watches `gus-i-gu/markei` → `intermid-cycle-recovery`.
4. Confirm GitHub’s branch head equals the recorded authorized SHA.
5. Use **Deploy latest commit** once.
6. Record deployment start time.
7. Wait for the terminal event.
8. Require Render’s deployed commit to equal the authorized SHA.

Do not click a second deployment while the first is building or activating.

### 6.5 Health checks

```powershell
$Origin = $env:MARKEI_RENDER_ORIGIN.TrimEnd("/")

$Live = Invoke-WebRequest `
  -Uri "$Origin/health/live" `
  -Method Get `
  -MaximumRedirection 0 `
  -SkipHttpErrorCheck

$Ready = Invoke-WebRequest `
  -Uri "$Origin/health/ready" `
  -Method Get `
  -MaximumRedirection 0 `
  -SkipHttpErrorCheck

[pscustomobject]@{
  LiveStatus  = [int]$Live.StatusCode
  LiveBody    = $Live.Content
  ReadyStatus = [int]$Ready.StatusCode
  ReadyBody   = $Ready.Content
}
```

Expected after migration 007 and corrected deployment:

```text
GET /health/live  -> HTTP 200, {"status":"live"}
GET /health/ready -> HTTP 200, {"status":"ready"}
```

Note: the current implementation reports readiness in the JSON body. Record both HTTP status and body classification.

## 7. Auth0 checks

### 7.1 Public metadata and JWKS reachability

```powershell
$Issuer = $env:MARKEI_AUTH_ISSUER.TrimEnd("/")
$Discovery = Invoke-RestMethod "$Issuer/.well-known/openid-configuration"
$Jwks = Invoke-RestMethod "$Issuer/.well-known/jwks.json"

[pscustomobject]@{
  IssuerMatches = ($Discovery.issuer.TrimEnd("/") -eq $Issuer)
  JwksKeys      = @($Jwks.keys).Count
  HasRs256Key   = @($Jwks.keys | Where-Object {
    $_.kty -eq "RSA" -and $_.use -eq "sig" -and $_.alg -eq "RS256"
  }).Count -gt 0
}
```

Required:

- discovery issuer matches `MARKEI_AUTH_ISSUER`;
- JWKS contains at least one RSA signing key;
- at least one signing key declares `RS256`;
- the API audience in Auth0 exactly matches `MARKEI_AUTH_AUDIENCE`.

Do not paste access tokens into diagnostic commands that may be saved in shell history. Authenticated route testing should use the app’s normal login flow or a deliberately protected local procedure.

## 8. Flutter build checks

From the Flutter project root:

```powershell
flutter pub get
flutter analyze
flutter test
flutter build windows --release
flutter build apk --debug
```

For generated Drift code, run the repository’s documented generation command before analysis when schema/source changes require it.

## 9. Evidence worksheet

Record sanitized results:

```text
timestamp_utc=
local_branch=
local_full_sha=
github_full_sha=
git_divergence=
worktree_classification=

neon_target_classification=development
neon_migrator_identity=
neon_runtime_identity=
migration_006=
migration_007=
readiness_v2=
missing_cursor_state_rows=
runtime_privilege_result=

render_watched_branch=
render_previous_full_sha=
render_authorized_full_sha=
render_deployed_full_sha=
render_terminal_status=
health_live_status_and_class=
health_ready_status_and_class=

auth0_issuer_match=
auth0_audience_match=
auth0_rs256_jwks=

sync_or_enrollment_action_performed=no
```

## 10. Stop conditions

Stop before mutation if:

- the Neon target might be production;
- the role is not `markei_migrator`;
- migration 006 is absent or has the wrong checksum;
- migration 007/readiness-v2 is already present unexpectedly;
- GitHub advanced after the authorized SHA was selected;
- Render watches another repository or branch;
- another deployment is running;
- a command would print a secret;
- a migration execution returned an unclear result;
- post-migration invariants fail.

After a migration error, run only read-only ledger/catalog checks. Do not reconstruct or partially rerun the migration by hand.
