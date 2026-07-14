# LEGACY_RECONCILIATION

> Status: Provisional archived Main staging
> Authority: Human-supervised Main Chat
> Scope: Cycle 08 acquired-documentation review preserved for later reconsideration
> Source: `[M]_STAGE/J_[M]_STAGE.md`
> Archived: 2026-07-12
> Canonical: No
> Expiry condition: Main/human reconciliation decides whether this material is promoted, absorbed, superseded, or deleted.

---

# J_[M]_STAGE

> Cycle: 08
> Status: Active Main methodology-revision staging
> Branch: `cycle-08-shared-client-product-beta`
> Authority: Human-supervised Main Chat
> Scope: Domain documentation review; no application implementation authority

---

# Cycle 08 Methodology Review — Didactic Domain

## 1. Review purpose

Review the Didactic permanent-memory folder before Cycle 08 product work and stage a bounded documentation-improvement proposal without modifying Didactic permanent files.

Inspected:

- `didactics/02_KANBAN.md`;
- `didactics/07_GLOSSARY.md`;
- `didactics/08_CONCEPT_MAP.md`;
- `didactics/13_LECTURE_REGISTER.md`;
- current methodology contracts governing canonical, derived, checkpoint, and observational knowledge.

## 2. Current semantic assignment

| File | Assigned role | Current condition |
| --- | --- | --- |
| `02_KANBAN.md` | Canonical concept identity and evidence-based maturity | Concept structure is strong; historical implementation reconciliation has accumulated after the canonical register |
| `07_GLOSSARY.md` | Derived learner-facing terminology | Definitions are useful; release/project evidence retrieval sections make it partly checkpoint-like |
| `08_CONCEPT_MAP.md` | Compact Didactic checkpoint | Correct role, but the latest segment is tied to Cycle 07 Sprint 05 and must be refreshed for Cycle 08 |
| `13_LECTURE_REGISTER.md` | Append-oriented observational learning history | Correctly carries chronological evidence; remains the proper home for cycle-specific learning observations |

## 3. Accepted strengths

1. The four-file Domain Symmetry mapping remains valid.
2. KANBAN IDs provide stable concept identity and should not be renumbered during pruning.
3. The marker families `&&&`, `&&%`, `&%%`, and `%%%` remain useful.
4. The distinction between project evidence and learner mastery is explicit and should remain canonical.
5. No maturity transition is inferred from implementation, tests, host execution, or file existence.
6. The concept map already functions as the cheapest Didactic recovery surface.
7. The Lecture Register preserves evidence chronology without pretending that events define current truth.
8. Cycle 07 introduced a useful cross-language learning spine spanning Python, Dart, Flutter, local persistence, identity, synchronization preparation, and analytics.

## 4. Detected drift

### DDT-01 — Canonical/history mixing in `02_KANBAN.md`

The canonical register contains stable concepts followed by Cycle 07 Sprint 03–05 implementation reconciliations. These appended sections are valuable evidence, but their primary semantic role is observational. Their continued growth would make the KANBAN a combined concept canon and implementation history.

Classification: semantic-role drift and recovery-cost drift.

Provisional resolution:

- keep stable concept definitions, IDs, dependencies, statuses, and concise evidence references in KANBAN;
- keep maturity-changing evidence with the affected concept;
- route detailed cycle execution narratives to `13_LECTURE_REGISTER.md`;
- expose only the latest maturity/evidence boundary through `08_CONCEPT_MAP.md`;
- do not renumber or silently change statuses.

### DDT-02 — Glossary/checkpoint overlap in `07_GLOSSARY.md`

The Glossary contains concise derived definitions, but `Sprint 05 Current-Evidence Retrieval` describes current implementation and validation boundaries. That section behaves more like checkpoint material.

Classification: derived/checkpoint overlap.

Provisional resolution:

- retain concise learner-facing terms and references to KANBAN IDs;
- remove or condense cycle-specific evidence summaries after their information is safely represented in the checkpoint and Lecture Register;
- ensure definitions do not make future synchronization or platform behavior sound implemented.

### DDT-03 — Stale checkpoint

`08_CONCEPT_MAP.md` correctly declares Cycle 07 Sprint 05 evidence and limits, but the current active phase is Cycle 08 Sprint 01.

Classification: expected checkpoint staleness at a cycle boundary.

Provisional resolution:

Refresh it after the Didactic revision is approved so it states:

- protected Cycle 07 learning baseline;
- Cycle 08 product-language investigation;
- concepts needed for Catalogue, Product similarity, Store identity, staged Purchase review, atomic registration, detailed History, responsive behavior, and personal price comparison;
- existing maturity unchanged until explicit learner evidence exists;
- Cycle 09 synchronization concepts remain deferred.

### DDT-04 — Prospective language presented too concretely

Some canonical/derived entries describe authenticated API, server cursors, central catalogue behavior, and TypeScript parity in present-tense project-usage language although those remain Cycle 09 work.

Classification: evidence-state wording drift.

Provisional resolution:

Use explicit labels such as:

- current local implementation;
- provisional contract;
- scheduled Cycle 09 behavior;
- unimplemented example.

Do not delete the concepts; correct their evidence framing.

### DDT-05 — Category pressure in `&%%`

The project-implementation category now includes architecture, domain/value models, synchronization preparation, analytics, and product concepts. It remains usable, but navigation cost is increasing.

Classification: information-architecture pressure, not yet a structural gap.

Provisional resolution:

- retain the marker and IDs;
- add internal thematic navigation within the existing KANBAN rather than creating a new file or marker family;
- evaluate whether Product/UI concepts belong as extensions of existing concepts before introducing new IDs.

## 5. Cycle 08 Didactic investigation boundary

Candidate concepts or distinctions for Didactic Chat to investigate—not yet canonical entries:

- Catalogue versus current Purchase entry;
- visible Product identity versus internal record identity;
- exact duplicate versus advisory similarity;
- suggestion versus automatic merge;
- packaged amount, package count, purchased amount, and normalized amount;
- Store identity versus branch/location description;
- staged Item versus registered immutable Purchase Item;
- draft validation versus atomic commit;
- success acknowledgement versus duplicate retry;
- History fact versus derived price comparison;
- unit-price normalization and comparison interval;
- personal price change versus official/general inflation;
- responsive composition versus device-specific design;
- empty, validation, failure, recovery, and retry states;
- export, backup, migration, and synchronization as distinct boundaries.

These are candidates until Didactic investigation classifies identity, prerequisites, overlap, learner need, and evidence.

## 6. Proposed bounded revision unit

If the human approves materialization, revise only the four Didactic permanent files:

1. `02_KANBAN.md`
   - preserve all concept IDs and statuses;
   - separate stable canonical content from detailed cycle narratives;
   - retain concise evidence pointers and maturity rationale;
   - correct present-tense wording for deferred behavior;
   - add thematic navigation without new files.

2. `07_GLOSSARY.md`
   - preserve concise definitions;
   - remove checkpoint-like evidence narration after reconciliation;
   - distinguish implemented local behavior from future synchronization examples;
   - keep every term traceable to a canonical concept or explicitly provisional vocabulary.

3. `08_CONCEPT_MAP.md`
   - refresh as the Cycle 08 Didactic checkpoint;
   - expose current maturity, evidence limits, Cycle 08 investigation spine, next learner questions, and recovery pointers;
   - remain compact and avoid historical narration.

4. `13_LECTURE_REGISTER.md`
   - preserve all existing observations;
   - append a Cycle 08 domain-revision observation;
   - absorb references to detailed Cycle 07 evidence removed from canonical/derived surfaces;
   - remain append-oriented.

## 7. Non-goals

This revision must not:

- change KANBAN maturity without explicit learner evidence;
- renumber existing concepts;
- create a new Didactic file or marker family;
- select product architecture;
- claim Operational validation;
- rewrite observational history;
- implement Flutter UI or application behavior;
- activate synchronization, authentication, API, or Neon work;
- modify another domain or methodology file.

