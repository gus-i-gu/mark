import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/app/native_auth_closure_runner.dart';
import 'package:markei/app/pages/native_closure_page.dart';
import 'package:markei/application/closure_diagnostics.dart';
import 'package:markei/application/hosted_auth_ports.dart';
import 'package:markei/application/hosted_connection_check.dart';
import 'package:markei/application/hosted_enrollment_coordinator.dart';
import 'package:markei/application/hosted_sync_coordinator.dart';
import 'package:markei/application/sync/sync_ports.dart';
import 'package:markei/application/sync/sync_use_cases.dart';
import 'package:markei/domain/sync/sync_event.dart';

void main() {
  testWidgets('Closure renders signed-out empty diagnostics', (tester) async {
    tester.view.physicalSize = const Size(1400, 2200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final query = _FakeDiagnosticsQuery();
    final runner = _runner(query: query, signedIn: false);

    await tester.pumpWidget(
      MaterialApp(home: NativeClosurePage(runner: runner)),
    );
    await tester.pumpAndSettle();

    expect(find.text('signed-out'), findsOneWidget);
    expect(find.text('device-enrolled'), findsOneWidget);
    expect(find.text('No locally recorded attempt history'), findsOneWidget);
    expect(find.text('No pending, failed or unknown events'), findsOneWidget);
  });

  testWidgets('Closure renders enrolled pending failed unknown and history', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 2600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final query = _FakeDiagnosticsQuery(populated: true);
    final runner = _runner(query: query);

    await tester.pumpWidget(
      MaterialApp(home: NativeClosurePage(runner: runner)),
    );
    await tester.pumpAndSettle();

    expect(find.text('authenticated'), findsOneWidget);
    expect(find.text('failed-work-needs-review'), findsOneWidget);
    expect(find.text('sync: sync-interrupted #attempt1'), findsOneWidget);
    expect(find.text('purchase.registered.v3 #event1'), findsOneWidget);
    expect(find.text('Current #device1'), findsOneWidget);
  });

  testWidgets('Refresh diagnostics is local only and does not invoke Sync', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 2200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final query = _FakeDiagnosticsQuery();
    final runner = _runner(query: query);

    await tester.pumpWidget(
      MaterialApp(home: NativeClosurePage(runner: runner)),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.byKey(const Key('nativeClosure.Refresh diagnostics')),
    );
    await tester.tap(
      find.byKey(const Key('nativeClosure.Refresh diagnostics')),
    );
    await tester.pumpAndSettle();

    expect(query.snapshots, 2);
    expect(query.beginAttempts, 0);
  });

  testWidgets('Check hosted connection records one non-Sync attempt', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 2200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final query = _FakeDiagnosticsQuery();
    final hostedConnection = _FakeHostedConnectionCheck();
    final runner = _runner(
      query: query,
      hostedConnectionCheck: hostedConnection,
      outbox: _UploadingOutbox(),
    );

    await tester.pumpWidget(
      MaterialApp(home: NativeClosurePage(runner: runner)),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.byKey(const Key('nativeClosure.Check hosted connection')),
    );
    await tester.tap(
      find.byKey(const Key('nativeClosure.Check hosted connection')),
    );
    await tester.pumpAndSettle();

    expect(find.text('hosted-connection-ready'), findsOneWidget);
    expect(hostedConnection.checks, 1);
    expect(query.beginAttempts, 0);
    expect(query.beginDiagnosticAttempts, 1);
    expect(query.completedResults, ['hosted-connection-ready']);
    expect(
      query.completedDiagnosticAttempts.single.latestStage,
      'response-parsed',
    );
    expect(query.snapshots, greaterThanOrEqualTo(2));
  });

  testWidgets('Clear diagnostic history is confirmed and scoped to attempts', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 2200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final query = _FakeDiagnosticsQuery(populated: true);
    final runner = _runner(query: query);

    await tester.pumpWidget(
      MaterialApp(home: NativeClosurePage(runner: runner)),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.byKey(const Key('nativeClosure.Clear diagnostic history')),
    );
    await tester.tap(
      find.byKey(const Key('nativeClosure.Clear diagnostic history')),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('nativeClosure.clear.confirm')));
    await tester.pumpAndSettle();

    expect(query.cleared, isTrue);
    expect(find.text('diagnostic-history-cleared'), findsOneWidget);
  });

  testWidgets('Retry unresolved submission cancellation does not start Sync', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 2200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final query = _FakeDiagnosticsQuery(
      populated: true,
      unknownPreflight: const UnknownSubmissionRetryPreflight.eligible(
        submissionFingerprint: 'subm1234',
        eventCount: 2,
        firstDeviceSequence: 1,
        lastDeviceSequence: 2,
        nextLocalDeviceSequence: 3,
      ),
    );
    final runner = _runner(query: query, outbox: _UploadingOutbox());

    await tester.pumpWidget(
      MaterialApp(home: NativeClosurePage(runner: runner)),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.byKey(const Key('nativeClosure.Retry unresolved submission')),
    );
    await tester.tap(
      find.byKey(const Key('nativeClosure.Retry unresolved submission')),
    );
    await tester.pumpAndSettle();

    expect(
      find.byKey(const Key('nativeClosure.retry.guidance')),
      findsOneWidget,
    );
    expect(find.textContaining('Events 1-2'), findsOneWidget);
    expect(find.textContaining('#subm1234'), findsOneWidget);
    expect(find.textContaining('Hosted outcome is unresolved'), findsOneWidget);

    await tester.tap(find.text('Cancel').last);
    await tester.pumpAndSettle();

    expect(find.text('unknown-retry-cancelled'), findsOneWidget);
    expect(query.beginAttempts, 0);
  });

  testWidgets(
    'Retry unresolved submission confirms and refreshes diagnostics',
    (tester) async {
      tester.view.physicalSize = const Size(1400, 2200);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final query = _FakeDiagnosticsQuery(
        populated: true,
        unknownPreflight: const UnknownSubmissionRetryPreflight.eligible(
          submissionFingerprint: 'subm1234',
          eventCount: 2,
          firstDeviceSequence: 1,
          lastDeviceSequence: 2,
          nextLocalDeviceSequence: 3,
        ),
      );
      final runner = _runner(query: query, outbox: _UploadingOutbox());

      await tester.pumpWidget(
        MaterialApp(home: NativeClosurePage(runner: runner)),
      );
      await tester.pumpAndSettle();
      await tester.ensureVisible(
        find.byKey(const Key('nativeClosure.Retry unresolved submission')),
      );
      await tester.tap(
        find.byKey(const Key('nativeClosure.Retry unresolved submission')),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('nativeClosure.retry.confirm')));
      await tester.pumpAndSettle();

      expect(find.text('sync-completed'), findsOneWidget);
      expect(query.beginAttempts, 1);
      expect(query.completedResults, ['sync-completed']);
      expect(query.snapshots, greaterThanOrEqualTo(2));
    },
  );

  testWidgets('Retry unresolved submission blocked preflight is non-mutating', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 2200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final query = _FakeDiagnosticsQuery(
      populated: true,
      unknownPreflight: const UnknownSubmissionRetryPreflight.blocked(
        state: 'unknown-retry-state-invalid',
        guidance: 'preserve-local-evidence-and-stop',
      ),
    );
    final runner = _runner(query: query, outbox: _UploadingOutbox());

    await tester.pumpWidget(
      MaterialApp(home: NativeClosurePage(runner: runner)),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.byKey(const Key('nativeClosure.Retry unresolved submission')),
    );
    await tester.tap(
      find.byKey(const Key('nativeClosure.Retry unresolved submission')),
    );
    await tester.pumpAndSettle();

    expect(find.text('unknown-retry-state-invalid'), findsOneWidget);
    expect(query.beginAttempts, 0);
    expect(find.byKey(const Key('nativeClosure.retry.confirm')), findsNothing);
  });

  test('runner records auth-required Sync terminal outcome once', () async {
    final query = _FakeDiagnosticsQuery();
    final runner = _runner(query: query, signedIn: false);

    final result = await runner.hostedSyncProbe();

    expect(result.state, 'authentication-required');
    expect(query.beginAttempts, 1);
    expect(query.completedResults, ['authentication-required']);
  });

  test('runner records no-new-events Sync terminal outcome once', () async {
    final query = _FakeDiagnosticsQuery();
    final runner = _runner(query: query);

    final result = await runner.hostedSyncProbe();

    expect(result.state, 'sync-no-new-events');
    expect(query.beginAttempts, 1);
    expect(query.completedResults, ['sync-no-new-events']);
  });

  test('runner records completed Sync terminal outcome once', () async {
    final query = _FakeDiagnosticsQuery();
    final runner = _runner(query: query, outbox: _UploadingOutbox());

    final result = await runner.hostedSyncProbe();

    expect(result.state, 'sync-completed');
    expect(query.beginAttempts, 1);
    expect(query.completedResults, ['sync-completed']);
  });

  test('runner records unavailable Sync terminal outcome once', () async {
    final query = _FakeDiagnosticsQuery();
    final runner = _runner(query: query, outbox: _BlockedRecoveryOutbox());

    final result = await runner.hostedSyncProbe();

    expect(result.state, 'sync-unavailable');
    expect(query.beginAttempts, 1);
    expect(query.completedResults, ['sync-unavailable']);
  });

  test('runner records interrupted Sync terminal outcome once', () async {
    final query = _FakeDiagnosticsQuery();
    final runner = _runner(query: query, transport: _TimeoutTransport());

    final result = await runner.hostedSyncProbe();

    expect(result.state, 'sync-interrupted');
    expect(query.beginAttempts, 1);
    expect(query.completedResults, ['sync-interrupted']);
  });

  test(
    'runner retry blocks before ledger when preflight is ineligible',
    () async {
      final query = _FakeDiagnosticsQuery(
        unknownPreflight: const UnknownSubmissionRetryPreflight.blocked(
          state: 'unknown-retry-no-unresolved-submission',
          guidance: 'no-local-sync-action-needed',
        ),
      );
      final runner = _runner(query: query, outbox: _UploadingOutbox());

      final result = await runner.retryUnresolvedSubmission();

      expect(result.state, 'unknown-retry-no-unresolved-submission');
      expect(query.beginAttempts, 0);
      expect(query.completedResults, isEmpty);
    },
  );
}

