-- Markei Neon action catalogue
-- NEON_CHECK.ps1 extracts exactly one block between ACTION markers.
-- Routine actions are read-only and return sanitized evidence.

-- ACTION: connection
BEGIN TRANSACTION READ ONLY;
SELECT
    current_user AS connected_role,
    current_database() AS connected_database,
    current_setting('transaction_read_only') AS transaction_read_only;
ROLLBACK;
-- END ACTION

-- ACTION: gate02-preflight
BEGIN TRANSACTION READ ONLY;
SELECT migration_id, checksum, applied_at
FROM public.migration_ledger
WHERE migration_id IN (
    '006_hosted_authorization_r3',
    '007_account_cursor_provisioning'
)
ORDER BY migration_id;

SELECT
    to_regprocedure('public.markei_hosted_runtime_ready_v2()') AS readiness_v2,
    to_regprocedure(
        'public.markei_provision_account_cursor_state()'
    ) AS provisioning_function,
    (
        SELECT count(*)
        FROM pg_trigger
        WHERE tgname = 'accounts_provision_cursor_state_after_insert'
          AND NOT tgisinternal
    ) AS provisioning_trigger_count;

SELECT
    (SELECT count(*) FROM public.accounts) AS account_count,
    (SELECT count(*) FROM public.account_cursor_state)
        AS cursor_state_count,
    (
        SELECT count(*)
        FROM public.accounts AS a
        LEFT JOIN public.account_cursor_state AS cs USING (account_id)
        WHERE cs.account_id IS NULL
    ) AS accounts_missing_cursor_state;
ROLLBACK;
-- END ACTION

-- ACTION: gate02-postflight
BEGIN TRANSACTION READ ONLY;
SELECT migration_id, checksum, applied_at
FROM public.migration_ledger
WHERE migration_id = '007_account_cursor_provisioning';

SELECT public.markei_hosted_runtime_ready_v2() AS readiness_v2;

SELECT
    to_regprocedure(
        'public.markei_provision_account_cursor_state()'
    ) AS provisioning_function,
    (
        SELECT count(*)
        FROM pg_trigger
        WHERE tgname = 'accounts_provision_cursor_state_after_insert'
          AND tgrelid = 'public.accounts'::regclass
          AND NOT tgisinternal
    ) AS provisioning_trigger_count;

SELECT
    (SELECT count(*) FROM public.accounts) AS account_count,
    (SELECT count(*) FROM public.account_cursor_state)
        AS cursor_state_count,
    (
        SELECT count(*)
        FROM public.accounts AS a
        LEFT JOIN public.account_cursor_state AS cs USING (account_id)
        WHERE cs.account_id IS NULL
    ) AS accounts_missing_cursor_state,
    (
        SELECT count(*)
        FROM public.account_cursor_state AS cs
        LEFT JOIN public.accounts AS a USING (account_id)
        WHERE a.account_id IS NULL
    ) AS orphan_cursor_state_rows;

SELECT
    has_table_privilege(
        'markei_runtime', 'public.account_cursor_state', 'SELECT'
    ) AS runtime_select,
    has_table_privilege(
        'markei_runtime', 'public.account_cursor_state', 'INSERT'
    ) AS runtime_insert,
    has_table_privilege(
        'markei_runtime', 'public.account_cursor_state', 'DELETE'
    ) AS runtime_delete,
    has_column_privilege(
        'markei_runtime',
        'public.account_cursor_state',
        'next_cursor',
        'UPDATE'
    ) AS runtime_update_next_cursor,
    has_function_privilege(
        'markei_runtime',
        'public.markei_hosted_runtime_ready_v2()',
        'EXECUTE'
    ) AS runtime_execute_readiness_v2,
    has_function_privilege(
        'markei_runtime',
        'public.markei_provision_account_cursor_state()',
        'EXECUTE'
    ) AS runtime_execute_provisioning;
ROLLBACK;
-- END ACTION

-- ACTION: verify-device
BEGIN TRANSACTION READ ONLY;
SELECT count(*) AS submission_count
FROM public.submissions
WHERE device_id = :'device_id'::uuid;
SELECT count(*) AS sync_event_count
FROM public.sync_events
WHERE device_id = :'device_id'::uuid;
SELECT next_expected_sequence AS device_next_expected_sequence
FROM public.devices
WHERE device_id = :'device_id'::uuid;
ROLLBACK;
-- END ACTION

-- ACTION: list-devices-sanitized
BEGIN TRANSACTION READ ONLY;
SELECT status, next_expected_sequence, count(*) AS device_count
FROM public.devices
GROUP BY status, next_expected_sequence
ORDER BY status, next_expected_sequence;
ROLLBACK;
-- END ACTION

-- ACTION: migration-ledger
BEGIN TRANSACTION READ ONLY;
SELECT migration_id, checksum, applied_at
FROM public.migration_ledger
ORDER BY migration_id;
ROLLBACK;
-- END ACTION

-- ACTION: runtime-privileges
BEGIN TRANSACTION READ ONLY;
SELECT table_name, privilege_type
FROM information_schema.role_table_grants
WHERE grantee = 'markei_runtime'
  AND table_schema = 'public'
ORDER BY table_name, privilege_type;
SELECT
    has_schema_privilege('markei_runtime', 'public', 'USAGE')
        AS schema_usage,
    has_schema_privilege('markei_runtime', 'public', 'CREATE')
        AS schema_create;
ROLLBACK;
-- END ACTION

-- ACTION: schema-inventory
BEGIN TRANSACTION READ ONLY;
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;
SELECT tablename, policyname
FROM pg_policies
WHERE schemaname = 'public'
ORDER BY tablename, policyname;
ROLLBACK;
-- END ACTION
