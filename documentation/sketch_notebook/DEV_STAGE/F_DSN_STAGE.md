# F_DSN_STAGE — Hosted Identity Binding Design

> Authority marker: C10-MCG02-HOSTED-IDENTITY-BINDING_20260718T155856Z
> Status: **ACTIVE DESIGN AUTHORITY**

## Selected model

~~~text
pre-enrollment composition -> local-only Account/Device
enrollment result           -> durable hosted binding
restart                     -> validate binding
bound composition           -> hosted Account/server Device
hosted sync repositories    -> explicitly scoped to both
~~~

Existing facts and immutable events retain their original identity and hash. Binding affects only
new facts created by the bound composition. This is a fresh hosted lane inside the existing Drift
database, not an Account migration, merge or event translation.

## Repository scoping

Hosted outbox leasing/replay accepts required AccountId and DeviceId and cannot select other rows.
Remote application accepts required AccountId, rejects pages for another Account, reads/writes that
Account's cursor only and acknowledges only its committed cursor. Unscoped constructors may remain
only where existing isolated lab tests require them; production hosted composition must be scoped.

## Composition transition

Enrollment cannot safely replace final composition fields during the running process. It stores the
binding and returns `hosted-restart-required`. On the next start, composition selects the hosted IDs
only when account, device, installation, generation and active state are complete and valid.

## Prohibited alternatives

Do not rewrite local events, recompute them under server IDs, relax server equality checks, derive
server IDs from Auth0 claims, upload mixed-Account batches, reset Drift or silently discard pending
local work. No provider or database schema mutation is authorized.

Rollback removes the binding selection/scoped adapters while retaining the stored enrollment state,
local facts/outbox and accepted native authentication implementation.
