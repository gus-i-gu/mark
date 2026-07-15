# E_DDC_STAGE — C10-S03A Semantic Materialization Authority

> Sequence: FLX-INV-02 → Main D/E/F activation
> Unit: hosted authentication, membership and Device authorization semantics
> Authority: controlling semantic/test contract for Codex, jointly with D/F
> Learner maturity: unchanged

## 1. Evidence boundary

C10-S03A may prove a production-shaped authentication and authorization composition only through
synthetic local JWT/JWKS, disposable PostgreSQL and opt-in lab clients. It cannot claim:

- a real Auth0 login succeeded;
- Render or Neon accepted the application;
- Android/Windows callbacks work against the provider;
- hosted development synchronization is complete;
- production readiness, backup, universal delivery or every Device being current.

MCG-01 is accepted only as sanitized provider-preparation evidence. MCG-02 remains pending.
Repository work does not change KANBAN status, learner maturity or lecture history.

## 2. Required identity distinctions

| Term | Exact C10-S03A meaning | Must not imply |
| --- | --- | --- |
| `signed-in` | external authorization flow returned a credential to a client | Markei API accepted it |
| `token-obtained` | client possesses an API access-token candidate | token is valid/current |
| `token-accepted` | API verified signature, issuer, audience and time contract | membership exists |
| `external-identity` | exact verified issuer+subject mapped to opaque Markei identity | Account, Person or Device |
| `membership-confirmed` | identity has exactly one active Markei Account membership | Device is enrolled |
| `account-selection-required` | more than one active membership exists and no selection is accepted | authentication failed |
| `enrollment-required` | membership exists but Installation has no active Device binding | sync is permitted |
| `device-enrolled` | idempotent enrollment committed or replayed one Device result | permanent authorization |
| `device-authorized` | active membership and Device permit the current operation | request committed |
| `request-accepted` | named operation committed or replayed equivalent server result | another Device applied it |
| `facts-synchronized` | named facts completed accepted upload/download/apply boundary | provider backup/all-Device equality |
| `acknowledged` | one Device committed a contiguous cursor acknowledgement | universal convergence |
| `device-revoked` | server authorization is withdrawn for future hosted operations | local facts were erased |
| `device-expired` | retention lease/eligibility ended under policy | explicit revocation occurred |
| `unknown-outcome` | request may have committed but response is absent | creating a new identity is safe |
| `hosted-auth-ready` | complete local S03A harness passed with production composition | MCG-02/provider proof passed |

Existing `saved-local`, `waiting-upload`, `server-accepted`, `downloaded-applied`,
`duplicate-ignored`, `acknowledged`, `cursor-expired`, recovery phases and outcomes remain unchanged.

## 3. Required states

Use typed states equivalent to:

```text
locally-available
authentication-unavailable
authenticating
authentication-cancelled
signed-in
token-obtained
token-accepted
token-invalid
membership-required
membership-disabled
membership-confirmed
account-selection-required
enrollment-required
enrolling
device-enrolled
device-authorized
device-revoked
device-expired
synchronization-permitted
synchronization-denied
service-unavailable
unknown-outcome
hosted-auth-ready
```

Do not use `authenticated` alone where the evidence is only external sign-in or token possession.

## 4. Outcome and safe-action rules

Every operation preserves one outcome:

```text
applied | duplicate-equivalent | not-applied | unknown
```

Required mappings:

| Condition | Outcome | Retry/safe action |
| --- | --- | --- |
| missing/malformed/expired/unverifiable token | `not-applied` | reacquire credential; preserve local queue |
| wrong issuer/audience/algorithm | `not-applied` | stop and correct environment; do not change facts |
| JWKS temporarily unavailable before verification | `not-applied` | retry same operation after bounded delay |
| no membership | `not-applied` | request controlled membership provisioning |
| multiple memberships | `not-applied` | stop with `account-selection-required`; no guessed Account |
| enrollment needed | `not-applied` | use explicit enrollment identity |
| equivalent enrollment replay | `duplicate-equivalent` | reuse returned DeviceId |
| enrollment identity with different hash | `not-applied` | conflict; preserve evidence |
| timeout after possible enrollment commit | `unknown` | query/replay same EnrollmentRequestId |
| active Device authorized | no completion claim yet | execute named operation |
| revoked/expired Device | `not-applied` | preserve local facts; stop hosted mutation |
| equivalent revocation replay | `duplicate-equivalent` | retain revoked state |
| API unavailable before send | `not-applied` | retain local pending work |
| timeout after possible sync commit | `unknown` | replay/query original SubmissionId |
| local S03A terminal checklist passes | `applied` evidence | emit `HOSTED_AUTH_READY=true` only |

Authentication cancellation is non-destructive and creates no membership, Device or sync fact.

## 5. HTTP versus domain meaning

