import { spawn } from "node:child_process";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { makeProducerResult, type ProofCaseResult } from "./producer.js";
import { emitProducer } from "./scenario_result.js";

const proofDir = dirname(fileURLToPath(import.meta.url));
const repositoryRoot = resolve(proofDir, "../../../..");
const flutterRoot = resolve(repositoryRoot, "clients/markei_flutter");

const focusedPassed =
  (await run("flutter", [
    "test",
    "test/infrastructure/http_device_enrollment_transport_file_test.dart",
  ])) === 0;

const observed = focusedPassed
  ? true
  : { passed: false, blocker: "test-failed" };
const deferred: ProofCaseResult = { passed: false, blocker: "not-yet-r05" };

const producer = makeProducerResult(
  "flutter-http-file-backed",
  {
    "device-enrolled-applied": observed,
    "duplicate-equivalent-distinct": observed,
    "conflict-persists-facts-outbox": observed,
    "unavailable-persists-facts-outbox": observed,
    "close-reopen-preserves-state": observed,
    "normal-response-before-deadline": observed,
    "token-not-persisted-or-logged": deferred,
    "malformed-oversized-redirect-fail-closed": deferred,
    "response-loss-unknown-outcome": deferred,
    "query-replay-same-request-id": deferred,
    "stalled-headers-timeout": deferred,
    "slow-trickle-total-deadline": deferred,
    "owned-client-closed-on-timeout": deferred,
    "borrowed-client-preserved": deferred,
    "late-response-no-durable-mutation": deferred,
    "local-registration-while-api-unavailable": deferred,
  },
  "not-yet-r05",
);

emitProducer("flutter-http-file-backed", producer);
process.stdout.write("FLUTTER_HTTP_FILE_BACKED_PRODUCER=false\n");
process.exitCode = 1;

function run(command: string, args: readonly string[]) {
  return new Promise<number>((resolve) => {
    const child = spawn(command, [...args], {
      cwd: flutterRoot,
      shell: process.platform === "win32",
      stdio: "ignore",
      windowsHide: true,
    });
    const timeout = setTimeout(() => {
      child.kill();
      resolve(124);
    }, 180000);
    child.on("error", () => {
      clearTimeout(timeout);
      resolve(127);
    });
    child.on("exit", (code) => {
      clearTimeout(timeout);
      resolve(code ?? 1);
    });
  });
}
