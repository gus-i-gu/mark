import type { ProofCaseResult } from "./producer.js";

export async function captureCase(
  action: () => Promise<void> | void,
  blocker = "scenario-failed",
): Promise<ProofCaseResult> {
  try {
    await action();
    return { passed: true };
  } catch {
    return { passed: false, blocker };
  }
}

export function emitProducer(name: string, record: unknown) {
  process.stdout.write(`PROOF_PRODUCER ${name} ${JSON.stringify(record)}\n`);
}
