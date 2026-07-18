# E_DDC_STAGE — MCG-02 Decisive Provider Semantics

> Authority marker: C10-MCG02-DECISIVE-PROVIDER_20260718T152829Z
> Status: **ACTIVE HUMAN EVIDENCE CONTRACT**

## Claim boundary

Local tests and builds establish readiness. Provider acceptance requires real native browser login,
callback return, explicit membership, distinct Device enrollment and hosted fact convergence through
Auth0, Render and Neon.

## Required observable sequence

~~~text
signed-out
-> authenticated
-> device-enrolled
-> sync-completed | sync-no-new-events
-> signed-out-cleared
~~~

Each platform must execute this sequence. Enrollment is not synchronization. Endpoint health is not
authentication. One Device is not cross-device convergence.

## Denial language

Unknown identity, missing membership, unknown/revoked Device and cross-Account mismatch are denied
without protected-state advance. Provider unavailability preserves local registration, facts and
pending outbox. No denial may be inferred from status text alone when database counts can verify no
advance.

## Privacy

Evidence uses synthetic aliases, status classes and counts. It omits tokens, claims, subjects,
emails, provider domains/client IDs, URLs, hostnames, Account/Device UUIDs, credentials and fact
payloads.

## Completion

Only Main may promote sanitized executed evidence to `MCG-02_DECISIVE_PROVIDER_PROOF_COMPLETE`.
That result closes MCG-02 development acceptance, not production readiness. MCG-03 remains inactive
until Cycle 10 promotion/closure sequencing is reconciled.
