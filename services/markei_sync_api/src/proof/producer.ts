export type ProofProducerName =
  | "authorization-race"
  | "migration-006-lifecycle-acl"
  | "jwks-state-machine"
  | "route-inventory"
  | "flutter-http-file-backed"
  | "static-regression";

export type ProofCaseResult = {
  passed: boolean;
  blocker?: string;
};

export type ProofProducerResult = {
  schemaVersion: 1;
  producer: ProofProducerName;
  requiredCases: readonly string[];
  resultsByCase: Record<string, ProofCaseResult>;
  blockers: readonly string[];
  passed: boolean;
};

export const REQUIRED_PROOF_CASES: Record<
  ProofProducerName,
  readonly string[]
> = {
  "authorization-race": [
    "membership-disabled-before-fence",
    "membership-removed-before-fence",
    "external-identity-disabled-before-mutation",
    "actor-device-revoked-before-upload",
    "actor-device-revoked-before-download",
    "actor-device-revoked-before-acknowledgement",
    "actor-device-revoked-before-capabilities",
    "actor-device-revoked-before-rebootstrap-start",
    "actor-device-revoked-before-rebootstrap-status",
    "actor-device-revoked-before-rebootstrap-chunk",
    "actor-device-revoked-before-rebootstrap-complete",
    "actor-device-revoked-before-device-status",
    "actor-device-revoked-before-device-revoke",
    "owner-target-status",
    "owner-target-revoke",
    "member-self-status",
    "member-self-revoke",
    "foreign-target-denial",
    "cross-account-target-denial",
    "concurrent-target-revoke-one-transition-one-event",
    "independent-repeat-revoke-duplicate-equivalent",
    "self-revoked-actor-denied-later",
    "equivalent-concurrent-enrollment",
    "conflicting-enrollment-request-hash",
    "response-loss-query-replay",
    "process-restart-replay",
    "serialization-retry-exhaustion-fails-closed",
    "denied-no-state-advance",
  ],
  "migration-006-lifecycle-acl": [
    "fresh-001-to-006",
    "upgrade-001-to-005-then-006",
    "duplicate-006-one-ledger-row",
    "failure-copy-only",
    "failure-rollback-ledger-function-acl",
    "canonical-migration-hashes-unchanged",
    "exact-ledger-identity-checksum",
    "no-argument-readiness-function",
    "function-owner-is-migrator",
    "security-definer",
    "stable-function",
    "fixed-safe-search-path",
    "qualified-ledger-reference",
    "no-dynamic-sql",
    "public-execute-denied",
    "runtime-can-execute-readiness",
    "no-unintended-runtime-function-capability",
    "runtime-old-probe-denied",
    "runtime-direct-ledger-denied",
    "runtime-ddl-denied",
    "runtime-role-admin-denied",
    "migrator-owner-authority",
    "hostile-shadowing-resistant",
    "absent-ledger-not-ready",
    "tampered-ledger-not-ready",
  ],
  "jwks-state-machine": [
    "expired-cache-miss-fetches-once",
    "changed-set-missing-key-installs-cooldown",
    "irrelevant-metadata-preserves-revision",
    "changed-public-key-rotates-revision",
    "key-membership-change-rotates-revision",
    "concurrent-same-key-misses-coalesce",
    "distinct-unknown-key-pressure-bounded",
    "outage-cooldown-and-later-retry",
    "stale-known-key-boundary-and-expiry",
    "malformed-duplicate-private-non-rs256-rejection",
  ],
  "route-inventory": [
    "valid-current-inventory",
    "late-direct-route-rejected",
    "encapsulated-plugin-route-rejected",
    "missing-descriptor-rejected",
    "duplicate-route-rejected",
    "wrong-operation-or-classification-rejected",
  ],
  "flutter-http-file-backed": [
    "device-enrolled-applied",
    "duplicate-equivalent-distinct",
    "conflict-persists-facts-outbox",
    "unavailable-persists-facts-outbox",
    "malformed-oversized-redirect-fail-closed",
    "response-loss-unknown-outcome",
    "query-replay-same-request-id",
    "close-reopen-preserves-state",
    "normal-response-before-deadline",
    "stalled-headers-timeout",
    "slow-trickle-total-deadline",
    "owned-client-closed-on-timeout",
    "borrowed-client-preserved",
    "late-response-no-durable-mutation",
    "local-registration-while-api-unavailable",
    "token-not-persisted-or-logged",
  ],
  "static-regression": [
    "server-format",
    "server-lint",
    "server-typecheck",
    "server-tests",
    "server-build",
    "server-audit-production",
    "dart-format",
    "flutter-analyze",
    "flutter-tests",
    "android-debug-build",
    "windows-release-build",
    "python-regressions",
    "git-diff-check",
    "secret-scan",
    "resource-teardown",
  ],
};

export const PRODUCER_FIELDS = [
  "schemaVersion",
  "producer",
  "requiredCases",
  "resultsByCase",
  "blockers",
  "passed",
] as const;

export const CASE_RESULT_FIELDS = ["passed", "blocker"] as const;

export function makeProducerResult(
  producer: ProofProducerName,
  resultsByCase: Partial<Record<string, boolean | ProofCaseResult>>,
  defaultBlocker = "missing-case-result",
): ProofProducerResult {
  const requiredCases = [...REQUIRED_PROOF_CASES[producer]];
  const normalized: Record<string, ProofCaseResult> = {};
  for (const caseId of requiredCases) {
    const value = resultsByCase[caseId];
    const result =
      typeof value === "boolean"
        ? { passed: value }
        : (value ?? { passed: false, blocker: defaultBlocker });
    normalized[caseId] = result.passed
      ? { passed: true }
      : { passed: false, blocker: safeBlocker(result.blocker) };
  }
  const blockers = deriveBlockers(normalized);
  return {
    schemaVersion: 1,
    producer,
    requiredCases,
    resultsByCase: normalized,
    blockers,
    passed: blockers.length === 0,
  };
}

export function deriveBlockers(resultsByCase: Record<string, ProofCaseResult>) {
  return Object.entries(resultsByCase)
    .filter(([, result]) => !result.passed)
    .map(([caseId, result]) => `${caseId}:${safeBlocker(result.blocker)}`)
    .sort();
}

export function safeBlocker(value: unknown): string {
  if (typeof value === "string" && isSafeIdentifier(value)) return value;
  return "case-failed";
}

export function isSafeIdentifier(value: string): boolean {
  return /^[a-z0-9][a-z0-9-]{0,95}$/.test(value);
}

export function proofProducerNames(): ProofProducerName[] {
  return Object.keys(REQUIRED_PROOF_CASES) as ProofProducerName[];
}

export function canonicalProducerJson(record: ProofProducerResult): string {
  return `${JSON.stringify(
    {
      schemaVersion: record.schemaVersion,
      producer: record.producer,
      requiredCases: record.requiredCases,
      resultsByCase: Object.fromEntries(
        Object.entries(record.resultsByCase).map(([caseId, result]) => [
          caseId,
          result.passed
            ? { passed: true }
            : { passed: false, blocker: safeBlocker(result.blocker) },
        ]),
      ),
      blockers: record.blockers,
      passed: record.passed,
    },
    null,
    2,
  )}\n`;
}
