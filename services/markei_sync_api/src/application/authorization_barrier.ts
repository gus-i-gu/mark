export const AUTHORIZATION_BARRIER_PHASES = [
  "before-identity-membership-fence",
  "after-membership-lock",
  "before-actor-device-lock",
  "before-target-transition",
  "before-protected-mutation",
  "before-commit",
] as const;

export type AuthorizationBarrierPhase =
  (typeof AUTHORIZATION_BARRIER_PHASES)[number];

export type AuthorizationBarrierContext = {
  operation: string;
  scenario?: string;
  participant?: string;
  accountId?: string;
  identityId?: string;
  actorDeviceId?: string;
  targetDeviceId?: string;
};

export type AuthorizationBarrier = {
  reach(
    phase: AuthorizationBarrierPhase,
    context: AuthorizationBarrierContext,
  ): Promise<void>;
};

export const noopAuthorizationBarrier: AuthorizationBarrier = {
  reach: async () => undefined,
};
