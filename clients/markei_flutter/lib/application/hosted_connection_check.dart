abstract interface class HostedConnectionCheckPort {
  HostedConnectionCorrelation createCorrelation();

  Future<HostedConnectionCheckResult> check(
    HostedConnectionCorrelation correlation,
  );
}

final class HostedConnectionCorrelation {
  const HostedConnectionCorrelation({
    required this.value,
    required this.fingerprint,
  });

  final String value;
  final String fingerprint;
}

final class HostedConnectionCheckResult {
  const HostedConnectionCheckResult({
    required this.correlationFingerprint,
    required this.latestStage,
    required this.resultCode,
    required this.outcomeClass,
    required this.recoveryCode,
    required this.liveReachable,
    required this.ready,
    required this.elapsedBand,
    required this.responseHeadersReceived,
    this.httpStatus,
  });

  final String correlationFingerprint;
  final String latestStage;
  final String resultCode;
  final String outcomeClass;
  final String recoveryCode;
  final bool liveReachable;
  final bool ready;
  final String elapsedBand;
  final bool responseHeadersReceived;
  final int? httpStatus;
}

final class HostedConnectionCheckUnavailable
    implements HostedConnectionCheckPort {
  const HostedConnectionCheckUnavailable();

  @override
  HostedConnectionCorrelation createCorrelation() {
    return const HostedConnectionCorrelation(
      value: 'unavailable',
      fingerprint: 'unavailable',
    );
  }

  @override
  Future<HostedConnectionCheckResult> check(
    HostedConnectionCorrelation correlation,
  ) async {
    return HostedConnectionCheckResult(
      correlationFingerprint: correlation.fingerprint,
      latestStage: 'request-not-started',
      resultCode: 'configuration-missing',
      outcomeClass: 'blocked',
      recoveryCode: 'configuration-required',
      liveReachable: false,
      ready: false,
      elapsedBand: 'not-started',
      responseHeadersReceived: false,
    );
  }
}
