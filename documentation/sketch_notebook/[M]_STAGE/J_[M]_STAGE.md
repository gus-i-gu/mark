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