## 8. Validation gates

Before accepting the revision:

- every existing KANBAN ID remains present exactly once;
- every status change, if any, has explicit learner evidence—or no status changes occur;
- Glossary terms trace to KANBAN concepts or are marked provisional;
- Concept Map remains a compact current checkpoint;
- Lecture Register history is preserved and only appended;
- deferred Cycle 09 behavior is not phrased as implemented Cycle 08 behavior;
- no Didactic fact gains duplicate canonical ownership;
- diff is limited to the four Didactic files;
- methodology and application source remain unchanged.

## 9. Human decisions required

1. Should detailed Cycle 07 evidence paragraphs be removed from KANBAN after their observations are confirmed in the Lecture Register, or retained in a compressed evidence-history appendix?
2. Should the Glossary contain only stable terms, or may it keep a small explicitly labeled provisional-vocabulary section for the active cycle?
3. Should Cycle 08 product vocabulary create new KANBAN entries immediately after investigation, or first remain provisional in B/Concept Map until learner relevance is demonstrated?

## 10. Main recommendation

Proceed with a conservative Didactic pruning:

- preserve concept identity and maturity;
- relocate detailed evidence by semantic role;
- refresh the checkpoint;
- allow provisional Cycle 08 vocabulary without premature canonical promotion;
- defer new concept IDs until Didactic investigation establishes non-duplication and learner value.

Status: provisional Main staging. No Didactic permanent-memory mutation is authorized by this section alone.

---

# Didactic Domain Confrontation Prompt — Canon, Checkpoint, and Derived Consistency

> Status: Critical evaluation staged for human/Main review  
> Methodology basis: `METHOD_FOUNDATIONS.md`, `FLUX.md`, and `PROMOTION_RULES.md`  
> Evaluated surfaces: `02_KANBAN.md`, `08_CONCEPT_MAP.md`, and `07_GLOSSARY.md`  
> Excluded surface: detailed observational-history evaluation

## A. Methodological verdict on the prior J proposal

The prior staged proposal is directionally consistent with the methodology, but it requires three corrections before it can become materialization authority.

1. **Relocation is promotion-sensitive.** Moving text out of KANBAN is not mere pruning. The operation must first distinguish canonical concept evidence from observational narrative. Canonical maturity rationale and stable evidence boundaries cannot be removed solely because similar events appear in the Lecture Register.
2. **The checkpoint must be regenerated, not historically edited.** `08_CONCEPT_MAP.md` is refreshable derived knowledge. Its Cycle 07 state should be replaced by a compact Cycle 08 recovery surface rather than extended with another cumulative report.
3. **Glossary cleanup must be derivable.** A term may remain only when it derives from an identified canonical concept or is explicitly labeled provisional. “Useful wording” by itself is insufficient semantic ownership.

The staged proposal correctly preserves:

- unique canonical ownership;
- separation of promotion and materialization;
- learner evidence as the maturity gate;
- the four Didactic semantic roles;
- existing IDs and historical evidence;
- human/Main authority over the revision;
- the prohibition against inventing a new file merely to solve growth.

## B. Canonical-file evaluation — `02_KANBAN.md`

### B1. Canonical coverage inventory

The KANBAN currently owns **39 concepts**:

- 10 foundational-computing concepts;
- 5 language concepts spanning Python and Dart;
- 17 Markei/project concepts;
- 7 dependency, persistence, packaging, or framework concepts.

Current maturity distribution:

- Green: 0;
- Yellow: 13;
- Red: 26.

The register covers four historical learning concentrations:

1. Python/PySide6 application structure and persistence;
2. SQLite, packaging, installation, and resource lifetime;
3. Flutter/Dart shared-client modelling;
4. identity, local event preparation, future synchronization, and analytics.

### B2. Canonical strengths

- IDs are stable and distinct.
- Every concept has an explicit type marker.
- Definitions distinguish general meaning from Markei manifestation.
- Required/related concept fields make dependencies recoverable.
- Maturity is not promoted from implementation evidence alone.
- Stable Identity, Historical Integrity, raw/derived facts, dimensional quantity, minor-unit money, atomicity, and reusable Catalogue provide a strong basis for Cycle 08.
- The register explicitly distinguishes Dart immutability, append-only events, storage migration, protocol versioning, and framework composition.

### B3. Canonical deficiencies

#### CAN-01 — Canonical scope is implementation-led rather than learning-led

Many concepts entered because architecture or implementation introduced them. The register does not yet demonstrate why all 39 belong in the learner’s active curriculum, how often they were actually discussed with the learner, or which are presently necessary.

Critical question:

> Is the KANBAN a canonical register of concepts intentionally learned, or a canonical index of concepts encountered by the project?

The current file behaves partly as the second. The methodology and user-defined maturity system imply the first.

Required resolution:

- preserve encountered concepts;
- explicitly distinguish curriculum-active, reference-only, deferred, and learner-evidenced concepts without inventing maturity;
- do not delete concepts merely because they are currently inactive.

#### CAN-02 — Maturity has become structurally static

No concept is Green; 26 are Red. Multiple materialization cycles added evidence without changing maturity, correctly, because learner evidence was absent. However, a maturity system that never schedules or captures learner checks becomes archival classification rather than learning progression.

Required resolution:

- retain the strict evidence gate;
- define a lightweight learner-evidence capture route;
- identify a small active learning frontier per sprint;
- do not lower the Green/Yellow threshold to manufacture movement.

#### CAN-03 — Template fields impose false symmetry

Every entry uses Description, Formal Definition, Practical Example, Language Implementation, Project Implementation, Required Concepts, Related Concepts, Status, and Source. This is valuable for foundational concepts but sometimes forces language or implementation content into concepts where it is secondary or prospective.

Required resolution:

- keep a minimum canonical schema;
- allow “not applicable” or omit optional manifestation fields under an explicit schema rule;
- avoid speculative implementation language merely to fill a field.

#### CAN-04 — Present and future project truth are insufficiently separated

Authentication, Authorization, Eventual Consistency, Sync Protocol, cursor behavior, and TypeScript/API examples are legitimate concepts, but some Project Usage fields read as present behavior. Under Promotion Rules, this risks promoting planned architecture into canonical implementation implication.

Required resolution:

Every Project Implementation/Usage statement should classify itself as one of:

- evidenced current manifestation;
- provisional design example;
- scheduled future manifestation;
- general illustrative example.

#### CAN-05 — Cycle 08 product-learning coverage is incomplete

The existing canon can support Catalogue, atomic Purchase, responsive composition, history integrity, and analytics. It does not yet explicitly settle the learner-facing distinctions required for:

- exact duplicate versus advisory similarity;
- visible Product identity versus record identity;
- Product correction versus historical mutation;
- Store identity versus Store branch/location;
- draft Item versus registered Purchase Item;
- staged validation versus atomic commit;
- comparison fact versus interpretation;
- personal price change versus population-level inflation;
- responsive adaptation versus platform-specific interaction.

These are **coverage candidates**, not automatic new concepts. Some may be examples or extensions of existing IDs.

### B4. Canonical disposition test

For every existing or proposed concept, ask:

1. What stable knowledge object does this entry own?
2. Is that object already owned by another concept?
3. Is it foundational, language-specific, project-specific, or dependency/tool knowledge?
4. Is it curriculum-active, reference-only, or deferred?
5. What evidence established its present maturity?
6. Does its Project Implementation field state current evidence or future intention?
7. Can future work depend on this definition without reading cycle history?
8. Would removal lose accepted knowledge, or only duplicated narrative?

A concept passes canonical retention only when these questions have explicit answers.

## C. Checkpoint-efficacy evaluation — `08_CONCEPT_MAP.md`

### C1. Current efficacy

The checkpoint is semantically recognizable and answers most recovery questions:

- current evidence boundary;
- maturity state;
- distinctions to preserve;
- dependency spine;
- next learner questions;
- deeper recovery pointers;
- next authority boundary.

It therefore remains the correct Didactic entry point.

