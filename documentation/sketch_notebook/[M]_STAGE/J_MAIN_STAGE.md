# J_MAIN_STAGE — Cycle 10 R04C01 Vertical-Slice Coordination

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-R04C01_20260717T143908Z
> Staged at UTC: 2026-07-17T14:39:08Z
> Staged at America/Sao_Paulo: 2026-07-17T11:39:08-03:00
> Reconciled implementation: fab9357224cd6e4fb532f02e0c1e33f161a4e615
> Prior authority: 22467716ae9ba0fb93ee775781c7177db88320fc
> Status: **R04B PARTIAL ACCEPTED; R04C01 SELECTED**
> Active unit: **R04C01 — Reusable Authorization Proof Vertical Slice**

## 1. Reconciliation

R04B proved Docker/PostgreSQL availability and added an inert barrier interface, phase names, several
reach points and containment tests. Git later published that partial work as fab9357.

R04B did not add:

- an active lab barrier controller;
- participant-aware reach/release coordination;
- an Account state observer;
- case-addressable authorization scenarios;
- producer completion or R04 aggregation.

Source inspection also found:

- enrollment reaches before-protected-mutation after earlier durable writes;
- before-commit is a generic database callback without operation/participant context.

Therefore:

~~~text
C10-MCG02-R04B_PARTIAL
AUTHORIZATION_RACE_PRODUCER=false
R3_LOCAL_SECURITY_PROVED=false
~~~

## 2. Strategy correction

The previous unit was too broad. R04 is now decomposed into independently successful slices:

~~~text
R04C01  proof infrastructure + one membership-denial slice
R04C02  identity, membership and actor-Device route matrix
R04C03  target Device and enrollment concurrency
R04C04  response loss, restart, retry exhaustion and final R04 aggregate
R05      complete Flutter HTTP/file-backed proof and global local aggregate
MCG-02   human/provider Auth0 + Neon + Render proof
Promotion and Main Cycle 10 closure
~~~

Only R04C01 is active.

## 3. R04C01 objective

Build reusable proof infrastructure and prove one complete scenario:

~~~text
working deterministic barrier controller
+ corrected transaction phase placement
+ canonical Account state observer
+ membership-disabled-before-fence upload denial
~~~

The authorization producer remains false after this unit. That is expected and does not make
R04C01 partial.

## 4. Reusable infrastructure

R04C01 selects:

- a participant-aware lab barrier controller;
- context-aware transaction lifecycle signaling;
- canonical payload-free Account snapshots;
- a reusable arrange/snapshot/pause/intervene/release/compare scenario runner;
- deterministic cleanup and safe ScenarioResult output.

Later R04 and recovery/synchronization assays should add scenarios to these mechanisms rather than
rebuild them.

## 5. Phase corrections

Required meanings:

| Phase | Placement |
| --- | --- |
| before-identity-membership-fence | inside transaction, before current identity/membership resolution |
| after-membership-lock | only after relevant identity/membership rows are actually locked |
| before-actor-device-lock | immediately before actor Device FOR UPDATE |
| before-target-transition | after authorization/locks, immediately before transition |
| before-protected-mutation | immediately before the first durable write |
| before-commit | after writes and before COMMIT, with operation/participant context |

R04C01 must correct enrollment placement and remove or replace context-free before-commit behavior.

## 6. Representative scenario

Use membership-disabled-before-fence on a valid upload:

1. seed an active identity, membership and Device;
2. prepare a valid purchase submission;
3. capture Account state;
4. pause upload before membership resolution;
5. disable membership from a control transaction;
6. commit the control transition;
7. release upload;
8. require typed 403 authorization denial;
9. capture Account state again;
10. prove protected synchronization state did not advance.

The membership status transition itself is expected. Facts, submissions, events, cursors,
acknowledgements, recovery state, Devices and security-event state must otherwise remain unchanged.

## 7. R04C01 terminal

Success:

~~~text
R04C01_BARRIER_CONTROLLER=true
R04C01_ACCOUNT_OBSERVER=true
R04C01_MEMBERSHIP_DENIAL_SLICE=true
AUTHORIZATION_RACE_PRODUCER=false
R04_REMAINING_CASES_PENDING
C10-MCG02-R04C01_PROVED
~~~

Do not mark denied-no-state-advance globally true. It remains pending until the wider matrix covers
all required state families.

## 8. Validation boundary

R04C01 validates:

- Docker/PostgreSQL preflight;
- barrier controller lifecycle and timeout tests;
- phase-placement tests;
- Account snapshot canonicalization;
- real Fastify/PostgreSQL representative scenario;
- complete server format/lint/typecheck/tests/build;
- diff, secret and teardown checks.

Full Flutter builds, all proof producers and global aggregation return in R04C04/R05 unless a shared
contract changed.

## 9. Scope boundary

R04C01 excludes:

- the other 27 authorization cases;
- provider access or credentials;
- migrations, dependencies, lockfiles and Drift changes;
- Flutter R05 work;
- UI, MCG-03, MCG-04, deployment and permanent promotion.

Production correction requires a retained failing vertical-slice test and must remain narrow.

## 10. Forward coordination

After R04C01 reconciliation:

- R04C02 reuses the controller/observer for identity, membership and actor Device cases;
- R04C03 reuses them for target and enrollment concurrency;
- R04C04 adds response-loss/restart/retry evidence and runs the full authorization aggregate;
- R05 proves the complete Flutter transport/file-backed boundary;
- human MCG-02 proves provider configuration;
- functional domains promote accepted evidence;
- Main closes Cycle 10 only after all named gates reconcile.

No later unit is automatically authorized by R04C01 completion.

