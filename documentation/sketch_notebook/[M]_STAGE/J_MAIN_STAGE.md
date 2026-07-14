# J_MAIN_STAGE — Cycle 09 Sprint 02 Investigation Reconciliation

> Sequence: FLX-INV-02 → Main reconciliation
> Unit: C09-S02 — Functional correction and UI convergence
> Status: PROVISIONAL SYNTHESIS; MANAGEMENT DECISIONS PENDING; CODEX INACTIVE
> Branch: `intermid-cycle-recovery`
> Reconciled HEAD: `16cd3ec8d4d6fbb233eec395abb84d89b7149117`
> Implementation baseline: `e37cb700feeca4001cc7835b584c46bb81926af3`
> Inputs: B/C stages, Operational/Design observations, human requirements and images
> Missing input: Sprint 02 A Operational stage
> Authority: human-supervised Main synthesis only

---

<!-- ROUND_MARKER:C09-S02-MAIN-RECONCILIATION-2026-07-14 -->

## 1. Purpose and authority boundary

This J reconciles the Sprint 02 investigation into one compact decision surface. It does
not authorize source, schema, dependency, generated-file, permanent-memory or D/E/F work.
A/B/C remain investigation; J remains provisional synthesis; Codex stays inactive until
Main writes coherent D/E/F after the management decisions in section 7 are answered.

Earlier J content is superseded for active orientation and remains recoverable in Git.
The Cycle 09 Sprint 01 implementation and post-Codex evidence remain historical truth.

## 2. Input and evidence audit

- B at `0b475b9` supplies the 145-line language/UX contract.
- C at `16cd3ec` supplies the 147-line architecture/UI alternatives report.
- `A_OPERATIONAL.md` contains only the Sprint 02 temporal marker after its older content.
  No Sprint 02 Operational investigation was staged. This is a material evidence gap.
- `operational/11_OPERATIONAL_RECORD.md` contains a bounded current-UI observation at
  `2fc6704`; it confirms several source-visible gaps but reports no rerun or platform test.
- `design/03_DECISION_LOG.md` archives the current sparse Material abstraction and the
  proposed mockup language at `54f9093`. It is observational, not architecture authority.
- Current screenshots 6–10 are evidence of the present scaffold. Target images 1–5 are
  accepted product direction by the human, but not literal pixel specifications.
- No Sprint 02 Flutter tests, runtime reproductions, accessibility checks, platform builds,
  migration runs or performance measurements are newly evidenced in A/B/C.

Consequently, this J may reconcile product intent and candidate architecture. It must not
call any Sprint 02 correction implemented, validated or platform-accepted.

## 3. Human-settled product direction

The following requirements are accepted inputs for D/E/F preparation, not open redesign
questions:

1. Images 1–5 define the intended visual/compositional direction: cream/white surfaces,
   dark-green primary language, lavender secondary language, stronger hierarchy, grouped
   cards, wide tables, compact cards, status chips and explicit interaction states.
2. Home remains the landing page. Lists, Purchase, History and Catalogue remain active
   product destinations. Analytics and Household remain visible future/PIN destinations.
3. Purchase places editable `Purchase date` and `Time` immediately after Store, defaults
   them to local now, reviews them before registration and displays `dd/mm/yyyy · HH:mm`.
4. Catalogue and Purchase must provide reliable Product selection plus a distinct Product
   details action. Tap/click/keyboard controls are required; pointer shortcuts never become
   the only accessible path.
5. A Product desktop double-click in Catalogue or Purchase opens Product details. History
   double-click may execute Purchase-row selection, matching its separate selection model.
6. Lists are derived from Catalogue Products and registered Purchase/PurchaseItem facts.
   They are not manually created inventory and must preserve zero/insufficient-history
   Products rather than presenting a blank page.
7. Person and Payment Method remain optional, local-only organizational references.
   `Not assigned` never blocks Purchase registration. Payment Method stores no credentials.
8. User-facing Person and Payment Method presentation must contain `ID · Nickname`, not
   nickname alone; archive history must retain the historical label.
9. BULK entry uses amount, compatible unit and price per canonical unit/volume to derive
   line total. Package fields belong only to PACKAGED Products.
10. Decimal entry accepts comma or point and persists one canonical numeric form.
11. Product visible ID/code remains stable for the Product lifetime and maps to one exact
    identity set. Exact identity is separate from advisory similarity.
12. History selection must support `Move to Analytics` as disabled/planned, CSV export and
    shareable list/PDF, with edit/delete remaining outside current registered-fact scope.

## 4. Reconciled implementation model

### 4.1 Presentation foundation

Use Flutter SDK-first Markei tokens and reusable components rather than a broad page-local
restyle. Candidate layers:

```text
Markei theme/tokens
→ adaptive shell, headers, surfaces, state panels and action hierarchy
→ responsive table/card, filters, selection toolbar and detail surfaces
→ page compositions consuming application read models and callbacks
```

Pages retain transient controllers and selection. Application ports own commands/queries
and typed outcomes. Domain code owns identity, quantity and calculation invariants. Local
adapters own Drift and platform IO. Widgets must not consume Drift rows.

The target mockups are intent references. Accessibility, responsive behavior, actual data,
error states and accepted semantics outrank decorative pixel matching.

### 4.2 Adaptive navigation and page hierarchy

Preferred reconciliation from the accepted mockups:

- expanded: persistent labelled sidebar/rail with active, secondary and future groups;
- compact: `Home`, `Lists`, `Purchase`, `History`, `More` as the primary bottom surface;
- `More`: Catalogue, Settings, Guide, Documentation and visible future/PIN destinations;
- active destination and in-memory Purchase draft survive width changes.

Exact breakpoints are implementation parameters to validate, not domain truths. Start from
compact `<600`, medium `600–1023`, expanded `≥1024`, then adjust only from overflow and
usability evidence.

