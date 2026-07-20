# D_OPS_STAGE — Hosted Account/Device Binding and Scoped Sync

> Authority marker: C10-MCG02-HOSTED-BINDING-R2_20260720T131954Z
> Required ancestor: 4382c09c038e41c1dc269141d40c31c258516b61
> Status: **ACTIVE BOUNDED CODEX AUTHORITY**

## Accepted evidence

Windows runtime packaging is automatically proved at `734c559`: clean Debug/Release builds and
direct/sanitized callback launches passed without vcpkg PATH assistance or manual DLL copying. A
fresh human Auth0 retest from that exact artifact has not been reconciled and remains pending. It is
not a prerequisite for this local-only correction and must not be claimed or performed by Codex.

## Objective

Bind a restarted Flutter composition to the durable hosted AccountId and server DeviceId returned by
enrollment, and scope every hosted synchronization operation to that binding. Existing local-only
facts, immutable events and pending work must remain unchanged and must never enter the hosted lane.

## Required implementation

1. Keep the pre-enrollment composition local-only.
2. Validate a stored binding before activation: environment, completed/active enrollment state,
   AccountId, server DeviceId, installation identity and positive generation must be complete and
   syntactically valid. Invalid, incomplete, revoked or expired state fails closed to local-only and
   cannot authorize hosted sync.
3. Successful enrollment persists the binding and returns `hosted-restart-required`; the same
   process must not sync using its pre-enrollment local composition.
4. On restart, select the hosted AccountId/server DeviceId for new registration and hosted sync.
   Ensure the corresponding local Account/Device identity rows exist without rewriting old rows.
5. Add explicit AccountId and DeviceId scope to hosted outbox leasing and unknown-submission replay.
   Mixed, local-only or foreign pending events must not be selected or mutated.
6. Scope inbox validation, cursor lookup/update, fact application and acknowledgement to the hosted
   AccountId. Reject cross-Account pages atomically and preserve cursor/facts/inbox on rejection.
7. Keep unscoped adapters only where existing isolated local-lab compatibility requires them;
   production/native hosted composition must use scoped forms.
8. Preserve authentication, callback, packaging, server authorization, migration and schema behavior.

## Decisive proof

Use file-backed Drift and the real loopback HTTP/server authorization path to prove:

- pre-enrollment registration remains local-only;
- enrollment completion blocks sync with `hosted-restart-required`;
- close/reopen activates the exact stored hosted Account/Device binding;
- the first new hosted event embeds those exact IDs and has a valid unchanged v3 hash;
- older local-only pending events are not leased, relabeled or changed;
- hosted upload/download/apply/ack succeeds only for the bound Account/Device;
- unknown replay cannot cross the binding;
- cross-Account download fails without fact, inbox or cursor mutation;
- malformed, incomplete, revoked and expired bindings fail closed;
- two isolated databases bind one hosted Account to distinct server Devices, converge, close and
  reopen with equal authoritative hosted facts;
- API unavailability preserves local registration and pending hosted work.

## Decisive validation

Run Drift generation only if required by source changes, Dart format check, Flutter analysis, focused
and complete Flutter tests, affected API tests, Android debug and Windows release when host-supported,
`git diff --check`, changed-path inventory and tracked/staged secret/binary scans. Record exact
commands, counts and exclusions in replacement G/H/I.

## Boundaries

No real Auth0 login, provider enrollment/sync, Auth0/Render/Neon mutation, migration, Drift schema
change/reset, dependency upgrade, server authorization weakening, automatic Account migration,
product UI redesign, permanent documentation, MCG-03 or MCG-04 is authorized. Never read private
provider files. Replace only G/H/I and publish one bounded implementation commit.

Success terminal:

~~~text
MCG-02_HOSTED_IDENTITY_BINDING=true
MCG-02_HOSTED_OUTBOX_SCOPED=true
MCG-02_HOSTED_CURSOR_APPLIER_SCOPED=true
MCG-02_LOCAL_ONLY_EVENTS_PRESERVED=true
MCG-02_TWO_DEVICE_BINDING_CONVERGED=true
MCG-02_DECISIVE_PROVIDER_PROOF_READY
~~~

Otherwise report `MCG-02_HOSTED_IDENTITY_BINDING_PARTIAL` with the exact blocker.