---

## 11. Append-only reconciliation — R04C01 result

> Reconciliation marker: C10-MCG02-R04C02_20260717T151546Z
> Reconciled at UTC: 2026-07-17T15:15:46Z
> Reconciled at America/Sao_Paulo: 2026-07-17T12:15:46-03:00
> Reconciled implementation: 40e0a7097fef7f8a7abfe172cc867b670dfec196
> Implementation tree: 0740d1038f3b3e3b783dc8d9f1cebeff83571bc4
> Controlling R04C01 J: 2d85523952a3606ec80a3769817cb4ad8e647cb9
> Controlling R04C01 D/E/F: 2f7272a8cacaa790ccfaad6c0c7523eede336460
> Current status: **R04C01 VALIDATED; R04C02 SELECTED**

R04C01 is accepted as validated local evidence within its declared boundary.

Evidence reconciled:

- the remote implementation is a direct child of the controlling D/E/F commit;
- the participant-aware controller, Account observer and reusable scenario runner exist;
- enrollment protected-mutation and target-transition placement were corrected;
- the real upload scenario records a typed 403 after a committed membership disable;
- protected Account synchronization state remains unchanged except for the expected membership
  transition;
- Codex recorded 8 focused tests and 45 total server tests passing;
- Main independently reran format, lint, typecheck, all 45 server tests, build and production audit;
- `git diff --check` passed and the commit changed only the authorized server/proof/report paths.

Main could not independently rerun Docker because Docker is unavailable in the reconciliation
environment. The committed scenario and the recorded Windows/Docker PostgreSQL 18.4 run remain the
environment-scoped evidence for the real database case.

R04C01 terminal accepted:

~~~text
R04C01_BARRIER_CONTROLLER=true
R04C01_ACCOUNT_OBSERVER=true
R04C01_MEMBERSHIP_DENIAL_SLICE=true
AUTHORIZATION_RACE_PRODUCER=false
R04_REMAINING_CASES_PENDING
C10-MCG02-R04C01_PROVED
~~~

## 12. Evidence corrections retained

G/H/I contain two report-header defects:

1. their controlling D/E/F SHA repeats the J SHA; the correct D/E/F SHA is `2f7272a8...`;
2. their implementation tree and final commit fields remained `pending`; Git resolves them to tree
   `0740d103...` and commit `40e0a70...`.

These are observational metadata corrections. They do not invalidate the executed tests or source
evidence. Codex must resolve commit/tree fields accurately in the next G/H/I reports.

## 13. Phase-scheme revision

The earlier forward scheme is preserved above as history. Current coordination merges the former
R04C02 and R04C03 because R04C01 proved their shared controller, observer, fixture and scenario
foundation. R04C04 remains separate because transport loss, process restart and deterministic retry
exhaustion require materially different mechanisms.

Current scheme:

~~~text
R04C01  reusable proof infrastructure + membership-disabled slice       VALIDATED
R04C02  core authorization matrix: identity/member/actor/target/enroll  ACTIVE
R04C04  response loss + restart + retry exhaustion + final R04 aggregate PENDING
R05      Flutter HTTP/file-backed proof + global local aggregate          PENDING
MCG-02   human Auth0 + Neon + Render proof                                PENDING
Promotion and Main Cycle 10 closure                                       PENDING
~~~

R04C02 uses three internal checkpoints:

~~~text
CP-A  identity, membership and actor-Device race cases
CP-B  target authorization, revoke concurrency and later actor denial
CP-C  equivalent/conflicting enrollment concurrency
~~~

The unit may be one commit, but each checkpoint must produce case-addressable results before the
next begins. A failed checkpoint remains diagnosable and cannot be converted into inherited truth.

## 14. R04C02 acceptance boundary

R04C02 must execute cases 2–24 of the existing authorization producer while retaining the validated
case 1. It may then report 24 true cases and exactly four pending cases:

- response-loss-query-replay;
- process-restart-replay;
- serialization-retry-exhaustion-fails-closed;
- denied-no-state-advance.

`AUTHORIZATION_RACE_PRODUCER` remains false until R04C04. R04C02 success is therefore a bounded
matrix checkpoint, not local-security or provider completion.

## 15. Forward authority

D/E/F carrying marker `C10-MCG02-R04C02_20260717T151546Z` are the only active Codex authority.
R04C04, R05, provider mutation, permanent promotion and Cycle 10 closure remain unauthorized.

---

## 16. Append-only reconciliation — R04C02 result

> Reconciliation marker: C10-MCG02-R04C04_20260717T154951Z
> Reconciled at UTC: 2026-07-17T15:49:51Z
> Reconciled at America/Sao_Paulo: 2026-07-17T12:49:51-03:00
> Reconciled implementation: 4f8c1567521ffb7deb93541a3af7f4a713986058
> Implementation tree: a56f28f2e807ff5e4385aa2aeaa7cd67117c3521
> Controlling R04C02 authority: f1fe19135ba47c652cd2575d7256a74f871f78bb
> Current status: **R04C02 VALIDATED; R04C04 SELECTED**

R04C02 is accepted as validated local evidence within its declared boundary.

Evidence reconciled:

- the implementation is a direct child of the controlling staging commit;
- all 24 core cases are produced from structured scenario results;
- actor-denial cases use real protected routes and valid route-specific fixtures;
- target authorization, one-transition/one-event revoke truth and enrollment convergence are
  represented by committed scenario code;
- one retained failing Device-management scenario justified a narrow barrier-placement correction;
- Codex recorded CP-A/B/C passing, 46 server tests, build, audit and clean teardown;
- Main independently reran format, lint, typecheck, 46/46 tests, build and production audit;
- `git diff --check` passed and only authorized server/proof/report paths changed.

