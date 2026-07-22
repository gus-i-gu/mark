# J_MAIN_STAGE — Protected Submission 500 Reconciliation

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-SUBMISSION-500-DIAGNOSIS_20260722
> Runtime implementation baseline: `5b364216375514f9e43bd58c265fbabf8000c2f8`
> Status: **SUBMISSION 500 D/E/F ACTIVE; REAL SYNC BLOCKED**

## 1. Reconciled provider evidence

The hosted transport-observability checkpoint passed:

- Closure's non-mutating connection check reached `/health/live` and `/health/ready`;
- both requests used fingerprint `500a78db` and returned `200`;
- client, Render and readiness evidence correlated;
- the initial Neon six-table baseline contained one Account, one Device and no synchronization rows.

Main therefore accepts process liveness, database readiness, transport response observation and
correlation as proved for that bounded check. This does not prove protected Sync correctness.

## 2. Controlled retry result

One exact-identity retry was then invoked under the prior gate. Render recorded:

```text
POST /v1/sync/submissions
fingerprint: 46e9a131
request received
operation validation started
request failed: anomalous intermediate status 200
response completed: final status 500
elapsed: under one second
```

Closure observed no response headers before its 1000 ms boundary and retained
`provider-evidence-unavailable`. Neon remained unchanged:

```text
accounts 1 / devices 1 / cursor 0 / submissions 0 / events 0 / acknowledgements 0
```

Events 1–2 remain unknown and next local Device sequence remains 3. No duplication or hosted commit
is evidenced.

## 3. Claim classification

| Claim | PRC-01 classification |
| --- | --- |
| Hosted health path is live and ready | Accepted bounded provider evidence |
| Protected retry reached the API | Accepted correlated provider evidence |
| Protected retry completed with HTTP 500 | Accepted correlated provider evidence |
| Retry committed hosted data | Rejected; post-attempt counts remained zero |
| Internal cause of the 500 is known | Not evidenced |
| Auth0 rejected the request | Not evidenced; no rejection lifecycle event was captured |
| Database transaction started | Not evidenced by current lifecycle logs |
| Client observed the 500 | Rejected; Closure observed no headers before its deadline |
| Historical client diagnostic should be rewritten | Rejected; preserve client-observed history |
| Repeating the real retry is needed for diagnosis | Rejected; the failure is already reproducible enough for code-level work |

## 4. Active unit

The next bounded unit is:

`C10-MCG02-SUBMISSION-500-DIAGNOSIS`

Only D/E/F bearing `C10-MCG02-SUBMISSION-500-DIAGNOSIS_20260722` authorize materialization. They
replace the consumed transport-observability instructions. Existing G/H/I are prior-unit evidence
and must be replaced by Codex.

Codex must reproduce the protected failure locally with synthetic data and disposable PostgreSQL,
identify the exact project-owned cause, correct it minimally, repair lifecycle-status semantics and
validate the client deadline boundary. It must not contact providers or guess from the `500` alone.

## 5. Stop and continuation gate

Until new G/H/I are reconciled, do not press ordinary Sync, retry the unresolved submission, enroll,
clear local data, edit the local database, run Neon mutations, change Render/Auth0 configuration or
create new synchronized purchase work.

After Codex:

1. reconcile the locally reproduced cause and validation evidence;
2. deploy only if the correction is specific, bounded and fully validated;
3. confirm harmless health correlation again;
4. record a fresh Neon baseline;
5. authorize at most one exact-identity retry only through a new Main gate.

Success terminal:

`C10_MCG02_SUBMISSION_500_CAUSE_CORRECTED`
