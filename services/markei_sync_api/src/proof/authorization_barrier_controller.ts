import {
  AUTHORIZATION_BARRIER_PHASES,
  type AuthorizationBarrier,
  type AuthorizationBarrierContext,
  type AuthorizationBarrierPhase,
} from "../application/authorization_barrier.js";

export type BarrierParticipantKey = {
  scenario: string;
  participant: string;
  phase: AuthorizationBarrierPhase;
};

type ExpectedReach = {
  reached?: AuthorizationBarrierContext;
  released: boolean;
  waiters: Array<(context: AuthorizationBarrierContext) => void>;
  waiterRejects: Array<(error: Error) => void>;
  releaseWaiters: Array<() => void>;
  releaseRejects: Array<(error: Error) => void>;
};

const phases = new Set<string>(AUTHORIZATION_BARRIER_PHASES);

export class AuthorizationBarrierController implements AuthorizationBarrier {
  private readonly expected = new Map<string, ExpectedReach>();
  private closed = false;

  constructor(
    keys: BarrierParticipantKey[],
    private readonly timeoutMs = 5000,
  ) {
    for (const key of keys) {
      this.assertPhase(key.phase);
      this.assertSafeKey(key.scenario);
      this.assertSafeKey(key.participant);
      this.expected.set(this.key(key.scenario, key.participant, key.phase), {
        released: false,
        waiters: [],
        waiterRejects: [],
        releaseWaiters: [],
        releaseRejects: [],
      });
    }
  }

  async reach(
    phase: AuthorizationBarrierPhase,
    context: AuthorizationBarrierContext,
  ): Promise<void> {
    this.assertOpen();
    this.assertPhase(phase);
    if (!context.scenario || !context.participant) return;
    const entry = this.required(context.scenario, context.participant, phase);
    this.assertSafeContext(context);
    entry.reached = { ...context };
    for (const waiter of entry.waiters.splice(0)) waiter(entry.reached);
    entry.waiterRejects.splice(0);
    if (entry.released) return;
    await this.withTimeout(
      new Promise<void>((resolve, reject) => {
        entry.releaseWaiters.push(resolve);
        entry.releaseRejects.push(reject);
      }),
      `barrier-release-timeout-${phase}`,
    );
  }

  async waitUntilReached(
    scenario: string,
    participant: string,
    phase: AuthorizationBarrierPhase,
  ): Promise<AuthorizationBarrierContext> {
    this.assertOpen();
    this.assertPhase(phase);
    const entry = this.required(scenario, participant, phase);
    if (entry.reached) return entry.reached;
    return this.withTimeout(
      new Promise<AuthorizationBarrierContext>((resolve, reject) => {
        entry.waiters.push(resolve);
        entry.waiterRejects.push(reject);
      }),
      `barrier-reach-timeout-${phase}`,
    );
  }

  release(
    scenario: string,
    participant: string,
    phase: AuthorizationBarrierPhase,
  ): void {
    this.assertOpen();
    this.assertPhase(phase);
    const entry = this.required(scenario, participant, phase);
    entry.released = true;
    for (const waiter of entry.releaseWaiters.splice(0)) waiter();
    entry.releaseRejects.splice(0);
  }

  close(): void {
    if (this.closed) return;
    this.closed = true;
    const error = new Error("authorization barrier controller closed");
    for (const entry of this.expected.values()) {
      for (const reject of entry.waiterRejects.splice(0)) reject(error);
      for (const reject of entry.releaseRejects.splice(0)) reject(error);
      entry.waiters.splice(0);
      entry.releaseWaiters.splice(0);
    }
  }

  private required(
    scenario: string,
    participant: string,
    phase: AuthorizationBarrierPhase,
  ): ExpectedReach {
    this.assertSafeKey(scenario);
    this.assertSafeKey(participant);
    const entry = this.expected.get(this.key(scenario, participant, phase));
    if (!entry) throw new Error("unknown authorization barrier participant");
    return entry;
  }

  private key(
    scenario: string,
    participant: string,
    phase: AuthorizationBarrierPhase,
  ) {
    return `${scenario}:${participant}:${phase}`;
  }

  private assertOpen() {
    if (this.closed) throw new Error("authorization barrier controller closed");
  }

  private assertPhase(phase: string) {
    if (!phases.has(phase))
      throw new Error("unknown authorization barrier phase");
  }

  private assertSafeKey(value: string) {
    if (!/^[a-z0-9][a-z0-9-]{0,95}$/.test(value)) {
      throw new Error("unsafe authorization barrier key");
    }
  }

  private assertSafeContext(context: AuthorizationBarrierContext) {
    for (const [key, value] of Object.entries(context)) {
      if (
        ![
          "operation",
          "scenario",
          "participant",
          "accountId",
          "identityId",
          "actorDeviceId",
          "targetDeviceId",
        ].includes(key)
      ) {
        throw new Error("unsafe authorization barrier context");
      }
      if (value !== undefined && typeof value !== "string") {
        throw new Error("unsafe authorization barrier context");
      }
    }
  }

  private async withTimeout<T>(promise: Promise<T>, message: string) {
    let timeout: NodeJS.Timeout | undefined;
    try {
      return await Promise.race([
        promise,
        new Promise<T>((_resolve, reject) => {
          timeout = setTimeout(
            () => reject(new Error(message)),
            this.timeoutMs,
          );
        }),
      ]);
    } finally {
      if (timeout) clearTimeout(timeout);
    }
  }
}