Main could not rerun Docker in the reconciliation environment. The committed scenarios and recorded
Windows/Docker/PostgreSQL 18.4 execution remain the environment-scoped database evidence.

Accepted terminal:

~~~text
R04C02_CP_A=true
R04C02_CP_B=true
R04C02_CP_C=true
AUTHORIZATION_CASES_TRUE=24
AUTHORIZATION_CASES_PENDING=4
AUTHORIZATION_RACE_PRODUCER=false
R04C04_PENDING
C10-MCG02-R04C02_CORE_MATRIX_PROVED
~~~

## 17. Reconciliation qualifications

G/H/I again left implementation tree and commit fields pending. Git resolves them above. Future
reports must distinguish authoring-time pending metadata from Main-resolved final metadata.

`authorization_slice_scenarios.ts` grew to 1,669 lines. This does not invalidate R04C02, but it is a
recovery and maintenance liability. R04C04 must split scenario infrastructure by responsibility
before adding its three mechanisms. The refactor must preserve behavior and pass the existing 24
cases before new case work begins.

## 18. Current phase scheme

~~~text
R04C01  reusable proof infrastructure + first denial slice               VALIDATED
R04C02  identity/member/actor/target/enrollment core matrix (24 cases)    VALIDATED
R04C04  response loss + restart + retry exhaustion + R04 aggregate        ACTIVE
R05      Flutter HTTP/file-backed proof + global local aggregate           PENDING
MCG-02   human Auth0 + Neon + Render proof                                 PENDING
Promotion and Main Cycle 10 closure                                        PENDING
~~~

R04C04 has four ordered checkpoints:

~~~text
CP-0  split oversized scenario module without semantic change
CP-1  response-loss query replay and process-restart replay
CP-2  deterministic serialization retry exhaustion with no state advance
CP-3  derive global denied-no-state-advance and run final R04 aggregation
~~~

## 19. R04C04 acceptance boundary

R04C04 must make the remaining four authorization cases true from executed evidence, then make the
authorization producer true. The R04 orchestrator must accept migration, JWKS, route, static and
authorization producers as true while Flutter remains validly false only for `not-yet-r05`.

Success proves the server-side R04 authorization boundary. It does not prove Flutter transport,
provider configuration, production deployment, full MCG-02 or Cycle 10 closure.

## 20. Forward authority

D/E/F carrying marker `C10-MCG02-R04C04_20260717T154951Z` are the only active Codex authority.
R05, providers, permanent promotion, MCG-03/04 and Cycle 10 closure remain unauthorized.

---

## 21. Append-only reconciliation — R04C04 result

> Reconciliation marker: C10-MCG02-R05_20260717T162323Z
> Reconciled at UTC: 2026-07-17T16:23:23Z
> Reconciled at America/Sao_Paulo: 2026-07-17T13:23:23-03:00
> Reconciled implementation: bddccba29e208ad423d9adfc95b99ed969ade71e
> Implementation tree: f626606216343af641c9fe7b57c9e6bad448c960
> Controlling R04C04 authority: 8311829e0317a559f740f4ff1772c004561b21b5
> Current status: **R04 VALIDATED; R05 SELECTED**

R04C04 completed the behavioral proof:

- response-loss query replay recovered one committed enrollment result;
- process-restart replay recovered the same PostgreSQL truth in a new composition;
- retry exhaustion recorded three bounded attempts and zero durable protected advance;
- denied-no-state-advance was derived from a closed executed denial set;
- all 28 authorization cases and the authorization producer passed;
- the R04 orchestrator reported proof-pipeline integrity true with Flutter false only for R05.

Codex recorded Docker/PostgreSQL 18.4 execution, clean teardown, all server checks and producer runs.
Main independently reran format, lint, typecheck, 46/46 server tests, build and audit. Docker was not
available in Main's environment, so real producer/orchestrator execution remains Codex's recorded
environment-scoped evidence.

Accepted behavioral terminal:

~~~text
R04C04_RESPONSE_LOSS_REPLAY=true
R04C04_PROCESS_RESTART_REPLAY=true
R04C04_RETRY_EXHAUSTION=true
R04C04_DENIED_NO_STATE_ADVANCE=true
AUTHORIZATION_CASES_TRUE=28
AUTHORIZATION_RACE_PRODUCER=true
PROOF_PIPELINE_INTEGRITY=true
C10-MCG02-R04_AUTHORIZATION_PROVED
~~~

## 22. Structural observation and disposition

`authorization_slice_scenarios.ts` grew to 1,936 lines. Length alone is not drift or a failed gate:
the module still compiles, passes its tests and produces the required closed evidence. Main therefore
does not insert a mandatory mid-phase solely to reduce line count.

The scenario-module split is recorded as Cycle 10 pruning work. It should occur after the decisive
R05 proof, when the complete proof topology can be reorganized without repeatedly moving an active
boundary. This disposition supersedes the unmaterialized CP-0 preference without weakening R04's
behavioral result.

## 23. Current phase scheme

~~~text
R04      server authorization behavior and aggregate                    VALIDATED
R05      Flutter HTTP/file-backed proof + global local aggregate         ACTIVE
MCG-02   human Auth0 + Neon + Render proof                               PENDING
Pruning, promotion and Main Cycle 10 closure                             PENDING
~~~

## 24. R05 acceptance boundary

R05 must make all 16 `flutter-http-file-backed` cases true through real Flutter transport,
file-backed Drift and loopback hosted API evidence. It must preserve local facts/outbox across every
failure and unknown outcome, prove one absolute request deadline and client ownership, and prove
that bearer tokens are ephemeral and absent from durable state/log output.

