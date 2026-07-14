import '../domain/references/local_reference.dart';
import '../domain/shared/ids.dart';

abstract interface class LocalReferenceRepository {
  Future<List<LocalReference>> listReferences(
    AccountId accountId,
    LocalReferenceKind kind, {
    bool includeArchived = false,
  });

  Future<LocalReference> saveReference({
    required AccountId accountId,
    required LocalReferenceKind kind,
    String? id,
    required String nickname,
    bool active = true,
  });

  Future<void> archiveReference({
    required AccountId accountId,
    required LocalReferenceKind kind,
    required String id,
  });
}

abstract interface class AccountPreferenceRepository {
  Future<int> shortageThresholdDays(AccountId accountId);

  Future<void> setShortageThresholdDays(AccountId accountId, int days);
}