NativeAuthClosureRunner _runner({
  required _FakeDiagnosticsQuery query,
  bool signedIn = true,
  SyncOutboxRepository? outbox,
  SyncTransport? transport,
  HostedConnectionCheckPort? hostedConnectionCheck,
}) {
  final auth = LabAuthenticationSession(signedIn: signedIn);
  final enrollmentTransport = _FakeEnrollmentTransport();
  final syncOutbox = outbox ?? _NoopOutbox();
  final syncTransport = transport ?? _NoopTransport();
  return NativeAuthClosureRunner(
    authenticationSession: auth,
    enrollmentCoordinator: HostedEnrollmentCoordinator(
      authenticationSession: auth,
      tokenSource: LabAccessTokenSource.accepted('fixture-token'),
      transport: enrollmentTransport,
      repository: _MemoryHostedIdentityRepository(),
      now: DateTime.now,
    ),
    environmentAlias: 'provider-native',
    commandFactory: () async => const DeviceEnrollmentCommand(
      contractVersion: 1,
      installationId: 'install-fixture',
      enrollmentRequestId: 'request-fixture',
      platform: 'windows',
      applicationId: 'markei.windows',
      applicationVersion: '1.0.0',
    ),
    diagnosticsQuery: query,
    syncAttemptRecorder: query,
    hostedSyncCoordinator: HostedSyncCoordinator(
      authenticationSession: auth,
      syncGuard: const _AllowedGuard(),
      applier: _NoopApplier(),
      recoverFailedNotApplied: RecoverFailedNotApplied(syncOutbox),
      uploadPendingEvents: UploadPendingEvents(syncOutbox, syncTransport),
      downloadAndApplyEvents: DownloadAndApplyEvents(
        syncTransport,
        _NoopApplier(),
      ),
      acknowledgeAppliedCursor: AcknowledgeAppliedCursor(
        syncTransport,
        _NoopApplier(),
      ),
    ),
    hostedConnectionCheck:
        hostedConnectionCheck ?? _FakeHostedConnectionCheck(),
  );
}