### C2. Current inefficiencies

- Its latest active content still describes Cycle 07 Sprint 05.
- It contains substantial execution detail that duplicates Operational/Main state.
- Its recovery pointers refer to B, H, and old J sections that were intentionally cleansed at Cycle 08 entry.
- It describes the prior post-Codex route rather than the current methodology-revision/product-definition route.
- At roughly 11.7k characters, it is not critically large, but it is longer than necessary for a low-token checkpoint.
- The “Current Truth” section includes platform facts beyond the minimum needed to recover learning state.

### C3. Checkpoint success criteria

A refreshed Cycle 08 checkpoint should answer in one bounded read:

1. Which concepts are currently active for learning?
2. What maturity is accepted, and on what learner evidence?
3. Which project evidence strengthens examples without changing maturity?
4. What distinctions are most liable to confusion now?
5. What is the Cycle 08 concept dependency spine?
6. Which vocabulary remains provisional?
7. What should Didactic Chat read next?
8. What is the next valid authority transition?

It should point outward for execution history instead of reproducing it.

### C4. Recommended checkpoint shape

```text
Current Didactic state
→ active learning frontier
→ accepted maturity summary
→ evidence-versus-mastery boundary
→ Cycle 08 distinctions
→ compact dependency spine
→ provisional vocabulary
→ next learner checks
→ recovery pointers
→ next authority boundary
```

The checkpoint should be refreshed as a present-state document, not appended as a new historical episode.

## D. Derived-consistency evaluation — `07_GLOSSARY.md`

### D1. Current consistency

The Glossary successfully translates many canonical concepts into concise learner-facing definitions and points back to KANBAN IDs. It preserves useful distinctions around platform evidence, identity, persistence, local queue preparation, and Flutter composition.

### D2. Derived inconsistencies

#### DER-01 — Incomplete derivation surface

The Glossary is not a systematic derivative of all 39 canonical concepts. This is not automatically wrong: a glossary may contain only retrieval-worthy terms. But the selection rule is implicit, so absence cannot be distinguished from accidental omission.

Required resolution:

Declare that a Glossary term is included when at least one condition holds:

- vocabulary is used across multiple project surfaces;
- wording is liable to confusion;
- a learner requested clarification;
- a current sprint depends on rapid retrieval.

#### DER-02 — Current-state evidence inside derived vocabulary

The Sprint 05 retrieval section mixes definitions with checkpoint-like evidence. This weakens the Glossary’s rebuildability and causes it to age with implementation state.

Required resolution:

- keep stable distinctions as definitions;
- move current evidence classification to the checkpoint;
- allow brief examples, but label them as examples rather than current global state.

#### DER-03 — Prospective examples risk independent truth

Definitions involving server acceptance, cursor download, authenticated accounts, or future APIs may sound like implemented Markei facts.

Required resolution:

Derived wording must preserve the canonical evidence label. It may simplify language, but it may not strengthen maturity or implementation status.

#### DER-04 — Possible duplication rather than derivation

Several Glossary sections reproduce substantial KANBAN “Project Usage” meaning. A derived term should optimize retrieval, not become a second canonical definition.

Required resolution:

Use a compact contract:

```text
Term
Canonical ID
One-sentence learner definition
Current evidence label, only when necessary
See canonical concept
```

### D3. Derived consistency test

For each Glossary entry, ask:

1. Which canonical ID owns the meaning?
2. Does the wording preserve that concept’s scope and evidence state?
3. Does the entry introduce any rule absent from KANBAN?
4. Is this term needed for retrieval or merely copied?
5. Will it remain correct if the implementation changes?
6. If provisional, is that status explicit?
7. If the canonical entry changes, can this definition be regenerated predictably?

Any entry that creates new truth fails the Derived Knowledge rule.

## E. Cross-surface reconciliation

The desired relationship is:

```text
02_KANBAN
stable concept identity + definition + maturity + canonical evidence boundary
        ↓ derives
07_GLOSSARY
selected concise vocabulary; no independent truth
        ↓ summarizes current learning state
08_CONCEPT_MAP
compact present checkpoint + active frontier + recovery routing
```

The current relationship is partially inverted:

- KANBAN contains observational cycle summaries;
- Glossary contains current checkpoint evidence;
- Concept Map contains extensive Operational/Main execution state.

The files remain recoverable, but semantic responsibilities have blurred.

## F. Revised Didactic materialization recommendation

A later authorized revision should:

1. classify every KANBAN section as canonical concept data or appended cycle evidence;
2. preserve stable maturity rationale and evidence boundaries in KANBAN;
3. remove detailed cycle narrative from KANBAN only after confirming no canonical knowledge is lost;
4. give the Glossary an explicit inclusion rule;
5. reduce Glossary entries to predictable derivatives;
6. refresh—not append—the Concept Map as the Cycle 08 learning checkpoint;
7. replace references to cleansed B/H/J evidence with durable permanent or repository references;
8. classify prospective synchronization language explicitly;
9. stage Cycle 08 product vocabulary as provisional until overlap and learner value are tested;
10. preserve all IDs and statuses unless separate learner evidence authorizes change.

## G. Critical evaluation prompt for the next Didactic pass

```text
Evaluate the Didactic domain under METHOD_FOUNDATIONS, FLUX, and PROMOTION_RULES.

Scope:
- canonical: didactics/02_KANBAN.md;
- derived: didactics/07_GLOSSARY.md;
- checkpoint: didactics/08_CONCEPT_MAP.md;
- skip observational-history analysis except to verify that relocated text has a durable home.

For 02_KANBAN.md:
1. inventory every canonical concept and maturity;
2. distinguish learned curriculum from project-encountered reference concepts;
3. identify duplicate ownership and concept overlap;
4. classify every project manifestation as current, provisional, future, or illustrative;
5. preserve IDs and require learner evidence for maturity;
6. test Cycle 08 product vocabulary against existing concepts before proposing new IDs.

For 07_GLOSSARY.md:
1. identify the canonical owner of every retained term;
2. apply an explicit inclusion rule;
3. remove current-state reporting and independent truth;
4. preserve evidence labels;
5. mark provisional vocabulary explicitly.

For 08_CONCEPT_MAP.md:
1. regenerate a compact Cycle 08 current-state checkpoint;
2. expose active concepts, maturity evidence, confusion risks, dependency spine, recovery pointers, and next authority;
3. remove stale references to cleansed staging;
4. point to deeper sources rather than reproducing execution history.

Report:
- accepted canonical coverage;
- canonical gaps;
- checkpoint efficacy;
- derived consistency;
- duplicate semantic ownership;
- proposed relocations;
- proposed Cycle 08 vocabulary;
- maturity implications;
- exact writable paths;
- validation gates;
- unresolved human decisions.

Do not edit files, create concepts, or change maturity during evaluation.
```

## H. Confrontation conclusion

The prior J staging is methodologically valid as a provisional diagnosis, but it is not yet sufficient as direct edit authority. The revision must be driven by semantic classification, not line reduction. The central Didactic problem is not file size: it is that implementation chronology, current-state retrieval, and stable concept ownership have crossed their intended boundaries.

Status: critical evaluation complete; permanent Didactic mutation remains unauthorized.

---

# Cycle 08 Methodology Review — Design Domain

> Status: Critical evaluation staged for human/Main review  
> Methodology basis: `METHOD_FOUNDATIONS.md`, `FLUX.md`, and `PROMOTION_RULES.md`  
> Evaluated surfaces: `design/01_ARCHITECTURE.md`, `design/09_DESIGN_STATE.md`, and `design/14_MODEL_OVERVIEW.md`  
> Observational surface inspected only for routing: `design/03_DECISION_LOG.md`

## 1. Review purpose

Evaluate whether Design canonical knowledge, checkpoint recovery, and derived modelling still satisfy their methodology roles at the Cycle 08 boundary. Stage a bounded revision proposal without modifying permanent Design files or selecting Cycle 08 implementation architecture.

## 2. Current semantic assignment

