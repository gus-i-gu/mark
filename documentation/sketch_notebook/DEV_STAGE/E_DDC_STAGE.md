# E_DDC_STAGE — Hosted Identity Binding Semantics

> Authority marker: C10-MCG02-HOSTED-IDENTITY-BINDING_20260718T155856Z
> Status: **ACTIVE SEMANTIC AUTHORITY**

## Distinctions

- **Local-only identity** — existing offline Account/Device aliases; its facts remain local.
- **Hosted binding** — server AccountId and enrolled DeviceId stored after successful enrollment.
- **Bound restart** — a new composition that validates and selects the hosted binding.
- **Migration** — rewriting existing local facts/events; explicitly not implemented.

Enrollment completion must say `hosted-restart-required`, not synchronized or hosted-ready. After
restart, `hosted-binding-active` means new facts use hosted identifiers; it does not claim provider
convergence.

Local-only pending work must remain `local-only-pending`, not failed, uploaded or discarded. A
cross-Account event or cursor mismatch is rejected without local mutation.

Successful Codex wording is limited to hosted identity/scoping readiness. Real Auth0 login and
Render/Neon convergence remain human evidence, and MCG-03 remains inactive.