After the Flutter producer passes, the global aggregator must accept all six producers and report
`R3_LOCAL_SECURITY_PROVED=true`. Provider acceptance remains a separate human MCG-02 gate.

## 25. Forward authority

D/E/F carrying marker `C10-MCG02-R05_20260717T162323Z` are the only active Codex authority.
Providers, deployment, pruning/promotion, MCG-03/04 and Cycle 10 closure remain unauthorized.

---

## 26. Append-only reconciliation — R05 result

> Reconciliation marker: C10-MCG02-PROVIDER-GATE_20260717T170634Z
> Reconciled at UTC: 2026-07-17T17:06:34Z
> Reconciled at America/Sao_Paulo: 2026-07-17T14:06:34-03:00
> Reconciled implementation: 2785b29ccabbd390c1560ab687bea76f8014c0ae
> Implementation tree: 2315aed9488efdc2ffdcf50cd377b2fa94ce6af3
> Controlling R05 authority: a24000be31582b6b704ee825919ebff3e84bbd2f
> Current status: **R05 VALIDATED; MCG-02 PROVIDER PROOF NEXT**

R05 completed the local Flutter and global proof boundary:

- all 16 `flutter-http-file-backed` cases passed from closed case records;
- real Flutter HTTP transport and file-backed Drift preserved facts and pending outbox state;
- response-loss replay, process-safe query replay, absolute deadline and client ownership passed;
- bearer-token material was absent from the inspected Drift bytes and retained diagnostic state;
- the Flutter producer and all five earlier producers passed the strict global aggregator;
- the final orchestrator reported proof-pipeline integrity and local R3 security true;
- Flutter analysis/tests, Android debug, Windows release and server validation passed in Codex's
  recorded environment; Docker/PostgreSQL resources were torn down.

Main inspected the final Git tree, reports and strict producer/orchestrator implementation. The
commit changes only proof infrastructure, one Flutter proof test and G/H/I; it does not mutate
production provider configuration, migrations, dependencies, UI or permanent memory. `git diff
--check` passed. Main's attempted independent npm reinstall was inconclusive because the execution
environment could not create its npm cache and returned corrupted-download warnings; this is an
environment limitation, not contrary behavioral evidence.

Accepted local terminal:

~~~text
FLUTTER_HTTP_FILE_BACKED_CASES_TRUE=16
FLUTTER_HTTP_FILE_BACKED_PRODUCER=true
AUTHORIZATION_RACE_PRODUCER=true
PROOF_PIPELINE_INTEGRITY=true
R3_LOCAL_SECURITY_PROVED=true
C10-MCG02-R05_FLUTTER_PROVED
~~~

## 27. Phase decision

The next phase is not MCG-03. Permanent memory still defines MCG-03 and MCG-04 as undefined and
inactive. R05 proves local readiness only; it does not prove Auth0, Neon, Render or deployment.

The remaining ordered work is:

~~~text
R05 local Flutter/global proof                                      VALIDATED
MCG-02 human Auth0 + Neon + Render provider proof                   NEXT
Cycle 10 proof-module pruning and permanent domain promotion        PENDING
Main Cycle 10 closure                                               PENDING
MCG-03 / MCG-04 definition                                          INACTIVE
~~~

MCG-02 provider proof must use sanitized evidence and the existing manual instructions. It must
validate the configured issuer/audience/JWKS boundary, direct migrator versus pooled runtime Neon
roles, forward migrations, Render HTTPS composition, explicit Account membership and Device
enrollment, denial cases and one synthetic hosted synchronization path. Secrets, provider IDs,
tokens, hostnames and connection strings must remain outside Git and reports.

## 28. Forward authority

R05 D/E/F are spent implementation authority. No replacement D/E/F or Codex implementation seed is
issued at this gate because provider-console actions and sanitized human evidence are required
first. Main must reconcile that evidence before authorizing pruning, permanent promotion, Cycle 10
closure or defining MCG-03/04.

---

## 29. Provider-proof staging activation

> Authority marker: C10-MCG02-PROVIDER-PROOF_20260717T171443Z
> Activated at UTC: 2026-07-17T17:14:43Z
> Activated at America/Sao_Paulo: 2026-07-17T14:14:43-03:00
> Parent reconciliation: 2158c03f22b5181f1cccaf74d3aafa0450bf39ec

At the human operator's request, D/E/F now carry a bounded MCG-02 provider-proof contract. This does
not reopen Codex source implementation. It authorizes human configuration and sanitized evidence
capture across the disposable Auth0, Neon and Render development resources, with Codex limited to
read-only preparation, redacted diagnosis and later evidence reconciliation.

Repository inspection found bearer-token transport ports but no Flutter Auth0 SDK/login composition
or production credential supplier. The active unit is therefore narrowed to provider containment,
Auth0 contract, Neon migrations/privileges and Render HTTPS foundation readiness. Main will
reconcile that evidence before staging native client authentication and the decisive hosted proof.
Manual token copying cannot stand in for native login evidence.

D/E/F carrying marker `C10-MCG02-PROVIDER-PROOF_20260717T171443Z` are current authority. MCG-03/04,
production launch, pruning/promotion and Cycle 10 closure remain inactive.

---

## 30. Append-only reconciliation — provider foundation result

> Reconciliation marker: C10-MCG02-NATIVE-CLOSURE_20260718T140335Z
> Reconciled at UTC: 2026-07-18T14:03:35Z
> Reconciled at America/Sao_Paulo: 2026-07-18T11:03:35-03:00
> Provider authority commit: ade6e2c1f19ae3ebf318457d7ef76ac8dbe3bcae
> Current status: **PROVIDER FOUNDATION VALIDATED; NATIVE CLOSURE SELECTED**

