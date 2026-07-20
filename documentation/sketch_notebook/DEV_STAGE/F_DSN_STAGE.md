# F_DSN_STAGE — Hosted Account/Device Binding Design

> Authority marker: C10-MCG02-HOSTED-BINDING-R2_20260720T131954Z
> Status: **ACTIVE DESIGN AUTHORITY**

## Selected boundary

~~~text
pre-enrollment composition -> local-only Account/Device
enrollment result           -> durable hosted binding + restart required
restarted composition       -> validated hosted Account/server Device
hosted adapters             -> explicit Account/Device scope
local-only lane             -> preserved and excluded from hosted sync
~~~

Binding is a new hosted lane in the existing Drift database. It does not rewrite an Account, event,
content hash or historical fact. Production/native composition must construct the registration,
outbox and applier using one validated immutable scope object; it must not independently rediscover
or guess IDs.

## Scoped repositories

- Outbox selection filters pending events by required AccountId and DeviceId before leasing.
- Unknown replay verifies the stored submission has the same AccountId/DeviceId.
- Page application requires every event AccountId to equal the bound AccountId.
- Cursor lookup/update and acknowledgement address only that Account's committed cursor.
- All validation and fact/inbox/cursor writes remain one transaction.
- Cross-scope input returns a typed conflict without partial mutation.

## Invariants

- existing local facts/events retain their original IDs and hashes;
- local-only pending work is never uploaded under hosted credentials;
- new hosted events embed exactly the selected hosted Account/server Device;
- no arbitrary first cursor may be selected from a multi-Account database;
- logout does not erase facts or silently rewrite binding state;
- revoked/expired/incomplete bindings cannot authorize hosted sync;
- no Auth0 subject is treated as AccountId or DeviceId;
- server equality checks remain unchanged and fail closed.

## Compatibility and rollback

Prefer additive scoped constructors/adapters so existing isolated lab callers remain compatible.
No Drift or PostgreSQL migration is authorized. Rollback removes hosted binding selection and scoped
composition wiring while retaining enrollment state, authentication/packaging corrections and every
local or hosted fact/outbox row.
