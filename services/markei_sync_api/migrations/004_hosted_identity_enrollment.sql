begin;

insert into migration_ledger(migration_id, checksum)
values('004_hosted_identity_enrollment', 'c10-s03a-hosted-identity-v1')
on conflict(migration_id) do nothing;

create table if not exists external_identities (
  identity_id uuid primary key,
  issuer text not null check(length(issuer) between 12 and 512),
  subject text not null check(length(subject) between 1 and 256),
  status text not null check(status in ('active', 'disabled')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique(issuer, subject)
);

create table if not exists account_memberships (
  account_id uuid not null references accounts(account_id),
  identity_id uuid not null references external_identities(identity_id),
  role text not null check(role in ('owner', 'member')),
  status text not null check(status in ('active', 'disabled', 'removed')),
  membership_version bigint not null default 1 check(membership_version > 0),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key(account_id, identity_id)
);

create table if not exists device_enrollments (
  account_id uuid not null,
  installation_id uuid not null,
  device_id uuid not null,
  identity_id uuid not null references external_identities(identity_id),
  state text not null check(state in ('active', 'revoked', 'replaced')),
  generation bigint not null default 1 check(generation > 0),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key(account_id, installation_id),
  unique(account_id, device_id),
  foreign key(account_id, device_id) references devices(account_id, device_id)
);

create table if not exists device_enrollment_requests (
  account_id uuid not null,
  identity_id uuid not null references external_identities(identity_id),
  enrollment_request_id uuid not null,
  installation_id uuid not null,
  request_hash text not null check(length(request_hash) = 64),
  state text not null check(state in ('pending', 'completed', 'failed', 'expired', 'rate-limited')),
  device_id uuid,
  stored_result jsonb,
  expires_at timestamptz not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key(account_id, identity_id, enrollment_request_id),
  foreign key(account_id, identity_id) references account_memberships(account_id, identity_id),
  foreign key(account_id, installation_id) references device_enrollments(account_id, installation_id)
    deferrable initially deferred,
  foreign key(account_id, device_id) references devices(account_id, device_id)
);

create table if not exists device_security_events (
  event_id uuid primary key,
  account_id uuid not null references accounts(account_id),
  actor_identity_id uuid references external_identities(identity_id),
  target_device_id uuid,
  event_type text not null check(event_type in ('device-enrolled', 'device-revoked')),
  correlation_id text not null check(length(correlation_id) between 1 and 128),
  occurred_at timestamptz not null default now(),
  foreign key(account_id, target_device_id) references devices(account_id, device_id)
);

create index if not exists account_memberships_identity_active_idx
  on account_memberships(identity_id, status, account_id);
create index if not exists device_enrollments_identity_idx
  on device_enrollments(identity_id, state);
create index if not exists device_enrollment_requests_lookup_idx
  on device_enrollment_requests(account_id, identity_id, enrollment_request_id, state);
create index if not exists device_security_events_account_time_idx
  on device_security_events(account_id, occurred_at desc);

alter table account_memberships enable row level security;
alter table device_enrollments enable row level security;
alter table device_enrollment_requests enable row level security;
alter table device_security_events enable row level security;

create policy account_memberships_context_isolation on account_memberships
  using (
    account_id::text = current_setting('markei.account_id', true)
    or identity_id::text = current_setting('markei.identity_id', true)
  )
  with check (account_id::text = current_setting('markei.account_id', true));

create policy device_enrollments_account_isolation on device_enrollments
  using (account_id::text = current_setting('markei.account_id', true))
  with check (account_id::text = current_setting('markei.account_id', true));

create policy device_enrollment_requests_account_isolation on device_enrollment_requests
  using (account_id::text = current_setting('markei.account_id', true))
  with check (account_id::text = current_setting('markei.account_id', true));

create policy device_security_events_account_isolation on device_security_events
  using (account_id::text = current_setting('markei.account_id', true))
  with check (account_id::text = current_setting('markei.account_id', true));

grant select on external_identities to markei_runtime;
grant select on account_memberships to markei_runtime;
grant select, insert, update on devices to markei_runtime;
grant select, insert, update on device_enrollments to markei_runtime;
grant select, insert, update on device_enrollment_requests to markei_runtime;
grant select, insert on device_security_events to markei_runtime;

commit;