final class _FakeDiagnosticsQuery
    implements ClosureDiagnosticsQuery, SyncAttemptRecorder {
  _FakeDiagnosticsQuery({this.populated = false, this.unknownPreflight});

  final bool populated;
  final UnknownSubmissionRetryPreflight? unknownPreflight;
  var snapshots = 0;
  var beginAttempts = 0;
  var beginDiagnosticAttempts = 0;
  var cleared = false;
  final completedResults = <String>[];
  final completedDiagnosticAttempts = <_CompletedDiagnosticAttempt>[];

  @override
  Future<int> beginSyncAttempt() async {
    beginAttempts++;
    return beginAttempts;
  }

  @override
  Future<int> beginDiagnosticAttempt({
    required String operationKind,
    required String latestStage,
    required String resultCode,
    required String outcomeClass,
    required String correlationFingerprint,
  }) async {
    beginDiagnosticAttempts++;
    return beginDiagnosticAttempts + 100;
  }

  @override
  Future<void> completeSyncAttempt(
    int attemptId, {
    required String resultCode,
    required String outcomeClass,
    required String phase,
    String? recoveryCode,
  }) async {
    completedResults.add(resultCode);
  }

  @override
  Future<void> completeDiagnosticAttempt(
    int attemptId, {
    required String operationKind,
    required String latestStage,
    required String resultCode,
    required String outcomeClass,
    required String recoveryCode,
    required String correlationFingerprint,
    required String elapsedBand,
    int? httpStatus,
    required bool responseHeadersReceived,
  }) async {
    completedResults.add(resultCode);
    completedDiagnosticAttempts.add(
      _CompletedDiagnosticAttempt(
        latestStage: latestStage,
        resultCode: resultCode,
        correlationFingerprint: correlationFingerprint,
        httpStatus: httpStatus,
        responseHeadersReceived: responseHeadersReceived,
      ),
    );
  }

  @override
  Future<void> clearAttemptHistory() async {
    cleared = true;
  }

  @override
  Future<UnknownSubmissionRetryPreflight> unknownSubmissionRetryPreflight({
    required String authenticationState,
  }) async {
    return unknownPreflight ??
        const UnknownSubmissionRetryPreflight.blocked(
          state: 'unknown-retry-no-unresolved-submission',
          guidance: 'no-local-sync-action-needed',
        );
  }

  @override
  Future<ClosureDiagnosticsSnapshot> snapshot({
    required String authenticationState,
  }) async {
    snapshots++;
    return ClosureDiagnosticsSnapshot(
      authenticationState: authenticationState,
      enrollmentState: 'device-enrolled',
      syncReadiness: populated
          ? 'failed-work-needs-review'
          : 'ready-no-local-work',
      lastResult: populated ? 'sync-interrupted' : 'no-recorded-attempts',
      queueCounts: ClosureQueueCounts(
        pending: populated ? 1 : 0,
        uploading: 0,
        failed: populated ? 1 : 0,
        unknown: populated ? 1 : 0,
      ),
      nextDeviceSequence: 3,
      lastSuccessfulSyncAt: null,
      recoveryGuidance: populated
          ? 'review-local-sync-state-before-retry'
          : 'no-local-sync-action-needed',
      recentAttempts: populated
          ? [
              ClosureSyncAttemptSummary(
                fingerprint: 'attempt1',
                startedAt: DateTime.utc(2026, 7, 21),
                completedAt: DateTime.utc(2026, 7, 21, 0, 0, 1),
                duration: const Duration(seconds: 1),
                phase: 'transport-or-closure',
                operationKind: 'sync',
                latestStage: 'transport-or-closure',
                resultCode: 'sync-interrupted',
                outcomeClass: 'unknown',
                recoveryCode: 'retry-after-local-review',
                correlationFingerprint: null,
                elapsedBand: null,
                httpStatus: null,
                responseHeadersReceived: false,
              ),
            ]
          : const [],
      devices: const [
        ClosureDeviceSummary(
          fingerprint: 'device1',
          isCurrent: true,
          enrollmentState: 'device-enrolled',
          nextSequence: 3,
        ),
      ],
      actionableEvents: populated
          ? [
              ClosureActionableEventSummary(
                fingerprint: 'event1',
                eventType: 'purchase.registered.v3',
                deviceSequence: 1,
                state: 'failed',
                enqueuedAt: DateTime.utc(2026, 7, 21),
                occurredAt: DateTime.utc(2026, 7, 21),
              ),
            ]
          : const [],
      refreshedAt: DateTime.utc(2026, 7, 21),
    );
  }
}

