import { spawn } from "node:child_process";
import { aggregateProofResults, parseProducerRecord } from "./aggregate.js";
import type { ProofProducerName, ProofProducerResult } from "./producer.js";

const producerScripts: readonly [ProofProducerName, string][] = [
  ["authorization-race", "src/proof/authorization_producer.ts"],
  ["migration-006-lifecycle-acl", "src/proof/migration_006_probe.ts"],
  [
    "migration-007-account-cursor-provisioning",
    "src/proof/migration_007_account_cursor_provisioning_probe.ts",
  ],
  ["jwks-state-machine", "src/proof/jwks_producer.ts"],
  ["route-inventory", "src/proof/route_inventory_producer.ts"],
  ["flutter-http-file-backed", "src/proof/flutter_producer.ts"],
  ["static-regression", "src/proof/static_regression_producer.ts"],
];

const records: ProofProducerResult[] = [];
const blockers: string[] = [];

for (const [producer, script] of producerScripts) {
  const output = await runProducer(script);
  const line = output
    .split(/\r?\n/u)
    .find((item) => item.startsWith(`PROOF_PRODUCER ${producer} `));
  if (!line) {
    blockers.push(`missing-producer-output:${producer}`);
    continue;
  }
  try {
    records.push(
      parseProducerRecord(
        JSON.parse(line.slice(`PROOF_PRODUCER ${producer} `.length)) as unknown,
      ),
    );
  } catch {
    blockers.push(`invalid-producer-output:${producer}`);
  }
}

const aggregate = aggregateProofResults(records);
const requiredPassed = new Map(
  records.map((record) => [record.producer, record.passed]),
);
const allTrue = producerScripts.every(
  ([producer]) => requiredPassed.get(producer) === true,
);
const pipelineIntegrity =
  blockers.length === 0 && allTrue && aggregate.passed === true;

for (const blocker of [...blockers, ...aggregate.blockers].sort()) {
  process.stdout.write(`BLOCKER=${blocker}\n`);
}
process.stdout.write(
  `MIGRATION_006_LIFECYCLE_ACL=${requiredPassed.get("migration-006-lifecycle-acl") === true}\n`,
);
process.stdout.write(
  `MIGRATION_007_ACCOUNT_CURSOR_PROVISIONING=${requiredPassed.get("migration-007-account-cursor-provisioning") === true}\n`,
);
process.stdout.write(
  `JWKS_STATE_MACHINE_PRODUCER=${requiredPassed.get("jwks-state-machine") === true}\n`,
);
process.stdout.write(
  `ROUTE_INVENTORY_PRODUCER=${requiredPassed.get("route-inventory") === true}\n`,
);
process.stdout.write(
  `STATIC_REGRESSION_PRODUCER=${requiredPassed.get("static-regression") === true}\n`,
);
process.stdout.write(
  `AUTHORIZATION_RACE_PRODUCER=${requiredPassed.get("authorization-race") === true}\n`,
);
process.stdout.write(
  `FLUTTER_HTTP_FILE_BACKED_PRODUCER=${requiredPassed.get("flutter-http-file-backed") === true}\n`,
);
process.stdout.write(`PROOF_PIPELINE_INTEGRITY=${pipelineIntegrity}\n`);
process.stdout.write(`R3_LOCAL_SECURITY_PROVED=${pipelineIntegrity}\n`);
if (pipelineIntegrity) {
  process.stdout.write("C10-MCG02-R05_FLUTTER_PROVED\n");
  process.stdout.write("MCG-02_PROVIDER_PROOF_PENDING\n");
  process.stdout.write("CYCLE_10_PRUNING_AND_PROMOTION_PENDING\n");
} else {
  process.stdout.write("C10-MCG02-R05_PARTIAL\n");
  process.exitCode = 1;
}

function runProducer(script: string) {
  return new Promise<string>((resolveOutput) => {
    const child = spawn("npm", ["exec", "tsx", "--", script], {
      cwd: process.cwd(),
      shell: process.platform === "win32",
      stdio: ["ignore", "pipe", "ignore"],
      windowsHide: true,
    });
    const chunks: Buffer[] = [];
    child.stdout.on("data", (chunk: Buffer) => chunks.push(chunk));
    const timeout = setTimeout(() => {
      child.kill();
      resolveOutput(Buffer.concat(chunks).toString("utf8"));
    }, 1200000);
    child.on("error", () => {
      clearTimeout(timeout);
      resolveOutput(Buffer.concat(chunks).toString("utf8"));
    });
    child.on("exit", () => {
      clearTimeout(timeout);
      resolveOutput(Buffer.concat(chunks).toString("utf8"));
    });
  });
}
