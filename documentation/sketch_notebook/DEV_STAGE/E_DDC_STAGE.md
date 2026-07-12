# E_DDC_STAGE — Cycle 07 Sprint 03 Flutter Foundation

> Cycle: 07 | Sprint: 03 | Unit: 01
> Status: Main-approved materialization stage
> Branch: `cycle-07-mobile-preparation`
> Baseline: `f6414fbe7394453387067a5a34ca6cc7621bbed3`
> Sources: `[M]_STAGE/J_[M]_STAGE.md` §§17–18; `00_PROJECT_STATE.md`; `05_SESSION_LOG.md`; `06_SESSION_SCHEME.md`

---

# 1. Learning purpose

Turn the reconciled model into bounded executable evidence. Tests must distinguish stable domain facts, language-neutral fixtures, Dart representations, local persistence records, and later synchronization envelopes.

# 2. Required fixture scenarios

Create small versioned JSON fixtures for:

1. PACKAGED Product identity: account + normalized name + normalized brand + mode + measurement kind + normalized package amount + canonical unit;
2. BULK Product identity, excluding package amount;
3. equivalent gram/kilogram display inputs producing the same exact identity;
4. similar spelling producing only an advisory candidate, never automatic merge;
5. valid one-item Purchase;
6. valid multi-item Purchase;
7. invalid Item proving aggregate rollback;
8. `purchase.registered` event containing event/account/device UUIDs, device sequence, payload version, occurrence time, and complete Purchase payload;
9. close/reopen expectations.

Expected values are semantic facts, not localized UI prose.

# 3. Concept evidence

H must say what tests actually demonstrate for stable identity, immutable Dart model, reusable catalogue, Product Identification Set and deterministic normalization, Purchase aggregate, Purchase Item, dimensional quantity, monetary minor unit, append-only event, offline queue preparation, and historical integrity.

No maturity change is authorized. Authentication, authorization, cross-device eventual consistency, cursor download, real server idempotency, and platform lifecycle remain unvalidated unless executed.

# 4. Representation guidance

Use explicit value types:

```text
ProductMode: PACKAGED | BULK
MeasurementKind: MASS | VOLUME | COUNT
CanonicalUnit: KG | L | UNIT
Money: ISO currencyCode + integer minorUnits
```

Use a decimal-safe fixed representation for normalized quantity and record scale/range in I. Binary floating point cannot be a durable identity key. Reject fractional COUNT in this unit. Do not assume every currency has two minor digits.

Exact normalization may reuse an identity. Fuzzy similarity only warns. If deterministic Product UUID is tested, its namespace, canonical bytes, and normalization version must be fixture-visible.

# 5. Analytics boundary

Create only enough Dart analytics-registry structure to prove versioned pure-calculation ownership. One bounded calculation or placeholder is sufficient. Analytics cannot rewrite raw facts or live inside widgets.

# 6. Stop rule

Do not expand into correction/merge/alias, product supersession, household sharing, cloud sync, purchase editing, or a complete analytics suite. Record unresolved questions in H.
