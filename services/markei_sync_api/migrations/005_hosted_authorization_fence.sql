begin;

insert into migration_ledger(migration_id, checksum)
values('005_hosted_authorization_fence', 'c10-s03a-r2-hosted-authorization-fence-v1')
on conflict(migration_id) do nothing;

create or replace function markei_authorize_identity_membership(
  p_issuer text,
  p_subject text
)
returns table(identity_id uuid, account_id uuid, role text)
language plpgsql
security definer
set search_path = pg_catalog, public
as $$
declare
  v_identity_id uuid;
begin
  if p_issuer is null or length(p_issuer) < 12 or length(p_issuer) > 512 then
    return;
  end if;
  if p_subject is null or length(p_subject) < 1 or length(p_subject) > 256 then
    return;
  end if;

  select ei.identity_id
    into v_identity_id
    from public.external_identities ei
   where ei.issuer = p_issuer
     and ei.subject = p_subject
     and ei.status = 'active'
   for update;

  if v_identity_id is null then
    return;
  end if;

  return query
    select am.identity_id, am.account_id, am.role
      from public.account_memberships am
     where am.identity_id = v_identity_id
       and am.status = 'active'
     order by am.account_id
     for update;
end;
$$;

create or replace function markei_required_migration_present(
  p_migration_id text
)
returns boolean
language sql
security definer
set search_path = pg_catalog, public
stable
as $$
  select exists (
    select 1
      from public.migration_ledger ml
     where ml.migration_id = p_migration_id
  );
$$;

revoke all on function markei_authorize_identity_membership(text, text) from public;
revoke all on function markei_required_migration_present(text) from public;
grant execute on function markei_authorize_identity_membership(text, text) to markei_runtime;
grant execute on function markei_required_migration_present(text) to markei_runtime;

revoke all on migration_ledger from markei_runtime;
revoke insert, update, delete on external_identities from markei_runtime;
revoke insert, update, delete on account_memberships from markei_runtime;

drop policy if exists devices_account_isolation on devices;
create policy devices_account_isolation on devices
  using (
    account_id::text = current_setting('markei.account_id', true)
    and (
      device_id::text = current_setting('markei.device_id', true)
      or current_setting('markei.operation', true) = 'device-management'
    )
  )
  with check (
    account_id::text = current_setting('markei.account_id', true)
    and (
      device_id::text = current_setting('markei.device_id', true)
      or current_setting('markei.operation', true) = 'device-management'
    )
  );

drop policy if exists device_enrollments_account_isolation on device_enrollments;
create policy device_enrollments_account_isolation on device_enrollments
  using (
    account_id::text = current_setting('markei.account_id', true)
    and (
      device_id::text = current_setting('markei.device_id', true)
      or current_setting('markei.operation', true) = 'device-management'
      or identity_id::text = current_setting('markei.identity_id', true)
    )
  )
  with check (
    account_id::text = current_setting('markei.account_id', true)
    and (
      device_id::text = current_setting('markei.device_id', true)
      or current_setting('markei.operation', true) = 'device-management'
      or identity_id::text = current_setting('markei.identity_id', true)
    )
  );

commit;
