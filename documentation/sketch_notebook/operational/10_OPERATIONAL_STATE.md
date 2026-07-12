# 10_OPERATIONAL_STATE.md

> Version: Cycle 07 Sprint 01 checkpoint 0.5
> Status: Active operational checkpoint
> Persistence Class: Checkpoint
> Knowledge Class: Operational
> Branch: `cycle-07-mobile-preparation`
> Canonical source: `operational/12_OPERATIONAL_MODEL.md`
> Active work source: `operational/04_TODO.md`
> Reconciliation source: `[M]_STAGE/J_[M]_STAGE.md`

---

# 1. Current Cycle State

Cycle 06 is accepted and closed for the controlled Windows primary-beta boundary. The previous checkpoint's pending-acceptance language was inherited drift; it does not reopen the cycle.

Cycle 07 mobile preparation is active. Sprint 01 investigation is complete and has produced reconciled Operational, Didactic, and Design evidence without application modification, mobile-framework initialization, tool installation, or access to ordinary desktop user data.

Current status:

```text
Cycle 06: accepted and closed
Cycle 07: active investigation
Sprint 01: complete
primary strategic candidate: native/cross-platform client with explicit contracts and fixtures
bounded challenger: time-boxed Python-native Android experiment
framework selection: none
implementation authorization: none
D/E/F: postponed
backend, authentication, synchronization: deferred
```

# 2. Preserved Operational Evidence

Markei contains reusable behavior but is not presently a portable application.

Likely reusable evidence includes:

- Python domain models and vocabulary;
- validation, calculation, date, quantity, and status rules;
- purchase and inventory workflow meanings;
- SQLite schema semantics and structural defaults as reference;
- deterministic desktop behavior as a fixture source.

Current coupling includes:

- `ProductService` constructing the concrete `Repository`;
- repository construction opening concrete SQLite lifecycle behavior;
- desktop/Windows-shaped user-data and resource paths;
- service projections containing presentation labels and grouping;
- incomplete abstract contracts relative to used repository methods;
- multi-step workflows crossing separately committed mutations.

No mobile runtime, Android/iOS package, sandbox database, lifecycle persistence, semantic-parity suite, accessibility behavior, or distribution route has been demonstrated.

# 3. Reconciled Pathways

## Operational pathway — bounded Python-native Android experiment

A time-boxed Python-native Android experiment remains the cheapest direct test of one narrow question:

> Can existing Python behavior run correctly inside a mobile package with an isolated app-private database?

Its apparent low initial cost comes from direct reuse of Python models, calculations, services, repository behavior, and potentially SQLite schema handling. It could expose packaging or runtime incompatibility before a second implementation is undertaken.

That initial economy is not proof of low total cost. It becomes expensive if the experiment requires broad construction refactoring, custom binary recipes, repeated SDK/NDK/JDK/WSL troubleshooting, framework-specific lifecycle work, weak accessibility or platform integration, separate iOS adaptation, or continued debugging across Python, native packaging, and device layers. A successful Android package would not establish iOS feasibility or long-term maintainability.

Operational classification:

```text
bounded challenger
useful only with a fixed question, time limit, pass gates, and stop conditions
not selected
not authorized
```

## Design pathway — native/cross-platform client with contracts and fixtures

The current strategic preference is a maintained native/cross-platform client that reuses Markei's behavior through explicit, language-neutral contracts and deterministic fixtures rather than assuming direct Python runtime reuse.

Its initial cost is higher: a new language/framework may need to be learned; Android and iOS SDKs and packaging must be configured; business behavior and persistence must be implemented in the client; and semantic-parity tests must be constructed. Android may be developed from Windows-supported tooling, while iOS build, signing, simulator/device, and distribution validation still require a macOS/Xcode boundary.

That initial architecture can reduce later cost when contracts separate business facts from presentation formatting, fixtures prevent silent drift, mobile lifecycle and local persistence have explicit owners, transaction behavior is designed once for the mobile client, and conventional platform tooling makes debugging, accessibility, navigation, packaging, and long-term dependency maintenance more predictable.

Operational classification:

```text
primary strategic candidate
favored by human/Main planning direction
not empirically proven
framework not selected
implementation not authorized
```

# 4. Development-Cost Boundary

Development cost is not only the number of files required to launch the first screen.

It includes:

- initial setup and learning;
- direct source reuse versus behavior reimplementation;
- mobile SDK, emulator/device, packaging, signing, and distribution work;
- debugging across application runtime and native toolchain boundaries;
- separate Android and iOS host requirements;
- contract, fixture, and semantic-parity testing;
- suspend/resume, terminate/relaunch, migration, file-lock, backup, and uninstall behavior;
- dependency upgrades and maintenance across the product's lifetime.

The Python-native pathway is cheaper only if its reuse remains direct and its mobile-specific seams stay narrow. The Design pathway is worth its greater entry cost only if explicit contracts and conventional mobile ownership prevent duplicate ambiguity, reduce cross-platform surprises, and support a maintained product rather than a one-off demonstration.

These are planning assumptions. Later execution evidence must measure them.

# 5. Required Future Evidence

Before any framework selection or D/E/F activation, Main/human direction should define:

1. language-neutral behavior scenarios and deterministic expected results;
2. the mobile-local storage and ordinary-desktop-data isolation invariant;
3. one atomic registration workflow;
4. Android host/toolchain prerequisites for the candidate route;
5. the distinct macOS/Xcode boundary for iOS;
6. clean build, install, cold-launch, write/read, suspend/resume, terminate/relaunch, and persistence gates;
7. semantic-parity gates against shared fixtures;
8. stop conditions for the Python-native challenger;
9. decision criteria for accepting a maintained client architecture.

Approach D remains excluded unless accounts, multi-device state, household collaboration, or synchronization become demonstrated requirements.

# 6. Scope and Recovery

No implementation is authorized. D/E/F remain postponed. Do not initialize a framework, install a toolchain, modify source, open the ordinary desktop database, create a backend, or claim framework acceptance from documentation evidence.

Recovery route:

```text
1. Read this checkpoint.
2. Read 04_TODO.md for active evidence gaps and later gates.
3. Read 11_OPERATIONAL_RECORD.md for Cycle 07 observations and preserved pathway tension.
4. Read J_[M]_STAGE.md for cross-domain reconciliation and authorization status.
5. Read 12_OPERATIONAL_MODEL.md only when stable Operational rules are required.
```
