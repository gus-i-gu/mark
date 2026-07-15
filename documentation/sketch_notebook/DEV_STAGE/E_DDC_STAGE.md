# E_DDC_STAGE — C10-S02 Semantic Materialization Authority

> Sequence: FLX-INV-02 → Main D/E/F
> Unit: local retention, snapshot and rebootstrap proof
> Authority: controlling semantic/test contract for Codex
> Learner maturity: unchanged

## 1. Evidence boundary

C10-S01B proved one named local convergence story. C10-S02 may prove one named local recovery story.
Neither proves production Neon behavior, permanent backup, indefinite offline recovery, production
authentication or every Device being current.

Repository/project evidence must not change KANBAN maturity or create a lecture entry. No learner
promotion is authorized.

## 2. Required meanings

| Code or term | Required meaning | Must not imply |
| --- | --- | --- |
| `incremental-available` | supplied cursor remains inside retained event coverage | Device is already current |
| `no-new-events` | valid cursor has no later committed events | cursor validity was not checked |
| `cursor-expired` | required incremental history before the retained floor is missing | local facts were deleted |
| `full-rebootstrap-required` | incremental apply cannot continue; compatible snapshot route exists | recovery has started or will succeed |
| `recovery-unavailable` | no compatible validated snapshot can currently rebuild the scope | autonomous local history is gone |
| `preparing` | server session/manifest work began | artifact is available |
| `downloading` | bounded snapshot chunks are transferring | facts are valid or applied |
| `downloaded` | all chunks arrived and hashes/manifest validate | local state changed |
| `applying` | fresh target is receiving verified snapshot facts | activation or catch-up completed |
| `catching-up` | post-snapshot events are being applied | current high-water reached |
| `recovery-completed` | snapshot, catch-up, acknowledgement and reopen checks passed | future recovery or all Devices are guaranteed |
| `recovery-interrupted` | terminal completion is absent but same session may safely resume | nothing committed unless phase evidence says so |
| `local-changes-block-rebootstrap` | pending/uploading/unknown local work prevents safe replacement | user data should be reset |
| `device-expired` | retention lease ended; incremental coverage may no longer be promised | authorization is revoked |
| `device-revoked` | server authorization is denied | local Device files were remotely erased |

Keep existing `saved-local`, `waiting-upload`, `server-accepted`, `downloaded-applied`,
`duplicate-ignored`, `acknowledged`, `conflict`, `auth-required` and `unknown-outcome` meanings.

## 3. Outcome rules

Every typed result preserves one of:

```text
applied | duplicate-equivalent | not-applied | unknown
```

- Valid empty incremental page: `duplicate-equivalent`, cursor remains valid.
- Cursor expired: `not-applied`, no page facts/cursor mutation.
- Recovery session start replay: same identity/result is `duplicate-equivalent`.
- Corrupt/incompatible snapshot: `not-applied`, target facts/cursor unchanged.
- Interrupted transfer/completion: `unknown` only where commit status truly cannot be known; query
  the same session before creating another.
- Recovery completion: `applied` only after catch-up, acknowledgement and reopen evidence.
- Pending/unknown local outbox: `not-applied`; no reset or silent merge.

## 4. Truthful phase machine

Allowed forward path:

```text
full-rebootstrap-required
→ preparing
→ downloading
→ downloaded
→ applying
→ catching-up
→ recovery-completed
```

Retry/resume may remain in the same phase. Failure may become `recovery-interrupted`, `conflict`,
`protocol-upgrade-required`, `device-revoked`, `auth-required` or `recovery-unavailable`.

Tests must prevent:

- `recovered`, `restored`, `up-to-date` or equivalent before the terminal checks;
- empty page being used for expired cursor;
- `server-accepted` being described as peer application;
- `acknowledged` being described as backup or all-Device convergence;
- server cleanup being described as deletion of local Purchase history.

## 5. Privacy contract

Permitted diagnostics:

- operation and typed result code;
- retryability and safe action;
- correlation/recovery alias;
- cursor range and redacted SnapshotId;
- chunk index, counts, byte totals, durations and hashes;
- Device lifecycle class without credential material.

Forbidden diagnostics:

- Product, Purchase, Store, Person or PaymentMethod payloads;
- raw snapshot body/chunk bytes;
- authorization header, token, password or connection string;
- signed or credential-bearing URL;
- ordinary local database path;
- unredacted enrollment or secret material.

Required plain-language boundary for documentation/tests:

> Markei may retain synchronization events and application snapshots for a bounded recovery policy.
> Server cleanup does not remove Purchase history already stored in an installation. Synchronization
> snapshots are not provider backups or user exports.

No production duration may be stated.

## 6. Required semantic tests

Name and prove behavior equivalent to:

- `empty valid page is not cursor expired`;
- `expired cursor requires full rebootstrap`;
- `snapshot download does not claim recovery complete`;
- `corrupt snapshot leaves facts and cursor unchanged`;
- `interrupted recovery reuses the same recovery session`;
- `snapshot apply is followed by incremental catch-up`;
- `recovery completes only after acknowledgement and reopen`;
- `pending local events block rebootstrap`;
- `server cleanup leaves existing local purchases unchanged`;
- `revoked differs from retention-expired`;
- `application snapshot is not represented as provider backup`.

## 7. Cycle 10/Cycle 11 boundary

Cycle 10 may add types, contracts, tests and minimal neutral lab diagnostics required to exercise the
protocol. It must not add or redesign pages, navigation, cards, dialogs, progress components,
Device-management controls, retry presentation, accessibility composition or Analytics.

Cycle 11 owns all visual/user interaction materialization. It must later consume these truth
conditions without inventing stronger guarantees.

## 8. MCG-01 boundary

Provider branch, database, backup, restore window and role configuration are infrastructure facts.
They are not an application snapshot, supported offline promise, recovery validation or learner
mastery. Codex must not request or reveal MCG-01 secrets.

## 9. H report requirements

H must record:

- vocabulary/statuses actually materialized;
- named semantic tests and results;
- minimal diagnostics, if any;
- privacy/logging inspection;
- unsupported wording intentionally absent;
- confirmation that no UI/UX polishing occurred;
- confirmation learner/KANBAN maturity and lecture history were unchanged;
- deviations between this contract and implementation.
