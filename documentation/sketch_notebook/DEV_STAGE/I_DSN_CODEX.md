# I_DSN_CODEX - Hosted Binding Design Evidence

- Authority marker: C10-MCG02-HOSTED-BINDING-R2_20260720T131954Z
- Baseline after fast-forward: 9e7af2e306a5159eb51eba9169f5fe0c5f60b5e7
- Final commit SHA: resolved after commit; Codex terminal response reports it.

## Dependency Direction

The implementation keeps production composition at the app boundary:

`hosted state repository -> validated HostedIdentityBinding -> MarkeiComposition identity -> scoped outbox/applier adapters -> sync use cases`.

Domain entities, event payload v3, server authorization and database schema remain unchanged. The
new scope object lives in application ports and is consumed by infrastructure adapters without
creating a dependency from domain code back to hosted authentication.

## Binding Validation

`DriftHostedIdentityRepository.loadActiveBinding()` validates:

- exact expected environment alias;
- active completed enrollment state: `device-enrolled` or `duplicate-equivalent`;
- syntactically valid hosted AccountId;
- syntactically valid server DeviceId;
- stable installation identity string;
- positive generation.

Revoked, expired, incomplete, malformed or wrong-environment states return no active binding. The
sync guard maps revoked/expired explicitly and otherwise fails closed as `binding-invalid` or
`enrollment-required`.

## Restart Composition

`MarkeiComposition.appPrivate()` remains local-only when no active binding exists. When an active
binding exists after restart, it:

- ensures the hosted Account row exists with insert-ignore behavior;
- ensures the hosted server Device row exists with insert-ignore behavior;
- ensures the hosted sync cursor row exists with insert-ignore behavior;
- selects exactly the stored hosted AccountId and server DeviceId for new purchase registration;
- constructs scoped hosted outbox and applier adapters.

The installation metadata path remains owned by `LocalDeviceIdentityRepository`; hosted activation
does not rewrite the existing local installation metadata row.

Successful enrollment persists the binding but returns `hosted-restart-required`. The native closure
runner reports that state directly. When the current process was composed without an active binding,
its hosted sync guard is a blocked guard and cannot use the newly stored binding until restart.

## Outbox Scope

`DriftSyncOutboxRepository.scoped()` filters pending-event leasing by AccountId and DeviceId through
the `sync_events` row joined to `pending_events`. Unknown submission replay filters
`sync_submissions` by the same AccountId and DeviceId and reorders member events by submission
position. `persistUploadResult()` is a no-op when a scoped caller tries to complete a submission
outside its Account/Device binding.

The original unscoped constructor remains for isolated local lab compatibility.

## Applier, Cursor and Acknowledgement Scope

`DriftRemoteEventApplier.scoped()` validates every downloaded event against the bound AccountId
inside the existing transaction before applying facts. Cross-Account pages return conflict before
fact, inbox or cursor mutation. Cursor lookup and update are scoped to the bound Account; therefore
acknowledgement uses that Account's cursor and does not select an arbitrary first cursor from a
multi-Account database.

The original unscoped applier remains for existing local lab compatibility.

## Transaction Boundaries

Hosted outbox leasing and result persistence remain transactional. Remote page validation, fact
application, inbox insertion and cursor update remain one transaction. Cross-scope rejection exits
before mutation.

## Compatibility Choices

Existing tests that use `HostedSyncDecision.allowed(String deviceId)` remain source-compatible.
Binding-aware hosted code uses `HostedSyncDecision.allowedBinding(HostedIdentityBinding)`.
Existing isolated local synchronization tests keep unscoped adapters; production/native hosted
composition uses scoped adapters only after validated restart activation.

## Deviations and Residual Risks

No schema migration was authorized or needed. The local decisive proof uses synthetic UUID fixtures
and a disposable Docker/PostgreSQL lab; it is provider-ready but not provider-validated. Fresh human
Auth0 retest, controlled provider enrollment and two-provider-Device convergence remain pending.
