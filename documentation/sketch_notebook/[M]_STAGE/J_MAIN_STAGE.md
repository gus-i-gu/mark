# J_MAIN_STAGE — Cycle 09 Sprint 02 Post-Codex Reconciliation

> Sequence: D/E/F materialization → G/H/I evidence → Main reconciliation → domain promotion
> Unit: C09-S02 — Functional correction and UI convergence
> Status: FUNCTIONAL INCREMENT ACCEPTED; VISUAL CONVERGENCE OPEN; DOMAIN PROMOTION AUTHORIZED
> Branch: `intermid-cycle-recovery`
> Implementation staging: `5ddff3c5eae582f0e25c1ecd0cfb3fe962026cf3`
> Reconciled implementation HEAD: `1d817972aea0229c9f109f236f4d224671927aab`
> Inputs: D/E/F, implementation diff, G/H/I, tests/build reports and human Windows observation
> Authority: human-supervised Main synthesis

---

<!-- ROUND_MARKER:C09-S02-POST-CODEX-RECONCILIATION-2026-07-14 -->

## 1. Purpose and authority

This J reconciles the Sprint 02 implementation rather than repeating its intended contract.
It distinguishes implemented evidence from report claims, deviations and remaining work. It
authorizes bounded promotion into permanent Operational, Didactic and Design documentation.
It does not authorize another source mutation or declare Cycle 09/Sprint 02 visually closed.

Earlier J states remain recoverable in Git. A/B/C are investigative inputs, D/E/F are the
controlling implementation contract, and G/H/I are post-Codex evidence reports. Where reports
and source differ, source plus executable/manual evidence controls.

## 2. Reconciled implementation abstract

The materialization is a meaningful local-first functional increment. Schema v4, immutable
visible reference sequences, mandatory Product codes, manual Purchase occurrence input, exact
code lookup/autofill, same-unit BULK calculation and several selection/detail behaviors are now
represented in source and automated tests. Flutter analysis, 43 tests, migration coverage and a
Windows build were reported successful within the named scope.

The materialization is not the requested visual reconstruction of target images 01–05. It adds
a small theme and component foundation plus navigation adjustments, but it does not consistently
compose the pages from that system. Human Windows observation that the interface changed little
is consistent with the source. Therefore functional/schema progress is accepted while UI/UX
visual convergence remains an open correction unit.

## 3. Accepted implemented facts

### 3.1 Data and identity

- Local schema v4 introduces Account-scoped visible counters and immutable `@001` Person and
  `#001` Payment Method references while preserving opaque relational identity.
- Product code is non-null, normalized, unique within Account and treated as immutable after
  creation; migration/backfill behavior has test coverage.
- Person and Payment Method remain optional Purchase labels. No credential data is stored.
- Purchase occurrence date/time is manually entered, begins blank, is parsed at the application
  boundary and remains distinct from insertion time.

### 3.2 Purchase and Product behavior

- Exact Product-code lookup can resolve and autofill Product facts without automatically adding
  a Purchase Item.
- BULK amount and same-unit rate calculate a read-only line total through fixed-point logic.
- Catalogue exposes explicit selection/detail interaction improvements.
- Lists now distinguish zero compatible observations from one observation in user-facing state.
- History retains multi-selection actions and adds detail access.

### 3.3 Validation evidence boundary

- Reported green evidence: `flutter analyze`, 43 Flutter tests, schema-v4 migration tests and
  Windows build.
- The Windows run was a bounded hidden smoke launch, not a complete manual workflow or visual
  acceptance pass.
- Android validation remains host-blocked by missing Java and is not inferred from Windows.
- No manual accessibility, keyboard traversal or screen-reader validation was completed.

## 4. Deviations and unresolved obligations

### 4.1 Visual composition is materially incomplete

- `markei_theme.dart` establishes only a compact palette/theme layer.
- `markei_components.dart` defines three components, but implementation search shows no page
  consuming them; a component library that is not composed cannot establish visual convergence.
- Home and Lists pages were not materially rebuilt in the implementation commit.
- Catalogue and History remain primarily standard list compositions; Purchase remains the prior
  long-form layout with added functional fields.
- The target desktop information hierarchy, cards, tables, filters, spacing, responsive page
  compositions and compact-card treatment are therefore not accepted as materialized.
- Target images 01–05 remain directional product references, not pixel-perfect test oracles.

### 4.2 Interaction and integration gaps

- The controlling contract said History double-click toggles/selects a Purchase row. Current
  source uses double-click for detail focus and does not toggle the multi-selection set. This is
  a documented deviation requiring either implementation correction or a new human decision.