| File | Assigned role | Current condition |
| --- | --- | --- |
| `01_ARCHITECTURE.md` | Canonical accepted architecture | Strong stable boundaries, but chronological implementation/evidence sections and future topology are mixed into canon |
| `09_DESIGN_STATE.md` | Compact current Design checkpoint | Correct semantic role; stale at Cycle 07 Sprint 05 and overly detailed in Operational evidence |
| `14_MODEL_OVERVIEW.md` | Derived responsibility/model map | Clear and useful, but substantially duplicates the checkpoint and parts of canonical architecture |
| `03_DECISION_LOG.md` | Append-oriented observational Design history | Correct home for decision sequence, alternatives, reversibility, and superseded context; detailed evaluation intentionally skipped |

## 3. Methodological verdict

The Design structure remains valid under Domain Symmetry. No additional file is justified. The required correction is semantic redistribution:

- canonical architecture owns stable accepted responsibilities, dependency direction, invariants, and protected boundaries;
- the derived overview reorganizes canon into a compact system/model map without adding truth;
- the checkpoint exposes current accepted, provisional, implemented, blocked, and deferred Design state;
- the Decision Log preserves chronology, alternatives, and why boundaries changed.

The existing files are recoverable, but vertical reconciliation is incomplete because implementation evidence and chronological acceptance have entered canonical architecture, while the checkpoint and derived overview repeat each other.

Any revision must classify knowledge before moving it. Line reduction is not authority to remove accepted architecture.

## 4. Canonical-file evaluation — `01_ARCHITECTURE.md`

### 4.1 Canonical coverage

The canonical file currently covers:

1. protected Python/PySide6 desktop composition;
2. application/service/repository/persistence boundaries;
3. packaging, installer, writable-state, retention, and release identity;
4. evidence boundaries;
5. shared Flutter client dependency direction;
6. local-first Drift persistence;
7. private Catalogue, Product, Store, Purchase, and Item responsibilities;
8. dimensional quantity, money, and versioned analytics;
9. prepared events, queue, Device sequence, and proposed synchronization topology;
10. account/authentication/authorization direction;
11. protected migration and rollback;
12. implemented Flutter foundation;
13. Product identity and exact/advisory matching;
14. atomic Purchase/event/queue transaction;
15. local schema and contract responsibility;
16. Android host and installation identity;
17. persistent Device ownership and prototype selection debt;
18. functional scaffold and platform-evidence boundaries.

### 4.2 Canonical strengths

- Dependency direction is explicit and stable.
- Domain code remains independent of widgets, Drift, HTTP, Python, and platform hosts.
- Presentation, application, domain, and infrastructure responsibilities are distinguishable.
- Purchase registration has a clear transaction boundary.
- Product visible code, internal record identity, and normalized identification facts are separated.
- Exact matching and advisory similarity are not confused with automatic merge.
- Local event preparation is explicitly distinguished from synchronization.
- Android application identity is separated from Account, Device, and domain identities.
- The Python beta and original data remain protected during transition.
- Prototype Device lookup debt is stated rather than silently promoted.
- Configuration facts are not automatically treated as domain architecture.

### 4.3 Canonical deficiencies

#### DSN-CAN-01 — Canonical architecture is chronological

Sections 17–19 narrate successive implementation sprints. Some content is stable architecture, but some records what was implemented or validated during a particular sprint. Canonical architecture should improve the current definition rather than accumulate one accepted architecture per sprint.

Classification: canonical/observational mixing and recovery-cost drift.

Required resolution:

- reconcile stable rules into thematic architecture sections;
- preserve supersession and rationale in the Decision Log;
- retain evidence boundaries only as concise qualification;
- avoid deleting unique accepted invariants while removing chronology.

#### DSN-CAN-02 — Accepted architecture and implementation evidence are mixed

Statements such as test totals, emulator execution, schema migration results, runtime database observations, and host validation support acceptance but are not themselves architecture.

Classification: canonical/Operational evidence overlap.

Required resolution:

Canonical architecture may state an evidence-qualified boundary, such as “Android is an evidenced host for the shared client,” but detailed commands, test counts, devices, and validation ladders belong to Operational or observational memory.

#### DSN-CAN-03 — Future distributed topology is overly concrete

The file describes authenticated TypeScript API, Neon Postgres, cursor allocation, batch behavior, verified email, and event acceptance in architectural present tense. These are scheduled Cycle 09 boundaries, not implemented Cycle 08 architecture.

Classification: maturity/evidence-state wording drift.

Required resolution:

Label each distributed statement as:

- accepted future boundary;
- provisional candidate;
- deferred implementation;
- explicitly unselected physical mechanism.

Stable prohibitions—such as clients not holding privileged database credentials—may remain canonical if accepted independently of the future stack.

#### DSN-CAN-04 — Stable invariant and provisional implementation choice need clearer grammar

The file already contains exclusions, but readers must infer whether Drift, UUID v4, JSON Schema Draft 7, TypeScript, Neon, schema v2, and first-20 lookup are stable, implemented, provisional, or prototype-only.

Required resolution:

Every technology or mechanism should be classified by architectural status:

- stable responsibility/invariant;
- accepted current implementation;
- reversible adapter choice;
- prototype-only heuristic;
- candidate future dependency;
- deferred/unselected.

#### DSN-CAN-05 — Cycle 08 presentation architecture is intentionally absent

The file correctly refuses to promote the functional scaffold into final UI architecture. Cycle 08 now requires investigation of:

- responsive navigation responsibilities;
- narrow/wide composition;
- Catalogue/Product/Store/Purchase/History screen boundaries;
- staging and review state ownership;
- validation, empty, success, and failure states;
- draft lifetime and recovery;
- atomic registration acknowledgement;
- price-comparison input/output boundaries;
- raw facts versus derived presentation;
- accessibility, focus, keyboard, Back, and lifecycle responsibilities;
- export/backup and recovery interfaces.

These are design questions, not yet accepted canon.

#### DSN-CAN-06 — Structural navigation is uneven

The canonical sequence jumps from section 11 to section 16 and later appends 17–19. Even if historically explainable, it weakens current recovery and suggests that removed or superseded sections are not clearly represented.

Classification: internal navigation drift.

Required resolution:

During authorized reconciliation, either restore a coherent thematic section map or explicitly reserve/supersede missing sections. Renumbering headings is allowed only if references in checkpoints, prompts, and other files are updated coherently; it must not alter architectural meaning.

### 4.4 Canonical disposition test

For every architecture statement, ask:

1. What responsibility, dependency, invariant, or boundary does it define?
2. Is it stable accepted architecture, current implementation, provisional choice, prototype debt, or future direction?
3. Is Design the semantic owner, or is the statement primarily Operational evidence?
4. Would the statement remain valid if the adapter, schema, framework, or host changed?
5. Is the same stable rule owned elsewhere at equal authority?
6. Does the statement describe current reality or scheduled Cycle 09 behavior?
7. Can the reason for a superseded rule be recovered from the Decision Log?
8. Can future implementation depend on this statement without reading sprint chronology?

Only stable accepted Design knowledge belongs in canonical architecture.

## 5. Checkpoint-efficacy evaluation — `09_DESIGN_STATE.md`

### 5.1 Current efficacy

The checkpoint provides:

- a current topology;
- implemented and validated structures;
- accepted boundaries;
- prototype debt;
- evidence limits;
- next route;
- recovery pointers.

Its length is compact relative to the canonical file, and it successfully exposes the Device invariant debt.

### 5.2 Current inefficiencies

- It is still titled and scoped to Cycle 07 Sprint 05.
- Its header version says Sprint 03 while its body says Sprint 05.
- It contains detailed Operational evidence, including test totals and emulator facts.
- It points to C/F/I and old J §24, all of which were cleansed at Cycle 08 entry.
- Its next route concerns closing Sprint 05 rather than Cycle 08 Design investigation.
- It does not expose the active product/UI questions.
- It combines “implemented and validated” without consistently separating source materialization, automated evidence, host evidence, and human acceptance.

