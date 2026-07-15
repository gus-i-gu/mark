import { readFileSync } from "node:fs";
import {
  CASE_RESULT_FIELDS,
  deriveBlockers,
  PRODUCER_FIELDS,
  proofProducerNames,
  REQUIRED_PROOF_CASES,
  type ProofCaseResult,
  type ProofProducerName,
  type ProofProducerResult,
} from "./producer.js";

type AggregationResult = {
  passed: boolean;
  blockers: string[];
};

export function aggregateProofResults(
  records: readonly unknown[],
): AggregationResult {
  const blockers: string[] = [];
  const byProducer = new Map<ProofProducerName, ProofProducerResult>();
  for (const record of records) {
    const parsed = parseRecord(record, blockers);
    if (!parsed) continue;
    if (byProducer.has(parsed.producer)) {
      blockers.push(`duplicate-producer:${parsed.producer}`);
      continue;
    }
    byProducer.set(parsed.producer, parsed);
  }
  for (const producer of proofProducerNames()) {
    const record = byProducer.get(producer);
    if (!record) {
      blockers.push(`missing-producer:${producer}`);
      continue;
    }
    validateCases(record, blockers, true);
  }
  return { passed: blockers.length === 0, blockers: uniqueSorted(blockers) };
}

export function parseProducerRecord(value: unknown): ProofProducerResult {
  const blockers: string[] = [];
  const parsed = parseRecord(value, blockers);
  if (!parsed) throw new Error(blockers[0] ?? "malformed-record");
  validateCases(parsed, blockers, false);
  if (blockers.length > 0) throw new Error(blockers[0]);
  return parsed;
}

function parseRecord(
  value: unknown,
  blockers: string[],
): ProofProducerResult | null {
  if (!plainObject(value)) {
    blockers.push("malformed-record");
    return null;
  }
  if (!exactKeys(value, PRODUCER_FIELDS)) {
    blockers.push("unknown-or-missing-record-field");
    return null;
  }
  const record = value as Partial<ProofProducerResult>;
  if (
    record.schemaVersion !== 1 ||
    typeof record.producer !== "string" ||
    !(record.producer in REQUIRED_PROOF_CASES) ||
    !Array.isArray(record.requiredCases) ||
    !Array.isArray(record.blockers) ||
    !plainObject(record.resultsByCase) ||
    typeof record.passed !== "boolean"
  ) {
    blockers.push("malformed-record");
    return null;
  }
  if (
    !record.requiredCases.every((item) => typeof item === "string") ||
    !record.blockers.every((item) => typeof item === "string")
  ) {
    blockers.push("malformed-record");
    return null;
  }
  return record as ProofProducerResult;
}

function validateCases(
  record: ProofProducerResult,
  blockers: string[],
  includeRecordBlockers: boolean,
) {
  const expected = [...REQUIRED_PROOF_CASES[record.producer]];
  if (!sameOrderedUnique(expected, record.requiredCases)) {
    blockers.push(`case-set-mismatch:${record.producer}`);
  }
  const resultKeys = Object.keys(record.resultsByCase);
  if (!sameOrderedUnique(expected, resultKeys)) {
    blockers.push(`case-results-mismatch:${record.producer}`);
  }
  const normalized: Record<string, ProofCaseResult> = {};
  for (const caseId of expected) {
    const result = record.resultsByCase[caseId];
    if (!plainObject(result) || !exactKeys(result, CASE_RESULT_FIELDS, true)) {
      blockers.push(`malformed-case:${record.producer}:${caseId}`);
      continue;
    }
    if (typeof result.passed !== "boolean") {
      blockers.push(`malformed-case:${record.producer}:${caseId}`);
      continue;
    }
    if (result.passed) {
      if ("blocker" in result) {
        blockers.push(`stale-case-blocker:${record.producer}:${caseId}`);
      }
      normalized[caseId] = { passed: true };
      continue;
    }
    if (typeof result.blocker !== "string" || !safeIdentifier(result.blocker)) {
      blockers.push(`unsafe-case-blocker:${record.producer}:${caseId}`);
      normalized[caseId] = { passed: false, blocker: "case-failed" };
      continue;
    }
    normalized[caseId] = { passed: false, blocker: result.blocker };
  }
  const expectedBlockers = deriveBlockers(normalized);
  if (
    !sameOrderedUnique(expectedBlockers, record.blockers) ||
    record.blockers.some((item) => !safeBlockerEntry(item))
  ) {
    blockers.push(`blocker-mismatch:${record.producer}`);
  }
  const expectedPassed = expectedBlockers.length === 0;
  if (record.passed !== expectedPassed) {
    blockers.push(`passed-mismatch:${record.producer}`);
  }
  if (includeRecordBlockers) blockers.push(...record.blockers);
}

function plainObject(value: unknown): value is Record<string, unknown> {
  return (
    !!value &&
    typeof value === "object" &&
    !Array.isArray(value) &&
    Object.getPrototypeOf(value) === Object.prototype
  );
}

function exactKeys(
  value: Record<string, unknown>,
  keys: readonly string[],
  optionalLast = false,
) {
  const actual = Object.keys(value).sort();
  const allowed = optionalLast ? keys : [...keys];
  const required = optionalLast ? keys.slice(0, -1) : keys;
  return (
    required.every((key) => key in value) &&
    actual.every((key) => allowed.includes(key))
  );
}

function sameOrderedUnique(left: readonly string[], right: readonly string[]) {
  return (
    left.length === right.length &&
    new Set(left).size === left.length &&
    left.every((item, index) => item === right[index])
  );
}

function safeIdentifier(value: string) {
  return /^[a-z0-9][a-z0-9-]{0,95}$/.test(value);
}

function safeBlockerEntry(value: string) {
  return /^[a-z0-9][a-z0-9-]{0,95}:[a-z0-9][a-z0-9-]{0,95}$/.test(value);
}

function uniqueSorted(values: string[]) {
  return [...new Set(values)].sort();
}

function readRecord(path: string): unknown {
  try {
    return JSON.parse(readFileSync(path, "utf8")) as unknown;
  } catch {
    return {
      schemaVersion: 0,
      producer: "malformed",
      requiredCases: [],
      resultsByCase: {},
      blockers: [],
      passed: false,
    };
  }
}

if (process.argv[1]?.endsWith("aggregate.ts")) {
  const records = process.argv.slice(2).map(readRecord);
  const result = aggregateProofResults(records);
  for (const blocker of result.blockers) {
    process.stdout.write(`BLOCKER=${blocker}\n`);
  }
  process.stdout.write(`R3_LOCAL_SECURITY_PROVED=${result.passed}\n`);
  if (!result.passed) process.exitCode = 1;
}
