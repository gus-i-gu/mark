# E_DDC_STAGE — Hosted Binding Semantics

> Authority marker: C10-MCG02-HOSTED-BINDING-R2_20260720T131954Z
> Status: **ACTIVE SEMANTIC AUTHORITY**

## Required distinctions

- `local-only-identity` — offline Account/Device identity whose facts remain local;
- `hosted-binding-recorded` — enrollment returned and durably stored hosted IDs;
- `hosted-restart-required` — binding was stored, but the current composition is still local-only;
- `hosted-binding-active` — a restarted composition validated and selected the hosted IDs;
- `local-only-pending` — old local work preserved outside hosted leasing;
- `hosted-sync-ready` — local binding/scoping proof passed, not provider convergence;
- `binding-invalid` / `binding-revoked` / `binding-expired` — fail-closed states;
- `cross-account-rejected` — foreign data caused no fact, inbox or cursor mutation.

Enrollment is not synchronization. Recording a binding is not activation. Activation affects only
new hosted facts; it is not migration, merge, relabeling or recovery of old local facts.

No phase may call the user synchronized, converged or provider-validated before controlled human
proof. The fresh clean Auth0 retest remains `provider-retest-pending`. MCG-03 remains inactive.