Main accepts the sanitized human evidence for the disposable provider foundation:

- all exposed owner, migrator and runtime credentials were rotated and old access contained;
- Neon migrations 002–006 have the expected ledger identifiers and checksum tags;
- direct `markei_migrator` and pooled `markei_runtime` remain separate;
- runtime readiness returned true while DDL, ledger access, role administration, controlled-table
  mutation and Account visibility without context failed closed;
- Render built and deployed exact commit `ade6e2c`, emitted `MARKEI_HOSTED_SYNC_READY`, returned 200
  from live/ready and 401 from an unauthenticated protected route;
- Render logs disclosed no connection string, password, bearer token or fact payload;
- Auth0 discovery and JWKS returned 200, issuer/JWKS URI matched, RS256 was advertised and two keys
  were present;
- the Android and Windows applications remain Native applications with Authorization Code enabled,
  Client Credentials disabled and no native client secret.

Accepted foundation terminal:

~~~text
MCG-02_PROVIDER_CONTAINMENT=true
MCG-02_AUTH0_TOKEN_CONTRACT=true
MCG-02_NEON_MIGRATIONS_AND_PRIVILEGES=true
MCG-02_RENDER_HTTPS_RUNTIME=true
MCG-02_PROVIDER_FOUNDATION_READY
~~~

This evidence closes provider configuration only. No Android or Windows client has yet obtained an
Auth0 access token through the Markei Flutter composition, and no two-Device hosted convergence has
been executed. `MCG-02_NATIVE_CLIENT_AUTH_INTEGRATION` and full MCG-02 remain false.

## 31. Repository reconciliation

The repository already has application ports and tested HTTP adapters for authentication state,
ephemeral bearer-token supply, identity lookup and Device enrollment. It does not have an Auth0
Flutter dependency, production Auth0 adapter, typed native configuration or Android/Windows login
composition. Existing lab authentication must remain confined to tests and loopback proof code.

The next unit therefore changes only the native authentication edge and its proof harness. It does
not reopen PostgreSQL migrations 001–006, server authorization, provider resources, retention,
snapshots or synchronization semantics.

## 32. Current phase scheme

~~~text
R05 local Flutter/global proof                                      VALIDATED
MCG-02 provider containment/Auth0/Neon/Render foundation            VALIDATED
MCG-02 native Auth0 composition and closure harness                 ACTIVE
MCG-02 human two-client hosted acceptance                           PENDING
Cycle 10 pruning and permanent promotion                            PENDING
Main Cycle 10 closure                                               PENDING
MCG-03 / MCG-04 definition                                          INACTIVE
~~~

## 33. Native closure acceptance boundary

Codex must implement one fail-closed Auth0 composition for Android and Windows behind the existing
application ports. Non-secret provider configuration must be injected, validated and absent from
committed defaults. Access tokens must be requested for the exact Markei API audience, remain
ephemeral, never enter Drift/logs, and be cleared on logout, rejection and expiry.

The unit must provide deterministic tests and a bounded development-only closure surface or runner
that allows the human operator to perform native login, identity resolution, Device enrollment and
hosted synchronization without copying tokens. It must not seed membership, operate provider
consoles or claim real provider acceptance from fakes.

After Codex reports local composition readiness, the human proof must execute Android and Windows
native login, explicit identity/membership mapping, two distinct Device enrollments, one synthetic
Account convergence and the required denial matrix through Render HTTPS and Neon. Main must
reconcile that sanitized evidence before MCG-02 or Cycle 10 can close.

## 34. Forward authority

D/E/F carrying marker `C10-MCG02-NATIVE-CLOSURE_20260718T140335Z` are the only active Codex
authority. Provider mutation, database migration, automatic user provisioning, permanent promotion,
Cycle 10 closure and MCG-03/04 remain unauthorized.

---

## 35. Append-only reconciliation — native composition result

> Reconciliation marker: C10-MCG02-NATIVE-CLOSURE-R1_20260718T145121Z
> Reconciled at UTC: 2026-07-18T14:51:21Z
> Reconciled at America/Sao_Paulo: 2026-07-18T11:51:21-03:00
> Reconciled implementation: 214df17b
> Controlling authority: 6fffad609bb83523d467a849e2d91f3c668af721
> Current status: **NATIVE AUTH COMPOSITION ACCEPTED; CLOSURE HARNESS CORRECTION REQUIRED**

Main accepts the following implementation evidence:

- Auth0 Flutter 2.4.0 is pinned behind infrastructure adapters;
- typed compile-time configuration fails closed without committed provider values;
- Authorization Code + PKCE requests the exact configured API audience;
- access tokens remain process-memory bounded and clear on logout, expiry or rejection;
- ID-token substitution is rejected and lab authentication is not selected by production
  composition;
- Android callback composition and debug build passed;
- 10 focused tests and the complete 72-test Flutter suite passed with two existing skips;
- analysis, formatting, dependency lock and secret checks passed;
- migrations, server authorization, Drift schema and provider resources were unchanged.

Main could not independently rerun Flutter because the reconciliation environment has no Flutter
toolchain. This is an environment exclusion, not contrary evidence.

## 36. Material gaps

The implementation does not yet satisfy the closure harness required by section 33:

1. `NativeAuthClosureRunner` is composed and tested but has no development-only app entry point;
   a human cannot initiate the required sequence from Android or Windows.
