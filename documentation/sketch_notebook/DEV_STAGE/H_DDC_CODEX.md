# H_DDC_CODEX — C10-S01B Didactic Evidence

Sequence: FLX-ORD-01
Role: Codex materialization evidence
Source stages: `J_MAIN_STAGE.md`, `D_OPS_STAGE.md`, `E_DDC_STAGE.md`, `F_DSN_STAGE.md`
Learner maturity: unchanged

## Vocabulary Materialized

Implemented status meanings include `saved-local`, `waiting-upload`, `uploading`, `server-accepted`, `download-received`, `downloaded-applied`, `duplicate-ignored`, `acknowledged`, `conflict`, `auth-required`, `device-revoked`, `cursor-expired`, `protocol-upgrade-required`, and `unknown-outcome`.

Outcome meanings remain `applied`, `duplicate-equivalent`, `not-applied`, and `unknown`. Server acceptance is treated only as server acceptance; peer application is proven separately by B download/apply and reopened fact comparison.

## Named Tests

`local registration works when transport is absent`: local Purchase registration remains usable without API.

`unknown outcome retries same submission`: retry uses the same SubmissionId/request hash after an unknown upload.

`duplicate event is applied once and can be acknowledged`: duplicate remote replay has no second Purchase effect and acknowledgement follows committed cursor.

`two isolated Drift files converge through local replay harness`: local fact application uses complete v3 payloads, not inbox-only replay.

`CONVERGED=true for HTTP/PostgreSQL backed local synchronization`: real loopback HTTP, Fastify child processes and disposable PostgreSQL prove the vertical slice.

TypeScript tests retain normal-runtime fixture refusal and direct-test-only fixture auth construction.

## Diagnostic Evidence

Minimal diagnostic output is limited to test names and the harness line `CONVERGED=true` when all assertions pass. No UI status page, dashboard, pairing screen, Device-management page, navigation change, native sharing, Analytics change, or Cycle 11 visual/accessibility work was added.

## Privacy And Logging

No Purchase/Product/Store/Person/Payment payload logging was added. The HTTP transport does not log authorization headers, tokens, credential-bearing URLs or payloads. Lab credentials are generated during tests into ignored paths or in-memory environment variables. Secret scan found no committed credential literals.

## Unchanged Surfaces

Home, Lists, Purchase, History, Catalogue and Settings were not redesigned or polished. Learner maturity was not changed. Synchronization is not described as backup, export, restore, provider recovery or indefinite history.
