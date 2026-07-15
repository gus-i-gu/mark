begin;

create table if not exists migration_ledger (
  migration_id text primary key,
  checksum text not null,
  applied_at timestamptz not null default now()
);

insert into migration_ledger(migration_id, checksum)
values('002_coordination_hardening', 'c10-s01b-forward-only-v1')
on conflict(migration_id) do nothing;

alter table submissions
  add constraint submissions_device_fk
  foreign key(account_id, device_id)
  references devices(account_id, device_id);

alter table sync_events
  add constraint sync_events_device_fk
  foreign key(account_id, device_id)
  references devices(account_id, device_id);

alter table device_acknowledgements
  add constraint device_acknowledgements_device_fk
  foreign key(account_id, device_id)
  references devices(account_id, device_id);

create index if not exists sync_events_download_idx
  on sync_events(account_id, server_cursor);

create index if not exists sync_events_replay_idx
  on sync_events(account_id, event_id, content_hash);

create index if not exists submissions_replay_idx
  on submissions(account_id, device_id, submission_id, request_hash);

create index if not exists device_acknowledgements_lookup_idx
  on device_acknowledgements(account_id, device_id, greatest_contiguous_cursor);

revoke all on schema public from public;
grant usage on schema public to markei_runtime;

revoke all on accounts from markei_runtime;
revoke all on devices from markei_runtime;
grant select on accounts to markei_runtime;
grant select, update(next_expected_sequence) on devices to markei_runtime;

grant select, insert, update on account_cursor_state to markei_runtime;
grant select, insert, update on submissions to markei_runtime;
grant select, insert, update on sync_events to markei_runtime;
grant select, insert, update on device_acknowledgements to markei_runtime;

alter table accounts enable row level security;
alter table devices enable row level security;
alter table account_cursor_state enable row level security;
alter table submissions enable row level security;
alter table sync_events enable row level security;
alter table device_acknowledgements enable row level security;

drop policy if exists accounts_account_isolation on accounts;
create policy accounts_account_isolation on accounts
  using (account_id::text = current_setting('markei.account_id', true));

drop policy if exists devices_account_isolation on devices;
create policy devices_account_isolation on devices
  using (
    account_id::text = current_setting('markei.account_id', true)
    and device_id::text = current_setting('markei.device_id', true)
  )
  with check (
    account_id::text = current_setting('markei.account_id', true)
    and device_id::text = current_setting('markei.device_id', true)
  );

drop policy if exists account_cursor_state_account_isolation on account_cursor_state;
create policy account_cursor_state_account_isolation on account_cursor_state
  using (account_id::text = current_setting('markei.account_id', true))
  with check (account_id::text = current_setting('markei.account_id', true));

drop policy if exists submissions_account_isolation on submissions;
create policy submissions_account_isolation on submissions
  using (
    account_id::text = current_setting('markei.account_id', true)
    and device_id::text = current_setting('markei.device_id', true)
  )
  with check (
    account_id::text = current_setting('markei.account_id', true)
    and device_id::text = current_setting('markei.device_id', true)
  );

drop policy if exists sync_events_account_isolation on sync_events;
create policy sync_events_account_isolation on sync_events
  using (account_id::text = current_setting('markei.account_id', true))
  with check (
    account_id::text = current_setting('markei.account_id', true)
    and device_id::text = current_setting('markei.device_id', true)
  );

drop policy if exists device_acknowledgements_account_isolation
  on device_acknowledgements;
create policy device_acknowledgements_account_isolation
  on device_acknowledgements
  using (
    account_id::text = current_setting('markei.account_id', true)
    and device_id::text = current_setting('markei.device_id', true)
  )
  with check (
    account_id::text = current_setting('markei.account_id', true)
    and device_id::text = current_setting('markei.device_id', true)
  );

commit;
