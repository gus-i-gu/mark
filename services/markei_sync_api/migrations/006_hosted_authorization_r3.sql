begin;

insert into migration_ledger(migration_id, checksum)
values('006_hosted_authorization_r3', 'c10-s03a-r3-hosted-authorization-v1')
on conflict(migration_id) do nothing;

create or replace function public.markei_hosted_runtime_ready()
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
  );
$$;

revoke all on function public.markei_hosted_runtime_ready() from public;
grant execute on function public.markei_hosted_runtime_ready() to markei_runtime;
revoke execute on function public.markei_required_migration_present(text) from markei_runtime;

commit;
