import type { FastifyRequest } from "fastify";

export type Clock = { now(): Date };

export const systemClock: Clock = { now: () => new Date() };

export type ExternalPrincipal = {
  issuer: string;
  subject: string;
  audience: string;
  expiresAt: Date;
};

export type Membership = {
  accountId: string;
  identityId: string;
  role: "owner" | "member";
};

export type HostedFailureCode =
  | "authentication-required"
  | "token-rejected"
  | "membership-required"
  | "account-selection-required"
  | "device-enrollment-required"
  | "device-revoked"
  | "forbidden"
  | "conflict"
  | "rate-limited"
  | "service-unavailable";

export class HostedAuthError extends Error {
  constructor(
    readonly code: HostedFailureCode,
    readonly statusCode = 401,
  ) {
    super(code);
  }
}

export type PrincipalVerifier = {
  verify(request: FastifyRequest): Promise<ExternalPrincipal>;
};

export type EnrollmentRequest = {
  contractVersion: 1;
  installationId: string;
  enrollmentRequestId: string;
  platform: "android" | "windows" | "test";
  applicationId: string;
  applicationVersion: string;
};

export type DeviceEnrollmentResult = {
  contractVersion: 1;
  status: "device-enrolled" | "duplicate-equivalent";
  accountId: string;
  installationId: string;
  deviceId: string;
  generation: number;
};

export type IdentityResult = {
  contractVersion: 1;
  state:
    | "token-accepted"
    | "membership-confirmed"
    | "account-selection-required"
    | "membership-required";
  accountId?: string;
  identityId?: string;
  role?: "owner" | "member";
};
