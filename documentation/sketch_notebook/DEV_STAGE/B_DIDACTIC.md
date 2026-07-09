# Functional Stage — Didactic

## 1. Scope
This stage captures Cycle 02 didactic requirements for the History UI page and Settings page. The learning focus is how Markei turns purchase/time/store facts into grouped History read models, how Settings persists user preferences that affect grouping rules, and how these concepts extend Cycle 01 lessons on raw vs derived data, read models, repository result shape, service-owned responsibility, and UI rendering.

## 2. Accepted Facts
- Cycle 02 feature scope: History UI page plus Settings page.
- History must show purchases in sequential order.
- History must group/trench purchases by month and week.
- Default month boundary is the first Wednesday of the month.
- Default week boundary is every Wednesday.
- History must include Total rows showing cumulative product values for a given store under a given timeframe.
- Repository retrieves purchase, time, and store data.
- Service groups purchases into History periods.
- UI renders grouped History sections and Total rows.
- Settings persists configuration and editing preferences.
- Time reference configuration affects History grouping/bucketing rules.
- Store editing area continues Cycle 01 deferred store-address persistence/display work.

## 3. Requirements for Main Synthesis
- Keep grouping/bucketing responsibility in service logic, not UI rendering code.
- Treat History output as a read model, extending Cycle 01 Product View read-model learning.
- Teach grouping separately from sorting: ordering decides sequence; grouping decides membership in buckets.
- Treat Total rows as derived aggregate data, not raw purchase facts.
- Treat Settings configuration as durable application state that changes later History interpretation.
- Connect Settings-owned preferences to History behavior without making Settings calculate History results.
- Preserve repository result-shape learning: repository should expose purchase/time/store facts clearly enough for services to group them.
- Preserve nullable-field learning for optional store address or missing configuration defaults.
- Introduce date/datetime boundary logic as a language-level and domain-level learning topic.

## 4. Existing Concepts Reused
- `&&&02 Raw Data Versus Derived Data`: purchases are raw records; grouped sections and Total rows are derived views.
- `&&&03 Naming as Data Contract`: names must distinguish purchase date, bucket start/end, week boundary, month boundary, timeframe total, store total, and sorting preference.
- `&&&04 Cached Summary Field`: useful contrast; History totals should be taught as derived display aggregates unless Main/Design explicitly chooses caching.
- `&&%01 Optional Values and Nullable Fields`: store address/config defaults may be absent and need safe placeholders/default behavior.
- `&&%02 Dataclass Field Evolution`: History/Settings may introduce new structured return shapes or configuration models.
- `&%%02 Product View Read Model`: evolves into a broader History read-model concept.
- `&%%03 Repository Result Shape`: repository must return explicit purchase/time/store fields for grouping and totals.
- `&%%04 Service-Owned Calculation Responsibility`: service owns grouping, bucketing, and aggregation; UI owns rendering.
- `%%%01 SQLite Schema Evolution`: Settings persistence may require schema changes or config storage.
- `%%%02 SQLite PRAGMA`: remains relevant if migration-safe Settings/store columns are introduced.
- `%%%03 PySide6 Read-Only Widget Composition`: extends into grouped History sections and editable Settings widgets.

## 5. New Concept Candidates
- `&&&05 Time Bucketing`: assigning events into periods using boundary rules such as first Wednesday or weekly Wednesday.
- `&&&06 Aggregation and Totals`: deriving cumulative values from multiple records under a timeframe/store filter.
- `&&&07 Grouping Versus Sorting`: sorting orders records; grouping partitions records into buckets.
- `&&&08 Configuration State`: persisted preferences that alter application behavior across sessions.
- `&&%03 Date/Datetime Boundary Handling`: Python date arithmetic for week/month boundaries, inclusive/exclusive ranges, and deterministic period labels.
- `&%%05 History Read Model`: service-prepared grouped data containing period headers, ordered purchase rows, and Total rows.
- `&%%06 Settings-Owned Preferences`: Settings UI persists user choices, but History service interprets them for grouping rules.
- `&%%07 Store Editing Workflow`: continuation of Cycle 01 store-address persistence/display into editable store data.
- `&%%08 History Grouping Service Responsibility`: Markei-specific rule that History grouping and totals belong to services rather than UI widgets.
- `%%%04 PySide6 Editable Form Composition`: Settings page widgets for store editing, sorting config, and time-reference config.

## 6. Risks / Open Questions
- Risk: grouping and sorting may be collapsed into one vague “ordering” concept.
- Risk: Total rows may be mistaken for raw purchase rows instead of derived aggregates.
- Risk: Settings page may become a place where History calculations are performed instead of only persisted/configured.
- Risk: UI may own time bucketing if grouped sections are built directly inside widgets.
- Risk: first-Wednesday month boundary needs precise inclusive/exclusive range rules.
- Risk: week and month buckets may conflict when both are displayed or filtered.
- Risk: store editing may drift from Cycle 01 store-address persistence/display concepts.
- Open question: whether configuration is stored in SQLite, a settings table, or another persistence mechanism belongs to Design/Operational synthesis.
- Open question: exact table/widget layout for grouped History belongs to Design/Operational synthesis.

## 7. Recommended Materialization Targets
- `documentation/sketch_notebook/didactics/02_KANBAN.md`
- `documentation/sketch_notebook/didactics/07_GLOSSARY.md`
- `documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md`
- `documentation/sketch_notebook/didactics/13_LECTURE_REGISTER.md`
- `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`

## 8. Handoff Summary
- Cycle 02 should extend, not replace, Cycle 01 didactic spine.
- Primary new learning cluster: time bucketing, aggregation, grouping vs sorting, and configuration state.
- History page should be taught as a read-model problem.
- Settings page should be taught as persisted preference state, not calculation ownership.
- Store editing continues Cycle 01 deferred store-address work.
- Total rows are derived aggregates from raw purchase records.
- Service layer owns grouping, bucketing, and aggregation.
- Repository owns clear purchase/time/store result shape.
- UI owns grouped rendering and editable preference forms.
- First recommended lecture: grouping versus sorting, followed by time bucketing and aggregation.
