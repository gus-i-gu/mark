import assert from "node:assert/strict";
import test from "node:test";
import { aggregateProofResults } from "../src/proof/aggregate.js";
import {
  makeProducerResult,
  REQUIRED_PROOF_CASES,
  type ProofProducerName,
} from "../src/proof/producer.js";
import { evaluateResourceTeardown } from "../src/proof/static_regression_support.js";

test("proof aggregator accepts a complete producer set", () => {
  const records = allProducerNames().map((producer) =>
    makeProducerResult(producer, allPassed(producer)),
  );

  assert.deepEqual(aggregateProofResults(records), {
    passed: true,
    blockers: [],
  });
});

test("proof aggregator rejects missing and duplicate producers", () => {
  const complete = completeRecords();

  assertBlocker(aggregateProofResults(complete.slice(1)), "missing-producer:");
  assertBlocker(
    aggregateProofResults([complete[0], ...complete]),
    "duplicate-producer:",
  );
});

test("proof aggregator rejects malformed records and unknown fields", () => {
  const complete = completeRecords();
  assertBlocker(
    aggregateProofResults([{}, ...complete.slice(1)]),
    "unknown-or-missing-record-field",
  );
  assertBlocker(
    aggregateProofResults([
      { ...complete[0], extra: true },
      ...complete.slice(1),
    ]),
    "unknown-or-missing-record-field",
  );
});

test("proof aggregator rejects incomplete, duplicate and unknown case sets", () => {
  const complete = completeRecords();
  const route = complete.find(
    (record) => record.producer === "route-inventory",
  )!;
  assertBlocker(
    aggregateProofResults([
      { ...route, requiredCases: ["valid-current-inventory"] },
      ...complete.filter((record) => record.producer !== "route-inventory"),
    ]),
    "case-set-mismatch:route-inventory",
  );
  assertBlocker(
    aggregateProofResults([
      {
        ...route,
        resultsByCase: {
          ...route.resultsByCase,
          "unexpected-case": { passed: true },
        },
      },
      ...complete.filter((record) => record.producer !== "route-inventory"),
    ]),
    "case-results-mismatch:route-inventory",
  );
});

test("proof aggregator rejects unknown case result fields and stale blockers", () => {
  const complete = completeRecords();
  const record = complete[0];
  const caseId = record.requiredCases[0];
  assertBlocker(
    aggregateProofResults([
      {
        ...record,
        resultsByCase: {
          ...record.resultsByCase,
          [caseId]: { passed: true, blocker: "stale" },
        },
      },
      ...complete.slice(1),
    ]),
    "stale-case-blocker:",
  );
  assertBlocker(
    aggregateProofResults([
      {
        ...record,
        resultsByCase: {
          ...record.resultsByCase,
          [caseId]: { passed: true, extra: true },
        },
      },
      ...complete.slice(1),
    ]),
    "malformed-case:",
  );
});

test("proof aggregator rejects inconsistent passed and blocker fields", () => {
  const complete = completeRecords();
  const falseRecord = makeProducerResult("authorization-race", {
    ...allPassed("authorization-race"),
    "denied-no-state-advance": {
      passed: false,
      blocker: "not-yet-r3d2",
    },
  });
  assertBlocker(
    aggregateProofResults([falseRecord, ...complete.slice(1)]),
    "denied-no-state-advance:not-yet-r3d2",
  );
  assertBlocker(
    aggregateProofResults([
      { ...falseRecord, passed: true },
      ...complete.slice(1),
    ]),
    "passed-mismatch:authorization-race",
  );
  assertBlocker(
    aggregateProofResults([
      { ...complete[0], passed: false },
      ...complete.slice(1),
    ]),
    "passed-mismatch:",
  );
  assertBlocker(
    aggregateProofResults([
      { ...falseRecord, blockers: [] },
      ...complete.slice(1),
    ]),
    "blocker-mismatch:authorization-race",
  );
});

test("proof aggregator treats skipped partial and unavailable as false evidence", () => {
  const complete = completeRecords();
  for (const blocker of ["skipped", "partial", "unavailable"]) {
    const record = makeProducerResult("static-regression", {
      ...allPassed("static-regression"),
      "server-tests": { passed: false, blocker },
    });
    const result = aggregateProofResults([
      record,
      ...complete.filter((item) => item.producer !== "static-regression"),
    ]);
    assert.equal(result.passed, false);
    assert(result.blockers.includes(`server-tests:${blocker}`));
  }
});

test("static teardown rejects successful non-empty disposable inventory", () => {
  assert.equal(evaluateResourceTeardown(0, ""), true);
  assert.equal(evaluateResourceTeardown(0, "markei-c10-s03a-r04-pg\n"), false);
  assert.equal(evaluateResourceTeardown(1, ""), false);
});

function completeRecords() {
  return allProducerNames().map((producer) =>
    makeProducerResult(producer, allPassed(producer)),
  );
}

function allProducerNames(): ProofProducerName[] {
  return Object.keys(REQUIRED_PROOF_CASES) as ProofProducerName[];
}

function allPassed(producer: ProofProducerName) {
  return Object.fromEntries(
    REQUIRED_PROOF_CASES[producer].map((caseId) => [caseId, true]),
  );
}

function assertBlocker(
  result: ReturnType<typeof aggregateProofResults>,
  expected: string,
) {
  assert.equal(result.passed, false);
  assert(result.blockers.some((item) => item.startsWith(expected)));
}
