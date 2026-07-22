begin;

do $$
begin
  if not exists (
    select 1
      from public.migration_ledger
     where migration_id = '006_hosted_authorization_r3'
       and checksum = 'c10-s03a-r3-hosted-authorization-v1'
  ) then
    raise exception 'required migration 006_hosted_authorization_r3 is missing';
  end if;

  if exists (
    select 1
      from public.migration_ledger
     where migration_id = '007_account_cursor_provisioning'
       and checksum <> 'c10-mcg02-account-cursor-provisioning-v1'
  ) then
    raise exception 'migration 007_account_cursor_provisioning checksum mismatch';
  end if;
end
$$;

insert into public.migration_ledger(migration_id, checksum)
values(
  '007_account_cursor_provisioning',
  'c10-mcg02-account-cursor-provisioning-v1'
)
on conflict(migration_id) do nothing;

insert into public.account_cursor_state(account_id, next_cursor)
select a.account_id,
       coalesce(max(se.server_cursor), 0) + 1 as next_cursor
  from public.accounts a
  left join public.sync_events se
    on se.account_id = a.account_id
 where not exists (
   select 1
     from public.account_cursor_state cs
    where cs.account_id = a.account_id
 )
 group by a.account_id
on conflict(account_id) do nothing;

create or replace function public.markei_provision_account_cursor_state()
returns trigger
language plpgsql
security definer
set search_path = pg_catalog, public
as $$
begin
  insert into public.account_cursor_state(account_id, next_cursor)
  values (new.account_id, 1)
  on conflict(account_id) do nothing;
  return new;
end;
$$;

revoke all on function public.markei_provision_account_cursor_state() from public;
revoke all on function public.markei_provision_account_cursor_state() from markei_runtime;

drop trigger if exists accounts_provision_cursor_state_after_insert
  on public.accounts;
create trigger accounts_provision_cursor_state_after_insert
after insert on public.accounts
for each row
execute function public.markei_provision_account_cursor_state();

revoke all on public.account_cursor_state from markei_runtime;
grant select, update(next_cursor) on public.account_cursor_state to markei_runtime;

create or replace function public.markei_hosted_runtime_ready_v2()
returns boolean
language sql
security definer
stable
set search_path = pg_catalog, public
as $$
  select exists (
    select 1
      from public.migration_ledger ml
     where ml.migration_id = '006_hosted_authorization_r3'
       and ml.checksum = 'c10-s03a-r3-hosted-authorization-v1'
  )
  and exists (
    select 1
      from public.migration_ledger ml
     where ml.migration_id = '007_account_cursor_provisioning'
       and ml.checksum = 'c10-mcg02-account-cursor-provisioning-v1'
  );
$$;

revoke all on function public.markei_hosted_runtime_ready_v2() from public;
grant execute on function public.markei_hosted_runtime_ready_v2() to markei_runtime;

commit;