### 5.3 Checkpoint success criteria

A Cycle 08 Design checkpoint should answer in one bounded read:

1. What architecture is accepted?
2. What implementation structures currently materialize it?
3. Which choices remain provisional or reversible?
4. Which debts threaten the active cycle?
5. Which Cycle 08 boundaries are under investigation?
6. Which work is explicitly deferred to Cycles 09 and 10?
7. What evidence limits constrain design claims?
8. What should Design Chat read next?
9. What authority transition is valid?

### 5.4 Recommended checkpoint shape

```text
Accepted architecture
→ current materialized topology
→ provisional/reversible choices
→ active Cycle 08 design questions
→ carried invariant debt
→ evidence boundary
→ deferred Cycle 09/10 work
→ recovery pointers
→ next authority transition
```

The checkpoint should be refreshed, not appended as another historical sprint report.

## 6. Derived-consistency evaluation — `14_MODEL_OVERVIEW.md`

### 6.1 Current strengths

- The system map is readable.
- Identity ownership is centralized effectively.
- Device bootstrap and prototype debt are clear.
- Purchase transaction and configuration boundaries are compact.
- The file points to canonical architecture.
- It distinguishes current local structure from deferred synchronization.

### 6.2 Derived inconsistencies

#### DSN-DER-01 — Overview/checkpoint duplication

Sections on prototype debt, evidence, next route, and recovery pointers closely reproduce `09_DESIGN_STATE.md`.

Required resolution:

The model overview should emphasize structural relationships and ownership. The checkpoint should own current status, evidence classification, active questions, and next route.

#### DSN-DER-02 — Implementation topology may outrun canonical status

The overview describes concrete composition calls, table fields, schema version, host facts, and deferred API stack. These are useful, but a derived file cannot silently promote them beyond the architectural status assigned in canon.

Required resolution:

Every concrete mechanism must trace to a canonical accepted/current implementation statement and retain its provisional or prototype label.

#### DSN-DER-03 — Current-state reporting weakens rebuildability

Test totals, emulator observations, and detailed validation classes age quickly. A model map should remain mostly correct when evidence counts change.

Required resolution:

Replace detailed evidence with short boundary labels and point to the checkpoint or Operational memory.

#### DSN-DER-04 — Product model is underrepresented for Cycle 08

The overview maps identity and Purchase transaction well but does not yet expose Store identity, Product reuse/creation, advisory duplicate handling, draft Items, review, History detail, or analytics presentation.

Required resolution:

After Design investigation and canonical acceptance, derive a Cycle 08 responsibility map from the accepted architecture. Do not add speculative product structure before that acceptance.

### 6.3 Derived consistency test

For every section or relationship, ask:

1. Which canonical architecture section owns it?
2. Does it reorganize accepted truth or add a new invariant?
3. Does it preserve provisional/prototype/deferred labels?
4. Is it structural, or is it current checkpoint/evidence material?
5. Would it remain useful if test counts or platform evidence changed?
6. Does it duplicate another derived/checkpoint surface?
7. Can it be regenerated predictably after canonical revision?

Any new responsibility or invariant introduced only in the overview fails the Derived Knowledge rule.

## 7. Cross-surface reconciliation

Desired relationship:

```text
01_ARCHITECTURE
stable responsibilities + dependencies + invariants + accepted boundaries
        ↓ derives
14_MODEL_OVERVIEW
compact structural map + identity/ownership relationships
        ↓ summarizes current design state
09_DESIGN_STATE
accepted/provisional/materialized/deferred status + active questions + recovery route
```

Current drift:

- Architecture carries sprint chronology and detailed evidence.
- Model Overview carries checkpoint/evidence sections.
- Design State repeats much of the overview and old Operational validation.
- All three refer to Cycle 07 evidence surfaces that were cleansed.

## 8. Cycle 08 Design investigation boundary

Design Chat should investigate, without premature architecture selection:

- responsive shell and navigation responsibilities;
- wide/narrow composition and state continuity;
- Catalogue browse/search/select/create;
- exact reuse versus advisory duplicate warning;
- Product corrections and historical integrity;
- Store identity, branch/location, reuse, and creation;
- Purchase draft ownership and lifetime;
- Item edit/remove/reorder and running totals;
- review and atomic registration boundary;
- success, failure, retry, and duplicate-submit prevention;
- History list/detail and immutable facts;
- normalized price observations and versioned comparison analytics;
- personal price change versus broader inflation claims;
- empty/loading/validation/recovery states;
- migration, export, backup, and recovery interfaces;
- Windows/Android focus, keyboard, Back, safe-area, accessibility, and lifecycle composition;
- explicit installation-to-Device invariant timing.

No UI framework, navigation package, state package, schema, API, or synchronization mechanism is selected by this investigation.

## 9. Proposed bounded revision unit

If later authorized:

1. `01_ARCHITECTURE.md`
   - reconcile stable boundaries thematically;
   - separate canonical rules from sprint evidence;
   - classify current, provisional, prototype, future, and deferred mechanisms;
   - preserve the protected transition and Device debt;
   - correct internal navigation and cross-references.

2. `14_MODEL_OVERVIEW.md`
   - rebuild from accepted canonical architecture;
   - focus on responsibilities, identities, dependency direction, and aggregate relationships;
   - remove detailed evidence and next-route duplication;
   - include Cycle 08 product relationships only after canonical acceptance.

3. `09_DESIGN_STATE.md`
   - refresh as the Cycle 08 Design checkpoint;
   - expose accepted state, materialized topology, active investigation, carried debt, evidence limits, deferrals, and next route;
   - remove stale references to cleansed C/F/I/J sections.

4. `03_DECISION_LOG.md`
   - preserve existing history;
   - append only the later accepted Design-revision event and its rationale;
   - do not use it as current-state canon.

## 10. Non-goals

The Design revision must not:

- select the final Cycle 08 UI architecture before A/B/C and human decisions;
- add Flutter dependencies or frameworks;
- modify schema or source;
- activate authentication, API, Neon, or synchronization;
- turn the first-20 Device heuristic into accepted architecture;
- rewrite decision history;
- create or rename Design files;
- claim Operational validation;
- change Didactic maturity;
- duplicate Main global state.

## 11. Validation gates

- every accepted responsibility and invariant has one canonical owner;
- chronological evidence removed from architecture remains recoverable;
- no Operational test/build details become canonical Design truth;
- future Cycle 09 topology is explicitly classified;
- Model Overview introduces no independent truth;
- Design State is compact, current, and free of cleansed-stage dependencies;
- prototype Device debt remains visible;
- Python/PySide6 protection remains explicit;
- Cycle 08 product questions remain proposed until human/Main acceptance;
- diff is limited to the four Design files during later materialization;
- methodology and application source remain unchanged.

## 12. Human decisions required

1. Should canonical architecture be rewritten into one thematic current model, with all sprint-specific acceptance chronology left to the Decision Log?
2. Should TypeScript and Neon remain named accepted Cycle 09 direction in canon, or be generalized to “custom API” and “managed Postgres” until physical selection is revalidated?
3. Should implemented adapter choices such as Drift and JSON Schema remain in canonical architecture as accepted current mechanisms, or live primarily in the derived model with canon owning only their responsibilities?
4. Should section numbers be normalized during pruning, with repository-wide reference repair?
5. At what Cycle 08 point must the explicit installation–Device invariant become mandatory: before Catalogue/Purchase expansion, before backup/recovery work, or only before Cycle 09 synchronization?

## 13. Critical evaluation prompt for the next Design pass