### 4.3 Product selection, identity and details

Preserve these distinct operations:

```text
select Product ≠ view Product details ≠ add staged Item
exact code lookup ≠ exact identifying-field lookup ≠ similarity search
internal UUID ≠ visible Product code ≠ normalized exact identity key
```

Catalogue supports visible selection/highlight and explicit details. Purchase supports
exact code or exact identifying fields, explicit `Use existing Product`, explicit details,
and `Add staged Item` only after Item facts are complete. Exact collision reuses/opens the
existing Product; it never silently creates or merges another Product.

### 4.4 Purchase occurrence

Recommended without schema change: keep the existing UTC occurrence instant, initialize
editable local fields from a controlled clock, convert the chosen local value to UTC at the
application boundary, and convert to local display in Review and History. Invalid calendar
or time input retains the draft and focuses the owning field.

This model does not preserve the historical timezone/offset. DST repeated-hour behavior
therefore remains a declared limitation unless management selects a richer schema model.

### 4.5 Lists projection

Lists should begin with all Account Products, fetch PurchaseItem/Purchase observations in
one joined or bounded batched query, retain Products with no observations, group in the
adapter and expose explicit states:

```text
NoPurchaseHistory
LearningHistory(latest facts, observation count)
IncompatibleHistory(reason, latest facts)
AvailableCycle(derived status and dates)
ProjectionQueryFailure(typed failure)
```

The read model should expose latest occurrence, amount/unit, line total, derived compatible
unit price and optional Store/Person labels. Storage/Shortage/Market filters apply only to
available cycles; `All` preserves every state. No List/cache table and no N+1 query are
accepted for Sprint 02.

### 4.6 Person and Payment Method references

Keep opaque UUIDs as database foreign keys. The preferred user-facing model is a generated,
immutable, Account-scoped visible code plus nickname, with archive-safe non-reuse. Candidate
formats are `P-0001` and `PM-0001`. Full or truncated UUIDs are not suitable ordinary UI IDs.

This requires a separately bounded schema/migration unit if accepted. It must not be hidden
inside the visual refactor or the active-only nickname uniqueness correction.

### 4.7 BULK pricing

Recommended domain calculation for nonnegative values:

```text
(amountMicros × pricePerCanonicalUnitMinor + 500000) ~/ 1000000
→ authoritative line total in minor currency units
```

Use canonical `kg`, `L` or `un` price basis; accept compatible display units such as `g` and
`ml`; keep the calculated total read-only unless management explicitly authorizes override.
Persist amount/unit and line total as the existing facts; derive comparable unit price for
History/Lists, avoiding a second competing persisted price truth.

### 4.8 Failures and recovery

Typed failures must reach a shared visible contract: operation, field where applicable,
reason, retained-state guarantee and next action. Loading, empty, no-match, validation,
failure and unknown-outcome states remain distinct. Static error definitions belong in
typed code/registry by default; a database table requires a separate persistence rationale.

## 5. Recommended materialization sequence after decisions

```text
Operational acceptance and D/E/F boundaries
→ tokens, theme, shell and shared states
→ Purchase occurrence, Product details/selection, BULK and Review
→ Catalogue → Lists → History/Settings
→ optional approved reference-code migration
→ responsive, accessibility, file-backed and platform validation
```

Each unit must leave the app runnable, retain existing facts and pass named tests. A single
simultaneous UI rewrite is rejected because it obscures rollback and failure attribution.

## 6. Required Operational stage before Codex activation

Operational must still stage A against this J or the same baseline. It must name the host,
branch, fixtures, Lists query/volume gates, responsive/accessibility matrix, migration and
reopen/collision gates, Windows/Android gates, dependency assessment, rollback conditions,
expected changed paths and tests. Host-unvalidated states must remain explicit.

Until A exists and Main converts the reconciled result into D/E/F, source and schema work
remain unauthorized.

## 7. Management decisions still required

### Blocking before D/E/F

M1. **Visible reference ID:** generated immutable codes (`P-0001`, `PM-0001`), or another
exact format/assignment policy? This determines schema and migration scope.
M2. **Product code authority:** must every Product have a database-level non-null code, and
is it user-defined, generated, or either with uniqueness?
M3. **BULK override:** read-only calculated total, or explicit override? If overridden,
which value is authoritative for analytics?
M4. **Time semantics:** one UTC instant/current-local display with the stated limitation,
or offset/zone metadata through schema evolution?
M5. **Lists:** confirm compatible observations, status thresholds, and whether `All`
includes zero-history Products.
M6. **Error catalogue:** typed code registry, or the requested schema table? If persisted,
who edits/version-controls the rows and why?
M7. **Sharing:** is deterministic PDF save/export enough, or is native share blocking?
M8. **Operational completeness:** require the missing A before D/E/F? Recommended: yes.

### Non-blocking if defaults are accepted

M9. Accept compact `Home / Lists / Purchase / History / More` and grouped desktop navigation.
M10. Use light theme only in Sprint 02; defer dark mode.
M11. Stay SDK-first; add dependencies only after Operational assessment.
M12. Treat candidate breakpoints as test starts, not immutable constants.
M13. Defer Lists Store/Person/Category filters unless already supported without scope growth.
M14. Allow future Purchase dates unless a specific household rule is required.

## 8. Handoff state

```text
settled: product direction, functional gaps, layered UI approach, relational Lists basis,
         optional references, BULK derived-total direction and accessible interaction rule
provisional: exact tokens, code formats, thresholds, time metadata and dependency choices
missing: Sprint 02 A Operational stage and new executable/platform evidence
blocked: D/E/F finalization and Codex implementation
next: human decisions M1–M8 → A completion → Main D/E/F staging → Codex
```