final class _CompletedDiagnosticAttempt {
  const _CompletedDiagnosticAttempt({
    required this.latestStage,
    required this.resultCode,
    required this.correlationFingerprint,
    required this.httpStatus,
    required this.responseHeadersReceived,
  });

  final String latestStage;
  final String resultCode;
  final String correlationFingerprint;
  final int? httpStatus;
  final bool responseHeadersReceived;
}

final class _FakeHostedConnectionCheck implements HostedConnectionCheckPort {
  var checks = 0;

  @override
  HostedConnectionCorrelation createCorrelation() {
    return const HostedConnectionCorrelation(
      value: 'correlation-fixture',
      fingerprint: 'corr1234',
    );
  }

  @override
  Future<HostedConnectionCheckResult> check(
    HostedConnectionCorrelation correlation,
  ) async {
    checks++;
    return HostedConnectionCheckResult(
      correlationFingerprint: correlation.fingerprint,
      latestStage: 'response-parsed',
      resultCode: 'hosted-connection-ready',
      outcomeClass: 'completed',
      recoveryCode: 'ready-does-not-prove-sync',
      liveReachable: true,
      ready: true,
      elapsedBand: 'lt-1s',
      responseHeadersReceived: true,
      httpStatus: 200,
    );
  }
}

final class _AllowedGuard implements HostedSyncGuard {
  const _AllowedGuard();