```text
Evaluate the Design domain under METHOD_FOUNDATIONS, FLUX, and PROMOTION_RULES.

Scope:
- canonical: design/01_ARCHITECTURE.md;
- derived: design/14_MODEL_OVERVIEW.md;
- checkpoint: design/09_DESIGN_STATE.md;
- inspect design/03_DECISION_LOG.md only to verify that removed chronology has a durable observational home.

For 01_ARCHITECTURE.md:
1. inventory stable responsibilities, dependencies, invariants, and protected boundaries;
2. separate canonical architecture from sprint chronology and Operational evidence;
3. classify every mechanism as stable, current implementation, reversible adapter, prototype-only, future candidate, or deferred;
4. identify duplicate semantic ownership;
5. preserve accepted Product/Purchase/identity/transaction rules and protected PySide6 transition;
6. treat Cycle 08 UI/product structures as investigation until human/Main acceptance.

For 14_MODEL_OVERVIEW.md:
1. trace every model relationship to canonical architecture;
2. remove independent truth and checkpoint duplication;
3. preserve status labels;
4. optimize the file for structural comprehension and regeneration;
5. add Cycle 08 relationships only after canonical acceptance.

For 09_DESIGN_STATE.md:
1. regenerate a compact Cycle 08 current checkpoint;
2. expose accepted architecture, materialized topology, provisional choices, active questions, Device debt, evidence limits, deferrals, and next authority;
3. remove stale references to cleansed stages;
4. point to deeper sources rather than reproducing validation history.

Report:
- accepted canonical coverage;
- canonical gaps and chronology drift;
- checkpoint efficacy;
- derived consistency;
- duplicate ownership;
- proposed relocations;
- Cycle 08 Design questions;
- exact writable paths;
- validation gates;
- unresolved human decisions.

Do not edit permanent files, select architecture, modify source, or promote provisional Cycle 08 structures during evaluation.
```

## 14. Main recommendation

Proceed later with a conservative thematic reconciliation:

- preserve stable architectural meaning;
- move chronology and detailed evidence out of canon by classification, not deletion;
- rebuild the model overview as a structural derivative;
- refresh the checkpoint for Cycle 08;
- classify future synchronization topology explicitly;
- keep Cycle 08 product/UI architecture provisional until functional investigation and human decisions;
- retain the Device invariant as visible gating debt.

Status: Design confrontation complete; permanent Design mutation remains unauthorized.

---

# Cycle 08 Methodology Review — Operational Domain

> Status: Critical evaluation staged for human/Main review  
> Methodology basis: `METHOD_FOUNDATIONS.md`, `FLUX.md`, and `PROMOTION_RULES.md`  
> Evaluated surfaces: `operational/12_OPERATIONAL_MODEL.md`, `operational/10_OPERATIONAL_STATE.md`, and `operational/04_TODO.md`  
> Observational surface inspected only for routing: `operational/11_OPERATIONAL_RECORD.md`

## 1. Review purpose

Complete the acquired-documentation review by evaluating whether Operational canonical knowledge, checkpoint recovery, and derived executable planning still satisfy their methodology roles at the Cycle 08 boundary. Stage a bounded revision proposal without modifying permanent Operational files, host tools, dependencies, application source, or platform state.

## 2. Current semantic assignment

| File | Assigned role | Current condition |
| --- | --- | --- |
| `12_OPERATIONAL_MODEL.md` | Canonical stable Operational rules | Strong evidence and safety model; some product/repository incidents, concrete release configuration, and future synchronization rules need classification |
| `10_OPERATIONAL_STATE.md` | Compact current Operational checkpoint | Semantically correct but stale at Cycle 07 Sprint 05, internally version-stale, and dependent on cleansed staging |
| `04_TODO.md` | Derived executable gates/backlog | Contains useful gates but combines obsolete Cycle 07 preparation, inactive Cycle 09 work, and carried current debt |
| `11_OPERATIONAL_RECORD.md` | Append-oriented execution history | Correct home for commands, results, contradictions, host changes, and chronological evidence; detailed evaluation intentionally skipped |

## 3. Methodological verdict

The four-file Operational structure remains valid. No new file is justified.

The domain needs vertical reconciliation:

- stable repeatable execution, validation, safety, recovery, and evidence rules belong in the canonical Operational model;
- current passing, partial, blocked, host-unvalidated, and deferred state belongs in the checkpoint;
- executable next gates and bounded backlog belong in TODO;
- commands, versions, hashes, incidents, contradictions, and results belong in the Record.

The existing model itself states this maintenance rule, but later appendices partially violate it. The revision must enforce the rule by semantic classification, not indiscriminate deletion.

## 4. Canonical-file evaluation — `12_OPERATIONAL_MODEL.md`

### 4.1 Canonical coverage

The Operational canon currently covers:

1. runtime and writable-persistence separation;
2. schema-first production initialization;
3. packaging and installer authority;
4. an explicit evidence ladder;
5. installed lifecycle and retained-data rules;
6. startup diagnostics and deterministic shutdown;
7. database ownership and transaction safety;
8. artifact/source separation;
9. beta acceptance boundaries;
10. local synchronization safety;
11. unknown network outcomes and idempotent retry;
12. migration rehearsal and recovery;
13. protection of accepted desktop data;
14. generated-source ownership;
15. platform scaffold versus platform validation;
16. monotonic sequence and identity-normalization proof;
17. contract examples versus complete protocol;
18. host-mutation authority;
19. identity-bearing migration safety;
20. structural schema validation boundaries;
21. Android evidence classification;
22. lifecycle-checklist closure;
23. SDK/AVD recovery;
24. repository/report reconciliation;
25. precise workflow terminology.

### 4.2 Canonical strengths

- The evidence ladder prevents later gates from being inferred from earlier ones.
- Host mutation, cleanup, and ordinary-user-data safety are explicitly bounded.
- Reproducible artifacts are distinguished from source truth.
- Runtime, installer, and build-time dependencies are separated.
- Platform scaffolding does not count as platform validation.
- Transactions, migrations, unknown network outcomes, and cursor advancement have strong safety rules.
- Accepted Python data remains isolated from experiments.
- Generated files are reviewed through generators, configuration, regeneration, and validation.
- Human-visible acceptance remains distinct from automated technical evidence.
- Local queue preparation is not confused with synchronization.
- The model correctly treats report/repository disagreement as drift rather than choosing documentation over source.

### 4.3 Canonical deficiencies

#### OPS-CAN-01 — Stable rule and repository incident are mixed

The model records the specific committed installer binary contradiction and the `x64compatible` warning. These facts were useful, but they are repository incidents or bounded maintenance debt rather than timeless Operational rules.

Classification: canonical/observational mixing.

Required resolution:

- preserve the general artifact policy and warning-classification rule in canon;
- leave the specific binary contradiction, filename, warning instance, and disposition history in the Record/checkpoint/TODO;
- do not erase unresolved cleanup merely to purify canon.

#### OPS-CAN-02 — Concrete Cycle 06 release configuration may be over-canonical

Per-user install paths, exact launcher composition, PyInstaller/Inno Setup roles, and page-specific shutdown chains are accepted for the protected Python beta. They are not universal rules for the Flutter shared client.

Classification: product-generation scope ambiguity.

Required resolution:

Explicitly label rules as:

- project-wide Operational invariant;
- protected Python-beta Operational contract;
- current Flutter-client Operational contract;
- future distributed-safety rule.

This preserves valid historical/current contracts without making them apply to every client.

#### OPS-CAN-03 — Future synchronization safety is canonical before implementation

The synchronization safety rules are valuable technology-independent invariants. However, “canonical” must mean accepted operational requirements for future work, not implemented or validated synchronization behavior.

Required resolution:

Keep rules such as no privileged client credentials, atomic event/fact persistence, safe retry, and atomic cursor application, while labeling them “accepted future gates; implementation absent until Cycle 09.”

#### OPS-CAN-04 — Canonical appendices are cycle-derived

Generated-source, host/migration, and Android recovery sections contain stable reusable rules, but they were appended after individual sprints. Their knowledge is valid; their organization remains chronological and may grow one appendix per cycle.

Classification: canonical navigation/recovery-cost drift.

Required resolution:

Reconcile these rules into thematic sections during authorized revision and preserve their origin in the Record. Do not retain sprint-shaped headings in canon when the rule is cycle-independent.