2. `hostedSyncProbe()` calls Device-enrollment replay and returns `hosted-sync-available` when a
   server Device exists. It does not upload/download events, apply them, acknowledge them or compare
   Account facts; its name and success state therefore overclaim the executed behavior.
3. Windows runner code exists, but no Windows release binary was built because Developer Mode and
   symlink support were unavailable on the Codex host.
4. G/H/I still say final commit status pending; later reports must record the actual final SHA.

These are bounded closure deficiencies, not a rejection of the Auth0 adapter. MCG-02 remains open,
and MCG-03 remains inactive.

## 37. Revised phase scheme

~~~text
R05 local Flutter/global proof                                      VALIDATED
MCG-02 provider foundation                                          VALIDATED
MCG-02 native Auth0 adapter and Android composition                  VALIDATED
MCG-02 executable native closure surface + real sync path           ACTIVE
MCG-02 human Android/Windows/two-Device hosted acceptance            PENDING
Cycle 10 promotion/closure                                          PENDING
MCG-03 / MCG-04 definition                                          INACTIVE
~~~

## 38. Forward authority

D/E/F carrying marker `C10-MCG02-NATIVE-CLOSURE-R1_20260718T145121Z` are the only active Codex
authority. The unit must correct the observable closure path without changing the accepted Auth0,
server, database or synchronization contracts. Real provider operation remains human-controlled.

---

## 39. Append-only reconciliation — executable closure result

> Reconciliation marker: C10-MCG02-DECISIVE-PROVIDER_20260718T152829Z
> Reconciled at UTC: 2026-07-18T15:28:29Z
> Reconciled at America/Sao_Paulo: 2026-07-18T12:28:29-03:00
> Reconciled implementation: df904fb
> Controlling authority: e59d919ecb776597b13615137cd23413dae42c36
> Current status: **LOCAL NATIVE CLOSURE VALIDATED; HUMAN PROVIDER ACCEPTANCE NEXT**

Main accepts the R1 correction:

- the development closure page defaults absent and requires an explicit compile-time flag plus
  valid native configuration;
- Device enrollment and synchronization now have distinct truthful states;
- `hostedSyncProbe()` invokes the existing upload/download/apply/ack services;
- loopback HTTP and file-backed Drift executed upload, download, atomic application,
  acknowledgement and reopen persistence;
- stable installation and enrollment request identity survive retry and Drift reopen;
- format, analysis, dependency lock, 79 Flutter tests with two existing skips, Android debug build,
  diff check and secret scan passed;
- migrations, server authorization, Drift schema, dependencies and provider resources were
  unchanged.

The reconciliation host has no Flutter toolchain, so Main did not independently rerun Flutter.
Windows release remains host-excluded because Developer Mode/symlink support was unavailable.

Accepted local terminal:

~~~text
MCG-02_NATIVE_CLOSURE_SURFACE=true
MCG-02_REAL_HOSTED_SYNC_PATH=true
MCG-02_STABLE_DEVICE_EXECUTION=true
MCG-02_TOKEN_EPHEMERAL=true
MCG-02_NATIVE_PROVIDER_PROOF_READY
~~~

## 40. MCG-03 decision

MCG-03 is not yet available. R1 proves an executable local closure path, not a real Auth0/Render/
Neon client run. MCG-02 still requires Android and Windows native login, two distinct enrolled
Devices, one synthetic Account convergence, selected fail-closed denials, local continuity during
provider unavailability and sanitized evidence. Manual token copying is not accepted.

No further source refactor is selected before this evidence. The next unit is human-operated
provider acceptance under D/E/F. Codex may provide read-only redacted diagnosis but must not receive
or operate credentials, tokens or provider resources.

## 41. Phase projection

~~~text
MCG-02 provider foundation                                          VALIDATED
MCG-02 native authentication and executable local closure           VALIDATED
MCG-02 decisive Android/Windows hosted provider acceptance          ACTIVE
Cycle 10 proof pruning and permanent promotion                      PENDING
Main Cycle 10 closure                                                PENDING
MCG-03 definition/investigation                                     INACTIVE
~~~

After decisive provider evidence passes, Main should close MCG-02, run bounded proof-file pruning,
request A/B/C permanent-memory promotion, reconcile Cycle 10, and only then define MCG-03 from
current permanent memory rather than assuming its scope.

## 42. Forward authority

D/E/F carrying marker `C10-MCG02-DECISIVE-PROVIDER_20260718T152829Z` are the active human evidence
contract. They authorize no Codex source mutation and no production deployment.

---

## 43. Provider-proof preflight contradiction

> Reconciliation marker: C10-MCG02-HOSTED-IDENTITY-BINDING_20260718T155856Z
> Reconciled at UTC: 2026-07-18T15:58:56Z
> Reconciled at America/Sao_Paulo: 2026-07-18T12:58:56-03:00
> Inspected implementation: df904fb
> Current status: **PROVIDER PROOF BLOCKED; HOSTED IDENTITY BINDING CORRECTION ACTIVE**

Main's preflight found that the production composition still registers purchases under local-only
Account/Device aliases while enrollment returns PostgreSQL Account and server Device UUIDs. The
server correctly rejects uploaded events whose embedded AccountId or DeviceId differs from the
authorized hosted context. The existing loopback proof manually aligned fixture identifiers and
therefore did not expose this production mismatch.

The unscoped local outbox may also lease older local-only pending events during hosted sync, and the
remote applier chooses an arbitrary non-null Account cursor. Human provider proof would therefore be
predictably unsafe or fail closed even though native login/enrollment could pass.

## 44. Selected correction