  @override
  Future<HostedSyncDecision> evaluate(String environmentAlias) async =>
      const HostedSyncDecision.allowed('device-fixture');
}

class _NoopOutbox implements SyncOutboxRepository {
  @override
  Future<SyncUploadSubmission?> leasePending({required int limit}) async =>
      null;

  @override
  Future<void> persistUploadResult(
    String submissionId,
    SyncResult result,
  ) async {}

  @override
  Future<SyncResult> recoverFailedNotApplied(String submissionId) async =>
      const SyncResult(
        code: SyncStatusCode.noRecoverableFailure,
        outcome: SyncOutcome.notApplied,
        retryable: false,
      );

  @override
  Future<SyncResult> recoverOneFailedNotApplied() async => const SyncResult(
    code: SyncStatusCode.noRecoverableFailure,
    outcome: SyncOutcome.notApplied,
    retryable: false,
  );
}

final class _UploadingOutbox extends _NoopOutbox {
  @override
  Future<SyncUploadSubmission?> leasePending({required int limit}) async =>
      const SyncUploadSubmission(
        id: 'submission-fixture',
        deviceId: 'device-fixture',
        requestHash: 'request-hash',
        events: [
          {'eventId': 'event-fixture'},
        ],
      );
}

final class _BlockedRecoveryOutbox extends _NoopOutbox {
  @override
  Future<SyncResult> recoverOneFailedNotApplied() async => const SyncResult(
    code: SyncStatusCode.failedRecoveryBlocked,
    outcome: SyncOutcome.notApplied,
    retryable: false,
  );
}

class _NoopTransport implements SyncTransport {
  @override
  Future<SyncResult> acknowledge(String greatestContiguousCursor) async =>
      const SyncResult(
        code: SyncStatusCode.acknowledged,
        outcome: SyncOutcome.applied,
        retryable: false,
      );

  @override
  Future<DownloadPage> downloadAfter(
    String? cursor, {
    required int limit,
  }) async => const DownloadPage(nextCursor: null, events: []);

  @override
  Future<SyncResult> uploadSubmission(SyncUploadSubmission submission) async =>
      const SyncResult(
        code: SyncStatusCode.serverAccepted,
        outcome: SyncOutcome.applied,
        retryable: false,
      );
}

final class _TimeoutTransport extends _NoopTransport {
  @override
  Future<DownloadPage> downloadAfter(String? cursor, {required int limit}) {
    throw TimeoutException('redacted');
  }
}

final class _NoopApplier implements RemoteEventApplier {
  @override
  Future<SyncResult> applyPage(DownloadPage page) async => const SyncResult(
    code: SyncStatusCode.downloadReceived,
    outcome: SyncOutcome.applied,
    retryable: false,
  );

  @override
  Future<String?> greatestContiguousAppliedCursor() async => null;
}

final class _FakeEnrollmentTransport implements DeviceEnrollmentTransport {
  @override
  Future<DeviceEnrollmentTransportResult> enroll(
    DeviceEnrollmentCommand command,
    String bearerCredential,
  ) async => const DeviceEnrollmentTransportUnavailable();

  @override
  Future<DeviceEnrollmentTransportResult> query(
    String enrollmentRequestId,
    String bearerCredential,
  ) async => const DeviceEnrollmentTransportUnavailable();
}

final class _MemoryHostedIdentityRepository
    implements HostedIdentityRepository {
  HostedIdentityState? state;

  @override
  Future<HostedIdentityState?> load(String environmentAlias) async => state;

  @override
  Future<void> save(HostedIdentityState state) async {
    this.state = state;
  }
}