#### OPS-CAN-05 — Acceptance vocabulary is not fully normalized

The model uses configured, built, launched, installed, validated, accepted, blocked, and unknown. Later documentation also relies on implemented, automated-test evidenced, host-executed, human-observed, partial, host-unvalidated, and deferred.

Required resolution:

Define one Operational evidence taxonomy with permitted combinations and scope:

```text
materialized
automated-test evidenced
built
installed
launched
workflow-observed
persistence-observed
lifecycle-validated
physical-device validated
release/distribution validated
host-unvalidated
blocked
deferred
accepted by human/Main
```

The taxonomy must allow platform and workflow qualifiers and must not collapse implementation into acceptance.

#### OPS-CAN-06 — Cycle 08 product-beta gates are absent

The model has strong platform and persistence safety but does not yet state reusable validation rules for:

- responsive navigation and wide/narrow acceptance;
- Catalogue search/reuse/create and advisory duplicates;
- Store selection/create;
- staged multi-item edits/removal/review;
- duplicate-submit prevention;
- atomic registration and failure recovery;
- History list/detail consistency;
- normalized personal price comparison;
- empty, validation, success, failure, and retry states;
- larger catalogue/history volumes;
- backup/export decision and recovery;
- accessibility/focus/keyboard/Back;
- migration from current local schema;
- the installation–Device invariant before synchronization.

These are candidates for Operational investigation. Only reusable accepted validation rules should later enter canon.

### 4.4 Canonical disposition test

For every Operational statement, ask:

1. Is this a reusable execution, validation, safety, recovery, or evidence rule?
2. Is it project-wide, Python-beta-specific, Flutter-specific, or a future distributed gate?
3. Is it a stable rule or a dated incident/result?
4. Does it prescribe an evidence boundary or claim evidence already exists?
5. Is Operational the semantic owner, or is it primarily Design architecture or Main state?
6. Can the rule survive tool/version/path changes?
7. Is an inactive future gate clearly distinguished from implemented behavior?
8. Can historical origin and failure detail be recovered from the Record?

Only stable reusable Operational knowledge belongs in the canonical model.

## 5. Checkpoint-efficacy evaluation — `10_OPERATIONAL_STATE.md`

### 5.1 Current efficacy

The checkpoint exposes:

- implemented and validated evidence;
- partial and deferred work;
- a current operational decision;
- host recovery requirements;
- authority and next route;
- deeper recovery pointers.

It is the correct Operational entry point and remains moderate in size.

### 5.2 Current inefficiencies

- Header version says Cycle 07 Sprint 02 while the latest body is Sprint 05.
- Branch and inspected head are obsolete for Cycle 08.
- It points to cleansed A/G/J staging.
- It treats the supplemental lifecycle checklist as the current next route even though Cycle 07 is now closed and the debt is carried.
- It contains detailed SDK paths, test totals, emulator details, and repository contradictions that exceed the minimum checkpoint requirement.
- The checkpoint mixes old planning candidates with later implemented reality.
- It does not expose Cycle 08 Sprint 01 investigation authority or product-beta evidence planning.

### 5.3 Checkpoint success criteria

A Cycle 08 Operational checkpoint should answer in one bounded read:

1. What environments and workflows are verified?
2. What evidence survives from Cycle 07?
3. Which claims remain host-unvalidated or partial?
4. What carried debts constrain Cycle 08?
5. What Cycle 08 validation questions are active?
6. What work is blocked or deferred to Cycles 09/10?
7. Which host environments must be preserved?
8. What is the next valid authority transition?
9. What should Operational Chat read next?

### 5.4 Recommended checkpoint shape

```text
Verified baseline
→ protected environments/data
→ carried partial evidence and debt
→ active Cycle 08 investigation
→ failure/recovery risks
→ deferred Cycle 09/10 work
→ recovery pointers
→ next authority boundary
```

Refresh it as current state; do not append another historical report.

## 6. Derived-consistency evaluation — `04_TODO.md`

### 6.1 Current strengths

- Tasks are expressed as executable gates.
- Priorities and completion boundaries are explicit.
- Failure injection, close/reopen, isolation, migration, and platform checks are well formed.
- Host cleanup requires inventory and named removal.
- The lifecycle checklist correctly stops when defects require new authority.
- The file distinguishes future Neon advancement from local proof.

### 6.2 Derived inconsistencies

#### OPS-DER-01 — Obsolete preparation remains active beside completed work

The first ten sections describe Cycle 07 Sprint 03 preparation even though much of the Flutter foundation, persistence, transaction, Windows, and Android work was later materialized.

Classification: stale derived backlog.

Required resolution:

Rebuild TODO from current canonical rules, checkpoint state, and Cycle 08 objective. Completed gates should not remain active merely because their historical plan is useful.

#### OPS-DER-02 — Inactive Cycle 09 work dominates current TODO

Secure credential storage, TypeScript protocol harness, disposable Postgres, Neon, account isolation, and cursor behavior are scheduled for Cycle 09. Keeping them as P0 in the active Cycle 08 TODO misstates priority and authority.

Required resolution:

Move them to an explicitly deferred/scheduled section or concise forward reference. They must not compete with Cycle 08 product-beta gates.

#### OPS-DER-03 — TODO duplicates checkpoint state

The fast recovery card, closure boundary, evidence wording, and current host state partly repeat `10_OPERATIONAL_STATE.md`.

Required resolution:

Checkpoint owns current truth. TODO should own executable outstanding gates, prerequisites, cost, stop conditions, and completion criteria.

#### OPS-DER-04 — Some tasks are no longer correctly scoped

The supplemental Android checklist remains valid debt, but Cycle 07 closure means it should be framed as carried Cycle 08 acceptance debt, not a condition for reopening Sprint 05. Likewise DevTools disposition is hygiene, not product-beta P0.

Required resolution:

Reclassify by current impact:

- Cycle 08 acceptance gate;
- Cycle 08 investigation;
- bounded hygiene;
- deferred Cycle 09;
- deferred Cycle 10.

#### OPS-DER-05 — Cycle 08 operational plan is missing

The active TODO needs gates for:

- current build/run/test reproducibility;
- responsive layout and navigation validation matrix;
- keyboard, Back, focus, larger text, rotation, resume, and process restart;
- Catalogue/Store/Purchase/History workflow validation;
- atomic failure/duplicate-submit testing;
- data-volume and performance evidence;
- migration from existing Flutter schema;
- backup/export decision;
- corruption and recovery behavior;
- app-private persistence across Windows/Android;
- physical-device and release boundaries;
- installation–Device invariant timing;
- privacy-safe diagnostics;
- explicit costs and stop conditions.

These remain investigation candidates until A and Main staging approve exact gates.

### 6.3 Derived consistency test

For every TODO item, ask:

1. Which canonical Operational rule or accepted checkpoint debt derives this task?
2. Is it active in Cycle 08, carried debt, hygiene, Cycle 09, or Cycle 10?
3. Is its authority active, or is it merely scheduled?
4. Does it name prerequisites, command/evidence target, stop condition, and completion boundary?
5. Has it already been completed or superseded?
6. Does it duplicate current-state prose from the checkpoint?
7. Can it be removed or regenerated when the state changes?
8. Would executing it mutate source, host, data, or external infrastructure without D/E/F?

Any task without current derivation and authority should be deferred or removed from the active queue.

## 7. Cross-surface reconciliation

Desired relationship:

```text
12_OPERATIONAL_MODEL
stable execution + evidence + safety + recovery rules
        ↓ derives
04_TODO
current executable gates + prerequisites + costs + stop conditions
        ↓ summarizes current execution state
10_OPERATIONAL_STATE
verified/partial/blocked/deferred baseline + next authority
```

Current drift:

- the canonical model contains dated repository/tool incidents;
- TODO preserves obsolete planning and inactive future work as current P0;
- the checkpoint preserves detailed Cycle 07 evidence and cleansed-stage references;
- all three partially repeat evidence classifications and current route.

