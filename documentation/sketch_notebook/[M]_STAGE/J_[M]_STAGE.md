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