After enrollment, a restart may select the stored hosted AccountId and server DeviceId as the active
composition identity for new hosted facts. Existing local-only facts/events remain immutable under
their original local Account and are never rewritten or uploaded. Hosted outbox, cursor, inbox and
applier operations must be explicitly scoped to the active hosted Account/Device.

The first process that completes enrollment must report `hosted-restart-required`; it must not sync
with the pre-enrollment local composition. After restart and verified binding, new synthetic hosted
purchases may synchronize. This is a development-proof binding, not general Account migration or
automatic merge.

## 45. Revised projection

~~~text
MCG-02 local native closure                                          VALIDATED
MCG-02 hosted Account/Device binding and scoped sync                 ACTIVE
MCG-02 decisive human provider proof                                BLOCKED BY ACTIVE UNIT
Cycle 10 closure / MCG-03                                            INACTIVE
~~~

D/E/F carrying marker `C10-MCG02-HOSTED-IDENTITY-BINDING_20260718T155856Z` supersede the human
provider contract until Codex returns corrected G/H/I evidence.

---

## 46. Append-only reconciliation — Windows provider callback evidence

> Reconciliation marker: C10-MCG02-WINDOWS-AUTH-CALLBACK_20260719T011836Z
> Reconciled at UTC: 2026-07-19T01:18:36Z
> Reconciled at America/Sao_Paulo: 2026-07-18T22:18:36-03:00
> Inspected implementation: df904fb plus staged hosted-binding authority at 65ae6a7
> Current status: **AUTH0 LOGIN VALIDATED; NATIVE CREDENTIAL ACCEPTANCE CORRECTION ACTIVE**

Human provider evidence established more than the earlier host exclusion:

- Windows Developer Mode and the release-build toolchain are available;
- the configured release executable built successfully with Auth0 Flutter 2.4.0;
- cpprestsdk, OpenSSL, Boost and Zlib were resolved through a pinned local vcpkg registry;
- the development closure surface became available only with explicit compile-time configuration;
- the `auth0flutter` callback allowlist and current-user protocol registration were exercised;
- the Auth0 Windows application is Native, uses Authorization Code plus PKCE, has no Client
  Credentials grant and has user-delegated access to the Markei API;
- signup, email verification and user login are recorded as successful in sanitized Auth0 logs.

The client nevertheless returns `authentication-rejected` after the successful provider login.
Device enrollment and hosted synchronization were therefore not executed. This contradicts native
credential acceptance, not provider identity verification or the Windows release build.

## 47. Selected narrow correction

Codex must first make the post-login boundary diagnosable and correct:

~~~text
successful Auth0 login
-> consent/authorization result
-> auth0flutter callback activation
-> secondary-instance forwarding
-> waiting SDK transaction
-> authorization-code exchange
-> credential validation
-> authenticated
~~~

The correction must preserve bounded, non-secret failure categories; align the Windows runner with
the pinned SDK's callback contract; prove that the waiting transaction consumes the callback; and
reject malformed, duplicate, stale or cross-transaction callbacks without exposing tokens, codes,
PKCE material, state, nonce, identity or complete URLs.

The hosted Account/Device binding selected in sections 43–45 remains accepted as the next source
unit, but it is temporarily blocked: enrollment cannot begin until native credentials reach the
truthful `authenticated` state. No provider mutation, enrollment or synchronization is authorized
inside this correction.

## 48. Revised phase projection and authority

~~~text
MCG-02 provider foundation and Auth0 user login                     VALIDATED
MCG-02 Windows release build and protocol dispatch                  VALIDATED
MCG-02 native callback consumption / credential acceptance          ACTIVE
MCG-02 hosted Account/Device binding and scoped sync                 BLOCKED NEXT
MCG-02 decisive two-Device provider convergence                      PENDING
Cycle 10 closure / MCG-03                                            INACTIVE
~~~

D/E/F carrying marker `C10-MCG02-WINDOWS-AUTH-CALLBACK_20260719T011836Z` are the only active Codex
authority. They supersede the hosted-binding D/E/F for execution order without rejecting that
design. Success reopens the hosted-binding unit; it does not close MCG-02.

---

## 49. Append-only reconciliation — authenticated Windows provider proof

> Reconciliation marker: C10-MCG02-WINDOWS-RUNTIME-PACKAGING_20260719T155742Z
> Reconciled at UTC: 2026-07-19T15:57:42Z
> Reconciled at America/Sao_Paulo: 2026-07-19T12:57:42-03:00
> Inspected implementation: 1922ffc38b9a7b24cf49143e9fae726f9f8349db
> Current status: **AUTHENTICATION VALIDATED; REPRODUCIBLE RUNTIME PACKAGING ACTIVE**

Sanitized human evidence after `1922ffc` confirms Windows release build, closure-surface launch,
Auth0 signup/login, protocol callback consumption, authorization-code exchange, credential
acceptance, stable authenticated status, logout and re-sign-in. No token, callback, identity or
provider secret is retained in staging.

The decisive diagnostic was runtime deployment. Direct/session-assisted launch could find vcpkg
libraries through a temporary PATH, while the browser-launched callback process reported missing
`cpprest_2_10.dll`. Copying the vcpkg release runtime DLLs beside `markei.exe` made authentication,
logout and re-sign-in pass. The source authentication correction is therefore accepted; the manual
copy is not an acceptable distributable result.

## 50. Selected closure step 1

Codex must make Windows Debug and Release outputs carry their configuration-correct runtime closure
after `flutter clean`, without PATH mutation, manual copies, committed binaries or machine-specific
paths. Clean direct and callback-process launch are distinct gates. Real Auth0 login remains a
subsequent human retest after the packaging correction is published.