- Native OS sharing was not adopted. Deterministic PDF generation/export remains the fallback;
  native-share acceptance remains open.
- Lists gained state-language distinction but not the complete catalogue-plus-purchase relational
  presentation, summary cards, filtering or target responsive composition.
- Product selection/details improvements do not yet constitute the complete desktop/mobile UX
  represented by the target references.

### 4.3 Maintainability debt

- The usual approximately 250-line file guidance is exceeded by `purchase_page.dart` (about
  1,020 lines), `products_page.dart` (about 377) and `history_page.dart` (about 330).
- Permanent canonical documentation may use its approved exception; application page files do
  not inherit that exception. Future visual work must extract bounded page sections/controllers
  rather than further expanding monolithic files.

## 5. Main disposition

| Concern | Disposition |
| --- | --- |
| Schema v4 and local identity sequences | Accept with named automated evidence |
| Product code, occurrence and BULK core | Accept with remaining host/manual boundaries |
| Catalogue/History functional increment | Accept partially; retain interaction deviation |
| Lists projection language | Accept narrowly; full page/read presentation remains open |
| UI theme/component foundation | Record as partial infrastructure, not visual convergence |
| Target images 01–05 | Keep as continuing design references |
| Native sharing | Deferred/open; deterministic PDF fallback retained |
| Android and accessibility | Unvalidated/open |
| Cycle 09 Sprint 02 visual closure | Not authorized |

No permanent file may state that the mockup aesthetics, complete responsive model or full Sprint
02 UX has been delivered. No green build may be used as evidence of visual parity.

## 6. Authorized permanent-documentation promotion

Domain chats must load `INDEX.md`, AGENTS guidance and the complete methodology sequence before
editing. They must reconcile from repository evidence, this J and their own staged competence;
`PROMPT_COLLECTION.md` is not a substitute for full executive context.

### 6.1 Operational competence

Promote the verified test/build/migration scope, retained platform boundaries and actionable
residuals. Windows build is not Windows visual acceptance. Record Android, native sharing,
accessibility, History double-click, Lists presentation and visual convergence as open where the
operational owners require them. Update only Operational permanent owners and write its checkpoint
last.

### 6.2 Didactic/UX competence

Promote only stable vocabulary and interaction semantics supported by implementation. Preserve
the distinction among selection, detail, autofill, item addition, occurrence time, insertion time,
Product code and local reference code. Do not advance learner maturity without learner evidence.
Record visual communication and accessibility equivalence as incomplete. Update only Didactic
permanent owners and write its checkpoint last.

### 6.3 Design competence

Promote schema-v4, identity, calculation and application-boundary decisions with evidence. Record
theme/components as partial architecture and explicitly retain non-use, unchanged page composition,
responsive gaps, monolithic-page debt and the History interaction deviation. Update only Design
permanent owners and write `09_DESIGN_STATE.md` last.

## 7. Repository search-conflict and documentation rules

- Required ancestry for domain work is this J commit; abort on divergent or dirty overlapping
  permanent owners.
- Search the repository before writing so newer canonical facts are not duplicated or contradicted.
- If permanent owners disagree with J or implementation evidence, preserve the conflict visibly
  and return it to Main; do not silently choose one account.
- Each domain edits only its named permanent owners. Do not edit source, methodology, DEV_STAGE,
  J, another domain, `00_PROJECT_STATE.md`, `05_SESSION_LOG.md` or `06_SESSION_SCHEME.md`.
- Keep ordinary documentation near 250 lines. `02_KANBAN.md` may grow to about 400 lines as the
  canonical exception; growth still requires consolidation rather than repetition.
- Commit and push each domain promotion independently. Report changed paths, validation and commit
  SHA. Main will reconcile domain results before any final project-state/session update.

## 8. Next implementation perspective

The next proposed unit is a dedicated visual-convergence correction, not a new data-model expansion:

```text
shared tokens/components actually consumed
→ Home composition
→ Lists composition and relational presentation
→ Catalogue composition
→ Purchase composition and modular extraction
→ History composition and double-click decision
→ desktop/compact screenshot comparison
→ Windows manual workflow + accessibility pass
```

Its acceptance must use page-level visual/manual evidence in addition to tests. It requires a new
Main authorization after permanent promotion; this J does not itself activate Codex.

```text
functional increment: accepted within evidence boundary
visual convergence: open
domain promotion: authorized and isolated
source implementation: not authorized by this J
next Main gate: reconcile domain commits before 00/05/06
```
