# I_DSN_CODEX - Hosted Device Header Design

> Unit: C10-MCG02-HOSTED-DEVICE-HEADER-CORRECTION_20260721T124452Z
> Result: HOSTED_DEVICE_HEADER_ALL_PROTECTED_ROUTES=true

## Final Dependency Direction

Hosted Sync keeps the existing dependency direction:

```text
MarkeiComposition
  -> HostedSyncCoordinator
  -> Sync use cases
  -> HttpSyncTransport
  -> hosted Sync API
```

The production composition is responsible for supplying `activeBinding.serverDeviceId`. The transport is responsible for applying that identity to every protected HTTP request.

## Transport Boundary

`HttpSyncTransport` now requires `hostedDeviceId`. The value is stored once and attached by the common protected-request path so upload, download, acknowledgement, and recovery methods share the same header behavior.

Protected methods covered by the invariant:

- `uploadSubmission`
- `downloadAfter`
- `acknowledge`
- `startRecovery`
- `queryRecovery`
- `downloadChunk`
- `completeRecovery`

Authentication, correlation ID generation, timeout handling, JSON content negotiation, request body serialization, response decoding, and recognized protocol-code handling remain inside the same transport boundary.

## Composition Boundary

Native hosted composition now reads the active binding before constructing the transport. With a binding, it passes `activeBinding.serverDeviceId`. Without a binding, it fails closed through the existing hosted guard path and does not create a usable HTTP transport with missing or synthetic Device identity.

No UI or coordinator submission-ID surface was added.

## Fixture Boundary

The native-closure hosted fixture now models the provider fence for protected routes by rejecting missing or incorrect `x-markei-device-id` with:

```text
device-enrollment-required
```

The fixture increments no upload/download/acknowledgement counters for rejected requests, preserving a clear pre-transport authorization boundary.

## Preservation Guarantees

This correction does not modify:

- Drift schema version or migrations;
- PostgreSQL migrations;
- event versions;
- EventId, AccountId, DeviceId, Device sequence, payload, occurrence time, or content hash;
- ordered outbox selection and hydration rules;
- failed/notApplied recovery representation;
- server transaction behavior;
- hosted Account/Device binding records;
- cursor or acknowledgement state.

## Deviations And Remaining Work

`dart format` completed on the changed Dart files. The stricter `--set-exit-if-changed` check repeatedly reported line-ending normalization on four files after formatting; analysis, focused tests, full tests, and platform builds were stable.

The Windows provider retest was intentionally not performed. No provider acceptance is claimed by this commit.
