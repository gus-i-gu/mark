# 02_KANBAN.md

> Domain: Didactic
> Status: Canonical concept register
> Last absorbed evidence: `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
> Current cycle: Cycle 03 — Read-Model Consolidation

---

## &&&01

### Domain Model Field Semantics

#### Description
A domain field is not only a storage slot. It carries a specific project meaning. Two fields may share a technical type while representing different concepts.

#### Formal Definition
Domain model field semantics are the meaning and responsibility assigned to a named model field within a domain, independent of its raw data type.

#### Practical Example
Two day-count fields may both store integers, but one may describe how often something is bought while another describes how long it lasts before expiration.

#### Language Implementation
In Python, field semantics appear through class attributes, dataclass fields, function parameters, dictionary keys, and returned read-model keys.

#### Project Implementation
In Markei, `average_duration_days` means purchase-to-purchase rhythm, while shelf-life fields refer to expiration rhythm. Cycle 03 also uses explicit semantics for `latest_price`, `delta_price`, `frame_average_timelapse_days`, and `expenditure_percentage`.

#### Required Concepts
None.

#### Related Concepts
&&&02, &&&03, &&&12, &%%01, &%%09.

#### Status
Yellow.

#### Source
Cycle 01 Product View evidence; Cycle 02 History/Settings evidence; Cycle 03 Lists and History analytics evidence in `H_DDC_CODEX.md`.

---

## &&&02

### Raw Data Versus Derived Data

#### Description
Programs often handle both facts directly entered or retrieved and values calculated from those facts. Learning the difference prevents accidental overwriting of evidence with predictions.

#### Formal Definition
Raw data is directly entered, observed, imported, or retrieved information. Derived data is produced by applying rules, calculations, aggregation, filtering, grouping, or prediction to other data.

#### Practical Example
A receipt row is raw history. A selected-frame total, expenditure percentage, or status label is derived from raw records.

#### Language Implementation
In Python, raw and derived values may both appear as attributes or dictionary keys, so naming and service boundaries must explain which values are source facts and which values are calculations.

#### Project Implementation
In Markei, product/purchase/store rows are raw inputs. Lists rows, Status labels, latest/delta display fields, History analytics totals, percentages, and cycle comparison labels are derived service read-model values.

#### Required Concepts
&&&01.

#### Related Concepts
&&&04, &&&06, &&&09, &%%09, &%%10.

#### Status
Yellow.

#### Source
Cycle 01 Product View evidence, Cycle 02 History evidence, and Cycle 03 read-model consolidation evidence.

---

## &&&03

### Naming as Data Contract

#### Description
A name is a contract between layers. Precise names preserve meaning as data moves through schema, models, repositories, services, and UI.

#### Formal Definition
Naming as a data contract is the use of stable, precise names to define the expected meaning, shape, and responsibility of data exchanged between program components.

#### Practical Example
`latest_price`, `delta_price`, `frame_average_timelapse_days`, and `expenditure_percentage` should each identify a distinct meaning.

#### Language Implementation
In Python, this contract appears in dataclass fields, row-mapping keys, service return dictionaries, settings keys, and UI display labels.

#### Project Implementation
Markei preserves explicit naming across repository rows, service read models, settings keys, and UI rendering. Cycle 03 extends naming contracts to Lists rows and embedded History analytics rows.

#### Required Concepts
&&&01.

#### Related Concepts
&&&02, &&&12, &%%03, &%%12.

#### Status
Yellow.

#### Source
Cycle 01 naming evidence; Cycle 02 row/settings keys; Cycle 03 service read-model keys.

---

## &&&04

### Cached Summary Field

#### Description
A cached summary field stores a value that summarizes other records. It can make display and workflow easier, but it must not be confused with the source records it summarizes.

#### Formal Definition
A cached summary field is a persisted or retained value calculated from other data and kept as a summary for later access, display, or prediction.

#### Practical Example
A product-level current unit price may summarize recent price history, but History analytics percentages should not automatically become stored columns.

#### Language Implementation
In Python, cached summaries may appear as dataclass attributes or service-return fields and should be recalculated by the responsible workflow layer.

#### Project Implementation
In Cycle 03, Lists uses product summary `current_unit_price` for latest price display, while analytics values remain read-time service derivations. No persisted analytics cache was added.

#### Required Concepts
&&&02.

#### Related Concepts
&&&06, &%%11, %%%08.

#### Status
Yellow.

#### Source
Cycle 01 summary-field evidence; Cycle 02 History aggregate contrast; Cycle 03 no-schema-change analytics evidence.

---

## &&&05

### Time Bucketing

#### Description
Time bucketing assigns dated events into named periods using boundary rules. The boundary rule may differ from ordinary calendar expectations.

#### Formal Definition
Time bucketing is the classification of temporal records into discrete periods according to explicit start/end boundary rules.

#### Practical Example
If Wednesday starts the week, a Tuesday purchase belongs to the previous operational week and a Wednesday purchase begins the next operational week.

#### Language Implementation
In Python, time bucketing usually uses `date` or `datetime` parsing, weekday checks, date arithmetic, and inclusive/exclusive range decisions.

#### Project Implementation
In Markei History, operational weeks and months use service rules. Cycle 03 analytics uses date boundaries as a filtering frame rather than a full time-bucketing display feature.

#### Required Concepts
&&&01, &&&03, &&%03.

#### Related Concepts
&&&07, &&&10, &%%05.

#### Status
Red.

#### Source
Cycle 02 History grouping evidence and Cycle 03 analytics frame evidence.

---

## &&&06

### Aggregation and Totals

#### Description
Aggregation combines multiple records into a summary value. Totals are derived data and must not be confused with the individual records used to calculate them.

#### Formal Definition
Aggregation is the derivation of summary values from a collection of records using operations such as sum, mean, grouping, or counting.

#### Practical Example
A frame total can sum all purchase `total_price` values while average timelapse computes the mean interval between parsed purchases.

#### Language Implementation
In Python, aggregation may use loops, dictionaries keyed by group, accumulators, decimal arithmetic, date differences, and explicit handling for missing or incompatible values.

#### Project Implementation
Cycle 03 analytics calculates selected-frame total spent, product totals, purchase counts, and average purchase timelapse before percentages or comparisons.

#### Required Concepts
&&&02.

#### Related Concepts
&&&04, &&&09, &&&11, &%%09.

#### Status
Yellow.

#### Source
Cycle 02 aggregation evidence and Cycle 03 History analytics evidence.

---

## &&&07

### Grouping Versus Sorting

#### Description
Grouping and sorting are different operations. Sorting decides sequence. Grouping decides membership in categories or buckets.

#### Formal Definition
Sorting orders records according to comparison criteria, while grouping partitions records into collections based on shared keys or computed membership rules.

#### Practical Example
Purchases can be ordered by date to compute intervals; products can be filtered into Lists views without becoming separate stored lists.

#### Language Implementation
In Python, sorting commonly uses `sorted(..., key=...)`; grouping/filtering may use dictionaries, lists, predicate functions, or service-built structures.

#### Project Implementation
Cycle 03 Lists internal views filter shared read-model rows. History analytics orders parsed purchases by date before computing average timelapse.

#### Required Concepts
&&&01, &&&03.

#### Related Concepts
&&&10, &&&13, &&%06, &%%10.

#### Status
Yellow.

#### Source
Cycle 02 grouping-versus-sorting evidence and Cycle 03 Lists evidence.

---

## &&&08

### Configuration State

#### Description
Configuration state stores user or application choices that affect later behavior. It is not the behavior itself; it is input interpreted by the responsible service or workflow.

#### Formal Definition
Configuration state is persisted application preference data used to parameterize future application behavior across sessions.

#### Practical Example
A saved setting saying the week starts on Wednesday changes how future purchases are bucketed, but the setting does not itself perform the grouping.

#### Language Implementation
In Python, configuration state may be represented as dictionaries, dataclasses, service return values, or parsed key/value records.

#### Project Implementation
In Cycle 03, `pages.order` remains deferred/inert and was not turned into active tab ordering.

#### Required Concepts
&&&03.

#### Related Concepts
&%%06, %%%04.

#### Status
Red.

#### Source
Cycle 02 Settings evidence and Cycle 03 deferred `pages.order` evidence.

---

## &&&09

### Percentage as Derived Aggregate

#### Description
A percentage is not a raw price. It is a derived aggregate that compares a part to a whole.

#### Formal Definition
Percentage as derived aggregate is the calculation of a part divided by an aggregate whole, multiplied by 100, within a defined inclusion frame.

#### Practical Example
If one product accounts for 20 out of 100 total spending in a selected frame, its expenditure percentage is 20%.

#### Language Implementation
In Python, this requires totals, division, zero-total handling, numeric formatting, and safe missing-value behavior.

#### Project Implementation
History analytics calculates product expenditure percentage as product total spent inside the selected date/store frame divided by selected-frame total spent.

#### Required Concepts
&&&02, &&&06, &&&10.

#### Related Concepts
&&&11, &%%09.

#### Status
Yellow.

#### Source
Cycle 03 History analytics evidence in `H_DDC_CODEX.md`.

---

## &&&10

### Filtering Frame

#### Description
A filtering frame is the boundary that decides which records are included before calculations happen.

#### Formal Definition
A filtering frame is a selected inclusion constraint applied before aggregation, comparison, or read-model assembly.

#### Practical Example
A date range plus store filter can decide which purchases count toward a History analytics total.

#### Language Implementation
In Python, filtering frames may appear as function parameters, parsed dates, optional IDs, predicates, and diagnostic counts for excluded records.

#### Project Implementation
Cycle 03 History analytics uses date range plus optional store filter. ProductService interprets the frame, excludes rows outside it, and reports unparsed rows separately.

#### Required Concepts
&&&02, &&%03.

#### Related Concepts
&&&09, &&&12, &%%09.

#### Status
Yellow.

#### Source
Cycle 03 History analytics evidence.

---

## &&&11

### Comparative Metric

#### Description
A comparative metric is meaningful because it compares one value against another value.

#### Formal Definition
A comparative metric is a derived value produced by comparing a measured value with a defined baseline or reference value.

#### Practical Example
A product can be labeled faster or slower by subtracting the average purchase rhythm from the product cycle.

#### Language Implementation
In Python, comparative metrics may use subtraction, nullable checks, label mapping, and formatting.

#### Project Implementation
Cycle 03 computes product cycle minus frame average purchase timelapse and displays faster/slower/equal labels.

#### Required Concepts
&&&06, &&&12.

#### Related Concepts
&%%01, &%%09.

#### Status
Yellow.

#### Source
Cycle 03 History analytics evidence.

---

## &&&12

### Baseline Definition

#### Description
A baseline is the reference value that gives a comparison meaning.

#### Formal Definition
A baseline is the defined reference measurement used to interpret a comparative metric.

#### Practical Example
A class average can be the baseline for comparing one student’s score.

#### Language Implementation
In Python, baselines should appear as clearly named variables or read-model fields and must be calculated before comparison labels are created.

#### Project Implementation
Cycle 03 baseline is frame average purchase timelapse: the average interval between all parsed purchases inside the selected date/store frame, ordered by date.

#### Required Concepts
&&&03, &&&06, &&&10.

#### Related Concepts
&&&11, &%%09.

#### Status
Yellow.

#### Source
Cycle 03 Main decisions and Codex analytics evidence.

---

## &&&13

### Status Classification Versus UI Filtering

#### Description
Status classification and UI filtering are related but separate. Classification assigns meaning; filtering chooses which classified rows are displayed.

#### Formal Definition
Status classification is the assignment of semantic state to a record, while UI filtering is the selection of records for display based on view state or predicates.

#### Practical Example
A product may be classified as `shortage`; a UI view may choose to show only `shortage` rows.

#### Language Implementation
In Python, classification may be a service-derived field while filtering may be a view key or predicate applied to read-model rows.

#### Project Implementation
Cycle 03 Lists rows include `in-house`, `shortage`, or `to-buy` status. Lists internal views filter shared rows without owning separate data.

#### Required Concepts
&&&02, &&&07.

#### Related Concepts
&&%06, &%%10.

#### Status
Yellow.

#### Source
Cycle 03 Lists read-model evidence.

---

## &&&14

### Mobile Readiness Without Rewrite

#### Description
Mobile readiness can begin by separating responsibilities before choosing a mobile toolchain. It does not require an immediate rewrite.

#### Formal Definition
Mobile readiness without rewrite is the preparation of platform-portable service contracts, read models, and business meaning while leaving implementation architecture choices deferred.

#### Practical Example
A service can return plain dictionaries/lists that a desktop UI renders now and a future adapter could render later.

#### Language Implementation
In Python, this appears as platform-neutral return shapes, primitive values, labels, and service methods that avoid importing UI widget types.

#### Project Implementation
Cycle 03 Lists and analytics service methods return plain dictionaries/lists; PySide6 renders them. No mobile UI, API/backend rewrite, auth, sync, or mobile database work was added.

#### Required Concepts
&%%12, &&%04.

#### Related Concepts
&%%09, &%%10, %%%06.

#### Status
Red.

#### Source
Cycle 03 mobile-readiness boundary evidence.

---

## &&%01

### Optional Values and Nullable Fields

#### Description
Some valid records do not have every value yet. Optional and nullable fields teach that absence can be meaningful data rather than an error.

#### Formal Definition
An optional value is a language-level value that may be present or absent. A nullable database field is a persistent field that may contain no value.

#### Practical Example
A product may have no previous price, so delta price should render as unavailable instead of failing.

#### Language Implementation
In Python, optional model fields are commonly represented with `Optional[...]` type hints and `None` values.

#### Project Implementation
Cycle 03 uses nullable display behavior for missing previous price, unknown frame average, missing product cycle, and insufficient comparison data.

#### Required Concepts
&&&02.

#### Related Concepts
&&%05, &%%11.

#### Status
Yellow.

#### Source
Cycle 01 nullable field evidence and Cycle 03 nullable derived display evidence.

---

## &&%02

### Dataclass Field Evolution

#### Description
Python dataclasses evolve when the domain model becomes clearer. Adding fields is not only syntax; it changes what the model can express.

#### Formal Definition
Dataclass field evolution is the controlled change of Python dataclass fields, defaults, and optionality as the domain model matures.

#### Practical Example
A product dataclass can gain a field for average shelf life once the program needs to distinguish expiration rhythm from purchase rhythm.

#### Language Implementation
In Python, dataclasses use annotated fields and default values to define object shape and construction behavior.

#### Project Implementation
Cycle 03 did not require new model fields for Lists analytics values; this reinforces that read-model evolution can happen without schema/model-field expansion.

#### Required Concepts
&&&01, &&%01.

#### Related Concepts
&&%04, &%%12.

#### Status
Yellow.

#### Source
Cycle 01 dataclass evolution and Cycle 03 no-model-field analytics evidence.

---

## &&%03

### Date/Datetime Boundary Handling

#### Description
Date and datetime values need explicit boundary rules. Without clear rules, period membership becomes ambiguous.

#### Formal Definition
Date/datetime boundary handling is the use of language-level temporal values and arithmetic to determine period starts, period ends, ordering, and membership.

#### Practical Example
A selected start and end date can define which purchases count in an analytics frame.

#### Language Implementation
In Python, this uses date parsing, `datetime.date`, weekday calculations, comparisons, and careful inclusive/exclusive boundary checks.

#### Project Implementation
Cycle 03 analytics parses date boundaries and excludes rows outside the selected frame. Invalid date text currently behaves like an omitted boundary, which remains a teaching risk.

#### Required Concepts
&&&05, &&&10.

#### Related Concepts
&&&12, &%%09.

#### Status
Red.

#### Source
Cycle 02 time-boundary evidence and Cycle 03 analytics frame evidence.

---

## &&%04

### Platform-Neutral Read-Model Shape

#### Description
A read model can be shaped so its meaning is not tied to a specific UI toolkit.

#### Formal Definition
A platform-neutral read-model shape is an application-facing data structure expressed in plain runtime values rather than framework-specific widget objects.

#### Practical Example
A list of dictionaries with labels and numeric values can be rendered by desktop UI now and by another adapter later.

#### Language Implementation
In Python, this may appear as dictionaries, lists, dataclasses, enums/strings, primitive numbers, and nullable values returned by services.

#### Project Implementation
Cycle 03 ProductService returns Lists and History analytics dictionaries/lists that PySide6 renders but does not own.

#### Required Concepts
&%%02, &%%04.

#### Related Concepts
&&&14, &%%12.

#### Status
Yellow.

#### Source
Cycle 03 service read-model evidence.

---

## &&%05

### Nullable Derived Display Values

#### Description
A calculated display value may legitimately be unavailable.

#### Formal Definition
A nullable derived display value is a derived read-model field whose absence has valid domain meaning and must be displayed safely.

#### Practical Example
A delta price cannot be calculated when no previous comparable price exists.

#### Language Implementation
In Python, this commonly appears as `None` plus separate display labels such as `—`.

#### Project Implementation
Cycle 03 delta price, frame average, product cycle, and comparison values may be unavailable and are represented safely in service/UI output.

#### Required Concepts
&&%01, &&&02.

#### Related Concepts
&%%11, &%%09.

#### Status
Yellow.

#### Source
Cycle 03 nullable display evidence.

---

## &&%06

### UI View State

#### Description
UI view state is the current display selection. It changes what the user sees without owning or changing the underlying data.

#### Formal Definition
UI view state is transient interface state used to select, filter, or render data from an existing application model or read model.

#### Practical Example
A combo box can select `shortage`, causing the page to display only products classified with that status.

#### Language Implementation
In Python/PySide6, this may appear as selected combo-box text, event handlers, page attributes, and refresh calls.

#### Project Implementation
Cycle 03 Lists uses internal view selection over one shared read-model shape.

#### Required Concepts
&&&07, &&&13.

#### Related Concepts
&%%10, %%%07.

#### Status
Yellow.

#### Source
Cycle 03 ListsPage evidence.

---

## &%%01

### Markei Purchase Rhythm Versus Shelf-Life Rhythm

#### Description
Markei teaches two different product rhythms: the rhythm of buying and the rhythm of expiration after purchase.

#### Formal Definition
Purchase rhythm is the purchase-to-purchase interval for a product. Shelf-life rhythm is the purchase-to-expiration interval for a purchased batch or product summary.

#### Practical Example
A user may buy milk every seven days even if the milk usually expires ten days after purchase.

#### Language Implementation
In Python, these rhythms appear as separately named fields and service calculations rather than one generic duration value.

#### Project Implementation
Cycle 03 analytics uses `average_duration_days` as product cycle and does not use shelf-life fields for comparison.

#### Required Concepts
&&&01, &&&02, &&&03.

#### Related Concepts
&&&11, &&&12, &%%09.

#### Status
Yellow.

#### Source
Cycle 01 Product View evidence and Cycle 03 product-cycle analytics evidence.

---

## &%%02

### Product View Read Model

#### Description
A read model is a data shape prepared for display. It gathers the exact information a view needs without making the UI calculate domain meaning.

#### Formal Definition
A read model is an application-facing data structure optimized for reading and presentation rather than direct persistence or domain mutation.

#### Practical Example
A product-detail panel may need product identity, average price, store information, shelf-life fields, and recent purchase rows together.

#### Language Implementation
In Python, read models may be dictionaries, dataclasses, typed objects, or structured return values from service methods.

#### Project Implementation
In Markei, Product View read-model learning now generalizes into Lists and History analytics read models.

#### Required Concepts
&&&02, &&&03, &%%01.

#### Related Concepts
&%%09, &%%10, &%%12.

#### Status
Yellow.

#### Source
Cycle 01 Product View read-model evidence and Cycle 03 read-model consolidation evidence.

---

## &%%03

### Repository Result Shape

#### Description
Repository methods do not merely fetch data. They decide the named shape of data that services receive.

#### Formal Definition
Repository result shape is the structure, field names, and relationship representation returned from persistence queries into application code.

#### Practical Example
Returning `purchase_date`, `total_price`, `unit_price`, and `store_label` is clearer than returning unnamed tuple positions.

#### Language Implementation
In Python, repository result shape can appear as dictionaries, row objects, dataclasses, or tuples mapped into explicit keys.

#### Project Implementation
Cycle 03 preserves repository responsibility for SQL retrieval and row mapping while ProductService owns Lists and analytics meaning.

#### Required Concepts
&&&03.

#### Related Concepts
&%%04, &%%09, &%%10.

#### Status
Yellow.

#### Source
Cycle 01/02 row-mapping evidence and Cycle 03 boundary evidence.

---

## &%%04

### Service-Owned Calculation Responsibility

#### Description
Domain calculations should be owned by services rather than UI widgets. This keeps display code from becoming hidden business logic.

#### Formal Definition
Service-owned calculation responsibility is the principle that application services coordinate calculations, aggregation, prediction, grouping, and repository access before UI rendering.

#### Practical Example
A History page should display analytics rows; it should not calculate percentages or cycle comparison labels itself.

#### Language Implementation
In Python, this appears as service methods that call repositories, calculate derived values, and return prepared data.

#### Project Implementation
Cycle 03 ProductService owns status, latest/delta, frame totals, percentages, average timelapse, and cycle comparison.

#### Required Concepts
&&&02, &&&04, &%%02.

#### Related Concepts
&%%09, &%%10, &%%12.

#### Status
Yellow.

#### Source
Cycle 01/02 responsibility evidence and Cycle 03 service boundary evidence.

---

## &%%05

### History Read Model

#### Description
The History read model is the structured display data prepared for the History UI. It contains grouped period sections, ordered purchase rows, and derived totals.

#### Formal Definition
The History read model is a Markei-specific read structure produced by services for rendering chronological and grouped purchase history without assigning calculation responsibility to the UI.

#### Practical Example
A History read model may contain an operational month, several operational weeks, purchase rows in each week, and store-level Total rows.

#### Language Implementation
In Python, the read model may be represented as nested dictionaries, dataclasses, lists of section objects, or structured service return values.

#### Project Implementation
Cycle 03 keeps grouped History rendering and adds embedded History analytics as a separate service-prepared read model.

#### Required Concepts
&&&02, &&&05, &&&06, &&&07, &%%03, &%%04.

#### Related Concepts
&%%09, %%%06.

#### Status
Yellow.

#### Source
Cycle 02 History UI evidence and Cycle 03 embedded analytics evidence.

---

## &%%06

### Settings-Owned Preferences

#### Description
Settings owns editing and persistence of preferences, but not the business calculations that those preferences affect.

#### Formal Definition
Settings-owned preferences are Markei configuration values exposed and persisted through the Settings page, then interpreted by the relevant service workflows.

#### Practical Example
Settings may persist `history.week_boundary = wednesday`; History services later use that value when assigning purchases to weeks.

#### Language Implementation
In Python, settings preferences may be read as key/value rows, parsed into typed values, validated, and passed into service rules.

#### Project Implementation
Cycle 03 leaves Settings as the store-management surface and does not move store management into Register.

#### Required Concepts
&&&08, &&&03.

#### Related Concepts
&%%05, %%%04.

#### Status
Red.

#### Source
Cycle 02 Settings evidence and Cycle 03 Register/Settings boundary evidence.

---

## &%%07

### Store Editing Workflow

#### Description
Store editing turns persisted/displayed store data into editable application data.

#### Formal Definition
The Store Editing Workflow is the Markei-specific path through which store records are shown, edited, validated, persisted, and reflected in later views.

#### Practical Example
A store address can be edited through Settings and later shown consistently in product or history views.

#### Language Implementation
In Python, the workflow coordinates UI form values, service validation/orchestration, repository updates, and optional field handling.

#### Project Implementation
Cycle 03 did not expand Register into store management; store editing remains a Settings responsibility.

#### Required Concepts
&&%01, &%%03, &%%04.

#### Related Concepts
&%%06, %%%05.

#### Status
Red.

#### Source
Cycle 02 store editing evidence and Cycle 03 responsibility boundary evidence.

---

## &%%08

### History Grouping Service Responsibility

#### Description
History grouping service responsibility is the Markei-specific rule that grouping, bucketing, totals, and setting interpretation belong to service logic rather than UI widgets.

#### Formal Definition
History grouping service responsibility is the assignment of History period construction, operational date boundaries, aggregate rows, and settings interpretation to the service layer.

#### Practical Example
The UI should receive sections already labeled as operational months or weeks rather than computing the first-Wednesday rule while painting rows.

#### Language Implementation
In Python, this appears as service methods that read settings, parse dates, call repository methods, bucket rows, aggregate totals, and return a History read model.

#### Project Implementation
Cycle 03 extends the same principle to History analytics: service owns frame interpretation, totals, percentages, and comparison metrics.

#### Required Concepts
&&&05, &&&06, &&&07, &%%04, &%%05, &%%06.

#### Related Concepts
&%%09.

#### Status
Yellow.

#### Source
Cycle 02 History responsibility evidence and Cycle 03 analytics responsibility evidence.

---

## &%%09

### History Analytics Read Model

#### Description
History analytics read model is the structured analytical display data prepared for embedded History analytics.

#### Formal Definition
The History Analytics Read Model is a Markei-specific service output that separates raw frame membership, aggregate totals, percentages, comparative metrics, diagnostics, and UI labels from PySide6 rendering.

#### Practical Example
The model may return frame counts, total spent, average timelapse, product expenditure percentages, cycle comparison labels, and insufficient-data reasons.

#### Language Implementation
In Python, this appears as dictionaries/lists with primitive values, nullable values, and display labels returned by service methods.

#### Project Implementation
`get_history_analytics_view(...)` returns frame data, parsed/unparsed/excluded counts, total spent, frame average timelapse, product rows, and diagnostics.

#### Required Concepts
&&&06, &&&09, &&&10, &&&11, &&&12, &%%04.

#### Related Concepts
&%%05, %%%06, %%%08.

#### Status
Yellow.

#### Source
Cycle 03 History analytics evidence in `H_DDC_CODEX.md`.

---

## &%%10

### Unified Lists Page With Internal Views

#### Description
A unified page can replace several public pages by exposing internal view states over one shared read model.

#### Formal Definition
The Unified Lists Page With Internal Views is the Cycle 03 Markei inventory surface that renders one standardized Lists read model through selectable internal views.

#### Practical Example
One Lists page can show all products, only shortage products, or shortage plus to-buy products without creating separate persisted lists.

#### Language Implementation
In Python/PySide6, this appears as one page class, one table shape, a view selector, and service calls using a view key.

#### Project Implementation
`ListsPage` calls `ProductService.get_lists_view(view_key)` and supports `all`, `in-house`, `shortage`, `to-buy`, `in-house + shortage`, and `shortage + to-buy`.

#### Required Concepts
&&&07, &&&13, &&%06, &%%04.

#### Related Concepts
&%%11, %%%07.

#### Status
Yellow.

#### Source
Cycle 03 Lists evidence in `H_DDC_CODEX.md` and `G_OPS_CODEX.md`.

---

## &%%11

### Latest Value / Delta Calculation

#### Description
Latest and delta values are read-model display values derived from current and previous comparable data.

#### Formal Definition
Latest value / delta calculation is the construction of a display value for the most recent known measurement and its difference from a previous comparable measurement.

#### Practical Example
A product may show its latest price and whether it increased or decreased since the previous known price.

#### Language Implementation
In Python, this may use service helpers, nullable previous values, arithmetic differences, direction labels, and UI display placeholders.

#### Project Implementation
Cycle 03 Lists exposes latest price from `current_unit_price` and delta through `get_price_variation(product)`, globally per product and not scoped to History frame filters.

#### Required Concepts
&&&02, &&%05, &%%04.

#### Related Concepts
&&&04, %%%08.

#### Status
Yellow.

#### Source
Cycle 03 latest/delta price evidence.

---

## &%%12

### Service Contract Stability

#### Description
A service contract is the stable agreement between UI/adapters and the service layer about method names, parameters, return shapes, and meanings.

#### Formal Definition
Service contract stability is the preservation of clear, reusable service interfaces whose outputs can be consumed without depending on internal SQL or UI framework details.

#### Practical Example
A UI can render a list of product rows returned by a service without knowing how status or delta price was calculated.

#### Language Implementation
In Python, this appears through service methods with predictable arguments and structured return values.

#### Project Implementation
Cycle 03 service methods expose Lists and analytics as platform-neutral dictionaries/lists, supporting desktop UI now and future adapters later.

#### Required Concepts
&%%04, &&%04.

#### Related Concepts
&&&14, &%%09, &%%10.

#### Status
Yellow.

#### Source
Cycle 03 service/read-model boundary evidence.

---

## %%%01

### SQLite Schema Evolution

#### Description
A database schema can change without deleting existing data. This concept teaches controlled persistence evolution.

#### Formal Definition
SQLite schema evolution is the controlled modification of SQLite tables and columns over time while preserving existing database contents whenever possible.

#### Practical Example
A migration can add a table or column only if the structure is missing.

#### Language Implementation
Python can execute SQLite DDL statements and metadata checks through database connection/cursor operations.

#### Project Implementation
Cycle 03 introduced no schema changes, reinforcing that read-model values do not automatically require persistence changes.

#### Required Concepts
&&&02, &&%01.

#### Related Concepts
%%%02, %%%08.

#### Status
Yellow.

#### Source
Cycle 01/02 schema evidence and Cycle 03 no-schema-change evidence.

---

## %%%02

### SQLite PRAGMA

#### Description
PRAGMA is a SQLite-specific command family used for database metadata and settings. It is useful for inspecting schema state before migration actions.

#### Formal Definition
SQLite PRAGMA commands are special SQLite statements that query or modify database-level metadata, configuration, and introspection information.

#### Practical Example
`PRAGMA table_info(products)` returns column metadata so code can check whether a column already exists before migration.

#### Language Implementation
In Python, PRAGMA statements are executed through SQLite cursor calls like other SQL statements, then read from returned rows.

#### Project Implementation
Cycle 03 did not require PRAGMA-backed migration because no schema changes were introduced.

#### Required Concepts
%%%01.

#### Related Concepts
%%%08.

#### Status
Yellow.

#### Source
Cycle 01/02 PRAGMA evidence and Cycle 03 no-schema-change contrast.

---

## %%%03

### PySide6 Read-Only Widget Composition

#### Description
A read-only UI panel is built by composing widgets that display prepared data without owning calculation rules.

#### Formal Definition
PySide6 widget composition is the construction of Qt interfaces by combining widgets, layouts, and signals into a user-facing component.

#### Practical Example
A table can display service-returned rows without calculating what those rows mean.

#### Language Implementation
In Python, PySide6 uses widget classes, layout objects, signals, and slots to compose UI behavior.

#### Project Implementation
Cycle 03 Lists and embedded History analytics render service-prepared data without direct SQL or business calculations.

#### Required Concepts
&%%02, &%%04.

#### Related Concepts
%%%06, %%%07.

#### Status
Yellow.

#### Source
Cycle 01/02 UI evidence and Cycle 03 PySide6 composition evidence.

---

## %%%04

### SQLite Settings Persistence

#### Description
SQLite settings persistence stores small durable configuration values in the local database so user preferences can affect future sessions.

#### Formal Definition
SQLite settings persistence is the use of SQLite tables and repository/service access patterns to store and retrieve application configuration state.

#### Practical Example
A settings table can store a row whose key is `history.week_boundary` and whose value is `wednesday`.

#### Language Implementation
In Python, settings persistence uses SQL reads/writes, migration checks, value parsing, default insertion, and service-level validation.

#### Project Implementation
Cycle 03 left `pages.order` deferred and did not consume it for tab ordering.

#### Required Concepts
&&&08, %%%01, %%%02.

#### Related Concepts
&%%06.

#### Status
Red.

#### Source
Cycle 02 Settings persistence evidence and Cycle 03 deferred page-order evidence.

---

## %%%05

### PySide6 Editable Form Composition

#### Description
Editable forms compose input widgets that let the user change persisted application state while still delegating validation and persistence to services.

#### Formal Definition
PySide6 editable form composition is the construction of Qt input forms using widgets, layouts, signals, and event handlers that collect user edits and send them to application services.

#### Practical Example
A Settings page can show controls for store editing, page sorting, and History time-reference configuration.

#### Language Implementation
In Python, this appears through PySide6 input widgets, signal handlers, form population methods, and service calls on save/apply actions.

#### Project Implementation
Cycle 03 did not expand editable forms; Register remained purchase-entry-only and Settings retained store-management responsibility.

#### Required Concepts
&%%06, &%%07, &%%04.

#### Related Concepts
%%%03, &&%01.

#### Status
Red.

#### Source
Cycle 02 PySide6 editable forms evidence and Cycle 03 boundary evidence.

---

## %%%06

### PySide6 Composition for Embedded Analytics

#### Description
Embedded analytics uses UI composition to add analytical display controls inside an existing page without introducing a separate lifecycle.

#### Formal Definition
PySide6 composition for embedded analytics is the construction of controls and read-only display widgets inside an existing Qt page to render service-prepared analytics.

#### Practical Example
A History page can contain date inputs, a store selector, an Apply button, a summary label, and a product analytics table.

#### Language Implementation
In Python/PySide6, this appears through widgets, layouts, event handlers, table population, and service calls from UI events.

#### Project Implementation
Cycle 03 embeds analytics controls/table in `HistoryPage`; detachable analytics remains deferred.

#### Required Concepts
%%%03, &%%09.

#### Related Concepts
%%%07.

#### Status
Yellow.

#### Source
Cycle 03 embedded History analytics UI evidence.

---

## %%%07

### PySide6 Unified Page View Controls

#### Description
A unified page can use controls to switch internal views while rendering one shared table or display surface.

#### Formal Definition
PySide6 unified page view controls are Qt controls and event handlers that select internal read-model views inside a single page.

#### Practical Example
A combo box can switch a Lists page between all products, shortage products, and to-buy products.

#### Language Implementation
In Python/PySide6, this appears through page state, combo boxes, signals, service calls, and table refresh logic.

#### Project Implementation
Cycle 03 `ListsPage` exposes internal views and renders one standardized 10-column table.

#### Required Concepts
&&%06, &%%10, %%%03.

#### Related Concepts
%%%06.

#### Status
Yellow.

#### Source
Cycle 03 ListsPage evidence.

---

## %%%08

### SQLite Read Queries Versus Cached Columns

#### Description
Not every displayed calculation needs to become a database column.

#### Formal Definition
SQLite read queries versus cached columns is the distinction between deriving values at read time through repository/service workflows and persisting calculated values as stored database fields.

#### Practical Example
A percentage can be calculated when the report is opened instead of being stored permanently.

#### Language Implementation
In Python with SQLite, this may appear as SQL reads plus service calculations rather than DDL migrations or new columns.

#### Project Implementation
Cycle 03 did not add columns for latest price, delta price, percentage, frame average, or cycle comparison. Analytics values are read-time service derivations.

#### Required Concepts
&&&02, &&&04, %%%01.

#### Related Concepts
&%%09, &%%11.

#### Status
Yellow.

#### Source
Cycle 03 no-schema-change analytics evidence.

---

## Lecture-only / Glossary-only Decision

### Simple Key/Value Table

Decision: glossary concept and lecture example, not a standalone canonical KANBAN concept in Cycle 02.

Reason: the pattern is important for understanding Settings persistence, but it remains a sub-pattern of `%%%04 SQLite Settings Persistence` rather than a broad project-level learning object requiring its own KANBAN entry.

### Deferred Cycle 03 Terms

Decision: detachable analytics, store/frame-scoped price delta, configurable comparison tolerance, active `pages.order`, mobile implementation architecture, API/backend rewrite, persisted analytics cache, and old page deletion remain staged/deferred rather than canonical concepts.

Reason: Cycle 03 evidence explicitly deferred these items. They should be referenced as risks or future design vocabulary, not promoted as learned concepts.
