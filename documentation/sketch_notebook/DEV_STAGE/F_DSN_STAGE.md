# F_DSN_STAGE — MCG-02 Decisive Provider Design Boundary

> Authority marker: C10-MCG02-DECISIVE-PROVIDER_20260718T152829Z
> Status: **ACTIVE EXECUTION BOUNDARY; DESIGN FROZEN**

## Executed topology

~~~text
Android + Windows Flutter clients
  -> Auth0 Native Authorization Code + PKCE
  -> ephemeral exact-audience access token
  -> Render HTTPS Fastify API
  -> pooled Neon markei_runtime
  -> explicit identity/membership/Device authorization
  -> Account-scoped immutable event synchronization
~~~

Controlled synthetic mapping uses the direct migrator boundary; migrator credentials never enter
Render or Flutter. Auth0 subject remains an external identity and never becomes AccountId/DeviceId.

## Frozen invariants

- tokens are process-memory-only and absent from Drift/logs/surfaces;
- every protected request verifies JWT, identity, membership, Account and Device;
- two installations receive distinct durable Device identities;
- enrollment replay is idempotent;
- upload/download/apply/ack preserve R05 transaction and retry rules;
- acknowledgement occurs only after committed local application;
- provider failure cannot erase local facts or pending work;
- runtime remains pooled/least-privilege and migrator remains direct;
- no automatic provisioning or production credential path is introduced.

## Evidence boundary

The proof must use native clients and the real development providers. Loopback fakes cannot replace
this gate. Sanitized row counts, status classes, convergence comparisons and log scans are retained;
private provider configuration is not.

## No-change boundary

No source, migration, dependency, provider architecture, permanent memory or product UX change is
authorized. Any discovered code defect stops the proof and returns to Main for a new bounded stage.

## After acceptance

Main may authorize proof-module pruning and A/B/C permanent-memory promotion, then reconcile Cycle
10 closure. MCG-03 must be defined from the resulting permanent state; its current scope remains
unselected.
