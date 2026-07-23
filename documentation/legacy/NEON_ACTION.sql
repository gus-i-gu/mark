-- Markei Neon action catalogue
-- NEON_CHECK.ps1 extracts one block between ACTION markers.
-- Keep routine actions read-only and return sanitized evidence only.

-- ACTION: connection
SELECT
    current_user AS connected_role,
    current_database() AS connected_database,
    COALESCE(s.ssl, false) AS ssl_enabled,
    s.version AS tls_version,
    s.cipher AS tls_cipher
FROM pg_stat_ssl AS s
WHERE s.pid = pg_backend_pid();
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
SELECT status,
       next_expected_sequence,
       count(*) AS device_count
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
SELECT has_schema_privilege('markei_runtime', 'public', 'USAGE')
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