- `401` expresses missing or invalid API authentication.
- `403` expresses authenticated but unauthorized membership/role/Device state.
- `409` expresses identity/hash collision or forbidden state transition.
- `429` expresses bounded attempt policy; do not claim provider throttling.
- `503` expresses dependency/service unavailability and never Device revocation.

HTTP is transport evidence, not sufficient user language. Foreign and absent Account/Device
resources must produce the same privacy-preserving denial shape. No response reveals whether an
unrelated identity, membership, Device, snapshot or recovery session exists.

## 6. Enrollment and revocation semantics

Enrollment:

- requires a verified token and one active membership;
- binds one stable local InstallationId to one server Device under the Account;
- treats InstallationId as identifier, never credential or hardware fingerprint;
- stores and replays one result for the same EnrollmentRequestId/hash;
- never silently replaces an existing active Device;
- preserves local facts and pending work on failure.

Reinstall without the persisted InstallationId is a new installation. It does not inherit old
Device sequence, acknowledgement, inbox, outbox, recovery session or authorization.

Revocation:

- denies future hosted sync/recovery after transaction recheck;
- does not sign the external identity out globally;
- does not delete Account membership unless separately changed;
- does not remotely erase the local Drift database;
- does not authorize replacement/reactivation;
- removes the Device from retention eligibility according to existing policy semantics.

## 7. Local-first and credential behavior

During authentication, JWKS, API or database outage:

- local registration remains available when Drift is healthy;
- facts remain `saved-local` or `waiting-upload`;
- EventId and SubmissionId remain stable;
- no hosted state is fabricated;
- after authorization recovery, retry uses the existing identity;
- session expiry never means local changes were lost;
- logout clears hosted credential state but does not delete local Account facts.

The Flutter authentication SDK is hidden behind application ports. Tests use fakes. Public Auth0
domain, Native ClientId and API audience are configuration, not secrets; access/refresh/ID tokens,
authorization codes and PKCE verifiers are credentials and must never be logged or committed.

## 8. Diagnostics and privacy

Permitted neutral diagnostics:

```text
platform-class
operation
typed-code
outcome
safe-action
HTTP class
token-validation stage without claims
membership/enrollment/Device state
redacted correlation alias
cursor range
counts and timings
HOSTED_AUTH_READY=true|false
```

Forbidden:

- access, refresh or ID token;
- Authorization header, authorization code or PKCE verifier;
- raw issuer subject, email/profile claim or full Device/Account identifier;
- database URL, password, provider credential, private key or JWKS body;
- Product/Purchase/Store/Person/Payment facts or snapshot bytes;
- provider hostname/tenant identifier in committed test output where unnecessary.

Health responses contain only generic liveness/readiness.

## 9. Required semantic tests

Name and prove behavior equivalent to:

- `signed in does not mean token accepted`;
- `token accepted does not mean membership confirmed`;
- `membership confirmed does not mean Device enrolled`;
- `exactly one active membership derives Account authority`;
- `multiple memberships require explicit Account selection`;
- `equivalent enrollment replay returns the same Device`;
- `conflicting enrollment replay creates no Device`;
- `unknown enrollment outcome queries the same identity`;
- `revoked Device differs from expired Device`;
- `revocation does not erase local facts`;
- `foreign and absent Device have the same denial shape`;
- `membership removal blocks an in-flight mutation`;
- `JWKS outage never becomes fixture authentication`;
- `authentication cancellation creates no hosted state`;
- `token expiry preserves pending local events`;
- `API outage preserves local registration and SubmissionId`;
- `hosted auth ready is not provider proof`;
- `server acceptance remains distinct from peer application`;
- `application snapshot remains distinct from provider backup`.

## 10. Neutral lab boundary

The opt-in Flutter hosted-auth lab may expose only enough neutral control to initiate login later,
logout, enroll/query status and run a named sync probe. It must not become a product page or claim
completion before evidence. No cards, banners, navigation redesign, Device list/manager, account
picker, visual severity, accessibility redesign, Analytics or polished retry presentation.

Cycle 11 owns all product-facing authentication, Account selection, enrollment/revocation,
synchronization progress and recovery presentation.

## 11. H report requirements

H must record:

- vocabulary/states actually materialized;
- named semantic tests and results;
- typed HTTP/domain mapping;
- neutral diagnostics and privacy/logging inspection;
- unsupported completion wording intentionally absent;
- local-first behavior preserved;
- no Cycle 11 UI/UX or Analytics;
- KANBAN, learner maturity and lecture history unchanged;
- local proof versus MCG-02 boundary;
- deviations and unresolved semantic decisions.

Required terminal wording is exactly one J state. No report may claim real Auth0, Neon, Render,
Android callback, Windows callback or hosted development acceptance from C10-S03A.
