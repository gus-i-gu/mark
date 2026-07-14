enum FailureOutcome { notApplied, applied, unknown }

final class AppFailure implements Exception {
  const AppFailure({
    required this.code,
    required this.operation,
    required this.recovery,
    required this.retryable,
    required this.outcome,
    this.field,
  });

  final String code;
  final String operation;
  final String? field;
  final String recovery;
  final bool retryable;
  final FailureOutcome outcome;

  String get userMessage {
    final fieldText = field == null ? '' : ' Check $field.';
    final outcomeText = switch (outcome) {
      FailureOutcome.notApplied => 'The operation was not applied.',
      FailureOutcome.applied => 'The operation was applied.',
      FailureOutcome.unknown =>
        'The result is unknown; keep the draft and check History before retrying.',
    };
    return '$operation failed.$fieldText $outcomeText $recovery';
  }

  @override
  String toString() => 'AppFailure($code, $operation)';
}
