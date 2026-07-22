# I_DSN_CODEX

Authority marker: C10-MCG02-TRANSPORT-OBSERVABILITY_20260721

Final dependency direction:
- Closure UI -> NativeAuthClosureRunner.
- NativeAuthClosureRunner -> HostedConnectionCheckPort and SyncAttemptRecorder.
- HttpHostedConnectionCheck -> HostedHttpPolicy and package:http client.
- DriftClosureDiagnosticsRepository -> local Sync attempt ledger.
- Fastify buildApp -> optional sanitized LifecycleObserver.
- hosted.ts -> consoleLifecycleObserver for hosted runtime logs.

Ports and adapters:
- Added HostedConnectionCheckPort as an application-owned read/diagnostic port.
- Added HostedConnectionCorrelation so the full correlation value remains transient while its fingerprint is durable.
- Added HostedHttpPolicy for origin validation, path joining, elapsed bands, and correlation sanitization/fingerprinting.
- Added HttpHostedConnectionCheck for live/ready health checks.

Origin/path comparison:
- Health uses the same configured hosted origin validation rule as hosted HTTP paths: HTTPS, nonempty host, no userinfo, no query, no fragment.
- Health paths are joined as /health/live and /health/ready under the configured origin base path.
- Existing Sync and recovery paths remain through HttpSyncTransport; no event identity, sequence, hash, outbox, or transaction semantics were changed.
- Enrollment transport was not rewritten.

Timeout decision:
- Health check uses an explicit 20 second deadline for cold-start-tolerant diagnostics.
- Sync submission timeout behavior was not expanded or reclassified.
- Timeout after transport begins is still unknown-outcome territory for Sync; the two human events were not reclassified.

Schema/migration:
- Drift schema version is now 10.
- v9-to-v10 migration adds SyncAttempts.operationKind, latestStage, correlationFingerprint, elapsedBand, httpStatus, and responseHeadersReceived.
- The migration is additive. For pre-v9 databases, sync_attempts is created directly at the v10 shape and the v10 ledger step is still recorded.
- Historical v9 rows remain preserved with nullable new fields and default responseHeadersReceived=false.

Correlation/fingerprinting:
- Correlation source generates one invocation value.
- The outbound x-correlation-id uses a sanitized, bounded value.
- Client and API derive the same 8-character SHA-256 fingerprint from the sanitized value.
- Control characters and adversarial input are removed or bounded before display/log persistence.

API lifecycle logging:
- Fastify logger remains false.
- Sanitized events: request-received, operation-validation-started, authentication-accepted, authentication-rejected, database-transaction-started for fixture transaction start, response-completed, request-failed.
- Observer failure is caught and cannot alter application responses or transaction semantics.

Deviations and residual ambiguity:
- No provider conclusion is claimed. The next human test will determine whether the same short correlation fingerprint reaches and completes in Render.
- Hosted database-transaction-started is not emitted from inside HostedTransactionAuthorizer because adding deeper transaction callbacks would expand the transport-observability unit. Fixture transaction start is logged where this boundary is directly owned by buildApp.