~~~text
Windows callback and credential correction                         VALIDATED
Windows runtime packaging closure step 1                            ACTIVE
Clean human provider authentication retest                          BLOCKED NEXT
Hosted Account/Device binding and scoped synchronization            DEFERRED
Decisive two-Device convergence / MCG-02 closure                     PENDING
MCG-03                                                               INACTIVE
~~~

D/E/F carrying marker `C10-MCG02-WINDOWS-RUNTIME-PACKAGING_20260719T155742Z` are the only active
Codex authority. Success authorizes a clean human authentication retest; it does not authorize
Enroll, Sync, provider mutation, MCG-02 closure or MCG-03.

---

## 51. Fresh-chat continuity handoff

> Continuity marker: C10-MCG02-04-CLOSURE-HANDOFF_20260720T120703Z
> Recorded at UTC: 2026-07-20T12:07:03Z
> Recorded at America/Sao_Paulo: 2026-07-20T09:07:03-03:00
> Current remote evidence tip: 734c559087a62ac2530a94326c3449005ce87d03
> Status: **READ-ONLY CONTINUITY; CURRENT HUMAN GATE UNCHANGED**

This section supports a fresh Main chat and does not promote evidence or replace D/E/F. After the
canonical methodology boot, the new chat must read J through this section, then current D/E/F and
G/H/I together. It must retain the following exact execution order:

~~~text
1. clean Windows provider authentication retest without PATH/manual DLL copying
2. Main reconciliation of that sanitized human evidence
3. restage hosted Account/Device binding and Account/Device-scoped synchronization
4. Codex implementation and local decisive proof
5. controlled provider membership and two distinct Device enrollments
6. Windows + Android hosted synchronization/convergence and negative authorization proof
7. MCG-02 reconciliation, permanent-domain promotion and closure
8. Main definition/staging of MCG-03
9. MCG-03 evidence/reconciliation before MCG-04 activation
10. MCG-04 evidence/reconciliation and Cycle 10 closure
~~~

The current executable authority remains D/E/F marker
`C10-MCG02-WINDOWS-RUNTIME-PACKAGING_20260719T155742Z`. Codex reports at `734c559` support
`MCG-02_WINDOWS_RUNTIME_PACKAGING_CORRECTED` and require a clean human provider retest. Until that
retest is recorded, **Enroll**, **Query**, **Sync**, provider membership mutation, hosted-binding
implementation, MCG-03 and MCG-04 remain unauthorized.

The fresh chat must not infer the content of MCG-03 or MCG-04 from their labels. Their objectives,
provider boundaries, data effects, tests and terminal conditions require new Main reconciliation
after MCG-02 closes. Any provider-dependent action must be presented as a gated human procedure;
credentials, tokens, complete callback URLs, identity subjects and database connection strings stay
outside Git, chat and staging.

---

## 52. Append-only reconciliation — hosted binding execution resumed

> Reconciliation marker: C10-MCG02-HOSTED-BINDING-R2_20260720T131954Z
> Reconciled at UTC: 2026-07-20T13:19:54Z
> Reconciled at America/Sao_Paulo: 2026-07-20T10:19:54-03:00
> Authority baseline: 4382c09c038e41c1dc269141d40c31c258516b61
> Packaging evidence: 734c559087a62ac2530a94326c3449005ce87d03
> Current status: **LOCAL HOSTED-BINDING CORRECTION ACTIVE; PROVIDER RETEST PENDING**

The clean remote history and current source confirm the unresolved mismatch from sections 43–45:
application composition boots with `local-account` and a local Device, enrollment stores different
hosted Account/server Device identifiers, and hosted sync constructs unscoped outbox/applier
adapters. Provider synchronization must not proceed in that state.

Codex's packaging evidence at `734c559` is accepted for automated purposes. A fresh human Auth0
retest from that exact clean artifact is not available as reconciled evidence and remains
provenance-unresolved. Main now reorders two independent gates: the provider retest remains pending,
while the local-only binding/scoping correction may proceed because it needs no credentials,
provider access or remote mutation.

## 53. Selected implementation unit

The restarted composition must validate the durable hosted binding and select its hosted AccountId
and server DeviceId for new hosted facts. The enrolling process reports `hosted-restart-required`
and cannot sync. Hosted outbox, unknown replay, inbox, cursor, fact application and acknowledgement
must be explicitly scoped. Existing local-only facts/events remain immutable, pending and excluded.

The decisive proof uses file-backed Drift, real loopback HTTP/server authorization and two isolated
Devices. It must demonstrate restart activation, exact envelope identities, preserved local-only
work, cross-Account atomic rejection, scoped acknowledgement, close/reopen persistence and
two-Device convergence. It may not weaken server checks or substitute direct event injection.

## 54. Revised phase projection and authority

~~~text
MCG-02 Windows runtime packaging automated proof                    VALIDATED
MCG-02 clean human Auth0 retest                                     PENDING / UNRECONCILED
MCG-02 hosted Account/Device binding and scoped sync                ACTIVE LOCAL UNIT
MCG-02 controlled provider enrollment and two-Device convergence    BLOCKED NEXT
MCG-02 permanent promotion and closure                             PENDING
MCG-03 / MCG-04                                                     INACTIVE
~~~

D/E/F carrying marker `C10-MCG02-HOSTED-BINDING-R2_20260720T131954Z` are synchronized and are the
only active Codex authority. They authorize source changes and local decisive tests only. They do
not authorize Auth0 login, Enroll/Query/Sync against Render/Neon, provider mutation, migration,
production deployment, permanent-memory promotion, MCG-02 closure, MCG-03 or MCG-04.