## 8. Cycle 08 Operational investigation boundary

Operational Chat should investigate, without implementation:

- current clean clone/bootstrap/run/build/test paths;
- Windows and Android toolchain preservation/recovery cost;
- responsive validation tooling and manual matrix;
- Catalogue and Store workflow testability;
- staged Purchase editing/removal/review;
- atomic commit and duplicate-submit failure injection;
- History detail consistency and price-observation reconstruction;
- analytics fixtures, numeric precision, units, and interval comparison;
- larger catalogue/history volume and performance;
- fresh install, schema migration, reopen, corruption, and recovery;
- backup/export feasibility and acceptance boundary;
- privacy-safe logs and diagnostic export;
- app-private storage behavior;
- keyboard, Back, focus, text scale, rotation, background/resume, and process recreation;
- emulator versus physical-device boundary;
- release/packaging deferrals;
- installation–Device invariant timing;
- exact operational costs, blockers, and stop conditions.

No tool installation, dependency addition, schema mutation, source change, release signing, external infrastructure, or synchronization is authorized by the investigation.

## 9. Proposed bounded revision unit

If later authorized:

1. `12_OPERATIONAL_MODEL.md`
   - reconcile stable rules thematically;
   - label Python, Flutter, and future distributed scopes;
   - move dated incidents and concrete evidence to observational/current surfaces;
   - normalize evidence vocabulary;
   - preserve data safety, transaction, migration, host-mutation, and recovery rules.

2. `04_TODO.md`
   - rebuild from the Cycle 08 checkpoint and objective;
   - remove completed Cycle 07 tasks from the active queue;
   - segregate carried debt, hygiene, Cycle 09, and Cycle 10;
   - define Cycle 08 investigation/acceptance gates with costs and stop conditions;
   - avoid duplicating checkpoint state.

3. `10_OPERATIONAL_STATE.md`
   - refresh as the Cycle 08 Operational checkpoint;
   - retain only the verified baseline, carried debt, active investigation, evidence limits, preserved environment, and next authority;
   - remove stale references to cleansed A/G/J.

4. `11_OPERATIONAL_RECORD.md`
   - preserve all history;
   - append the later accepted Operational documentation-revision event;
   - remain the home for commands, versions, incidents, contradictions, and results.

## 10. Non-goals

The Operational revision must not:

- run builds, tests, emulators, installers, or devices during documentation revision;
- install or remove tools;
- mutate user data or host configuration;
- modify source, dependencies, schema, or external services;
- activate Cycle 09 synchronization;
- claim Design architecture or Didactic maturity;
- rewrite Operational history;
- create or rename files;
- infer product acceptance from prior technical evidence.

## 11. Validation gates

- every canonical rule is stable and scope-labeled;
- dated incidents remain recoverable outside canon;
- evidence taxonomy does not collapse build, launch, workflow, lifecycle, physical-device, release, and acceptance gates;
- TODO contains only current or explicitly deferred work;
- completed Cycle 07 tasks are not presented as active;
- Cycle 09/10 work is clearly inactive;
- checkpoint is current, compact, and free of cleansed-stage dependencies;
- host/tool cleanup remains separately authorized;
- accepted Python beta and data protection remain explicit;
- Cycle 08 gates remain proposed until A/B/C and Main/human approval;
- later diff is limited to the four Operational files;
- methodology and application source remain unchanged.

## 12. Human decisions required

1. Should the Operational canon retain product-generation-specific contracts for both Python and Flutter, or contain only project-wide rules with client-specific appendices?
2. Should accepted future synchronization safety rules remain canonical now, provided they are explicitly labeled unimplemented Cycle 09 gates?
3. Should `04_TODO.md` retain deferred Cycle 09/10 sections, or contain only active-cycle work with forward tasks held in Main continuity?
4. Should the carried Android lifecycle checklist be mandatory during Cycle 08 responsive-foundation work or deferred to the final Cycle 08 acceptance sprint?
5. Should DevTools configuration disposition remain a named hygiene task or be retired unless it causes reproducibility drift?
6. Which evidence taxonomy should become the single Operational vocabulary across checkpoints, reports, and acceptance gates?

## 13. Critical evaluation prompt for the next Operational pass

```text
Evaluate the Operational domain under METHOD_FOUNDATIONS, FLUX, and PROMOTION_RULES.

Scope:
- canonical: operational/12_OPERATIONAL_MODEL.md;
- derived: operational/04_TODO.md;
- checkpoint: operational/10_OPERATIONAL_STATE.md;
- inspect operational/11_OPERATIONAL_RECORD.md only to verify that relocated incidents and results have a durable observational home.

For 12_OPERATIONAL_MODEL.md:
1. inventory stable execution, evidence, safety, transaction, migration, host, artifact, and recovery rules;
2. distinguish project-wide, Python-beta, Flutter-client, and future distributed scopes;
3. separate stable rules from dated incidents, versions, commands, and results;
4. normalize evidence-state vocabulary;
5. preserve data protection and explicit mutation authority;
6. classify Cycle 08 validation rules as candidates until accepted.

For 04_TODO.md:
1. derive every task from canonical rules and the current checkpoint;
2. remove completed or superseded Cycle 07 work from the active queue;
3. distinguish Cycle 08, carried debt, hygiene, Cycle 09, and Cycle 10;
4. require prerequisites, evidence target, cost, stop condition, and completion boundary;
5. prevent inactive tasks from implying authority.

For 10_OPERATIONAL_STATE.md:
1. regenerate a compact Cycle 08 checkpoint;
2. expose verified baseline, partial/host-unvalidated evidence, carried debt, active investigation, preserved environment, deferrals, and next authority;
3. remove stale references to cleansed stages;
4. point to deeper sources rather than reproducing execution history.

Report:
- accepted canonical coverage;
- canonical scope/incident drift;
- checkpoint efficacy;
- derived TODO consistency;
- duplicate semantic ownership;
- proposed relocations;
- Cycle 08 Operational gates;
- evidence vocabulary;
- exact writable paths;
- validation gates;
- unresolved human decisions.

Do not edit permanent files, run tools, mutate hosts/data, modify source, or activate deferred work during evaluation.
```

## 14. Main recommendation

Proceed later with a conservative Operational reconciliation:

- preserve the strong safety and evidence model;
- separate product-generation scope and future gates;
- move incidents out of canon without losing unresolved debt;
- rebuild TODO for Cycle 08;
- refresh the checkpoint;
- keep host mutations and cleanup separately authorized;
- treat carried lifecycle work as named acceptance debt;
- keep Cycle 09/10 operational work inactive.

Status: Operational confrontation complete; permanent Operational mutation remains unauthorized.

---

# Acquired Documentation Review — Cross-Domain Closure

The Didactic, Design, and Operational permanent folders have now been reviewed under the same methodology test.

Common drift pattern:

```text
chronological evidence entered canonical files
+ current-state material entered derived files
+ checkpoints retained obsolete cycle/stage references
= vertical reconciliation and recovery-economy debt
```

Domain-specific emphasis:

- Didactic: protect concept identity and learner-evidence maturity while separating curriculum, vocabulary, checkpoint, and execution chronology.
- Design: protect responsibilities/invariants while separating architecture, implementation evidence, model derivation, and future topology.
- Operational: protect safety/evidence/recovery rules while separating stable procedures, incidents, active gates, and inactive future work.

No domain requires a new permanent file. The next valid transition is human resolution of the staged questions, followed by a single Main-approved documentation-revision authority that names exact writable files and validation gates. Application implementation remains inactive.


---

<!-- TEMPORAL_MARKER:C09-S02-ENTRY-2026-07-14 -->
> Temporal boundary — Cycle 09 Sprint 02 begins here. Content above is the reviewed pre-Sprint-02 baseline and retains its existing authority and semantic role. Content below belongs to Sprint 02 investigation, current-UI archival evidence, aesthetic reconciliation, staging, implementation, and later closure. This marker alone authorizes no source change, semantic promotion, or methodology revision.
