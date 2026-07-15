import { spawn } from "node:child_process";
import { aggregateProofResults, parseProducerRecord } from "./aggregate.js";
import type { ProofProducerName, ProofProducerResult } from "./producer.js";

const producerScripts: readonly [ProofProducerName, string][] = [
  ["authorization-race", "src/proof/authorization_producer.ts"],
  ["migration-006-lifecycle-acl", "src/proof/migration_006_probe.ts"],
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
const allBlockers = [...blockers, ...aggregate.blockers].sort();
const deferredOnly =
  allBlockers.length > 0 &&
  allBlockers.every(
    (blocker) =>
      blocker.endsWith(":not-yet-r3d2") || blocker.endsWith(":not-yet-r3d3"),
  );
const requiredPassed = new Map(
  records.map((record) => [record.producer, record.passed]),
);
const pipelineIntegrity =
  blockers.length === 0 &&
  requiredPassed.get("migration-006-lifecycle-acl") === true &&
  requiredPassed.get("jwks-state-machine") === true &&
  requiredPassed.get("route-inventory") === true &&
  requiredPassed.get("static-regression") === true &&
  requiredPassed.get("authorization-race") === false &&
  requiredPassed.get("flutter-http-file-backed") === false &&
  aggregate.passed === false &&
  deferredOnly;

for (const blocker of allBlockers) {
  process.stdout.write(`BLOCKER=${blocker}\n`);
}
process.stdout.write(
  `MIGRATION_006_LIFECYCLE_ACL=${requiredPassed.get("migration-006-lifecycle-acl") === true}\n`,
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
process.stdout.write(`PROOF_PIPELINE_INTEGRITY=${pipelineIntegrity}\n`);
process.stdout.write("R3_LOCAL_SECURITY_PROVED=false\n");
if (pipelineIntegrity) {
  process.stdout.write("C10-S03A_R3D1_PROVED\n");
  process.stdout.write("R3D2_AUTHORIZATION_PENDING\n");
  process.stdout.write("R3D3_FLUTTER_PENDING\n");
  process.stdout.write("MCG-02_PROVIDER_PROOF_PENDING\n");
} else {
  process.stdout.write("C10-S03A_R3D1_PARTIAL\n");
  process.exitCode = 1;
}

function runProducer(script: string) {
  return new Promise<string>((resolve) => {
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
      resolve(Buffer.concat(chunks).toString("utf8"));
    }, 900000);
    child.on("error", () => {
      clearTimeout(timeout);
      resolve(Buffer.concat(chunks).toString("utf8"));
    });
    child.on("exit", () => {
      clearTimeout(timeout);
      resolve(Buffer.concat(chunks).toString("utf8"));
    });
  });
}
