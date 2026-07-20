import 'package:drift/drift.dart';
import 'package:markei/application/hosted_auth_ports.dart';
import 'package:markei/infrastructure/local/local_database.dart';

final class DriftHostedIdentityRepository implements HostedIdentityRepository {
  DriftHostedIdentityRepository(this._database);

  final LocalDatabase _database;

  @override
  Future<HostedIdentityState?> load(String environmentAlias) async {
    final row =
        await (_database.select(_database.hostedAuthStates)..where(
              (table) => table.environmentAlias.equals(environmentAlias),
            ))
            .getSingleOrNull();
    if (row == null) return null;
    return HostedIdentityState(
      environmentAlias: row.environmentAlias,
      installationId: row.installationId,
      enrollmentRequestId: row.enrollmentRequestId,
      enrollmentState: row.enrollmentState,
      accountId: row.accountId,
      serverDeviceId: row.serverDeviceId,
      generation: row.generation,
      updatedAt: row.updatedAt,
    );
  }

  @override
  Future<void> save(HostedIdentityState state) async {
    await _database
        .into(_database.hostedAuthStates)
        .insertOnConflictUpdate(
          HostedAuthStatesCompanion.insert(
            environmentAlias: state.environmentAlias,
            installationId: state.installationId,
            enrollmentState: state.enrollmentState,
            updatedAt: state.updatedAt,
            enrollmentRequestId: Value(state.enrollmentRequestId),
            accountId: Value(state.accountId),
            serverDeviceId: Value(state.serverDeviceId),
            generation: Value(state.generation),
          ),
        );
  }

  Future<HostedIdentityBinding?> loadActiveBinding(
    String expectedEnvironmentAlias,
  ) async {
    final state = await load(expectedEnvironmentAlias);
    if (state == null) return null;
    return validateHostedIdentityBinding(
      state,
      expectedEnvironmentAlias: expectedEnvironmentAlias,
    );
  }

  Future<void> ensureLocalHostedIdentity(HostedIdentityBinding binding) {
    return _database.transaction(() async {
      final now = DateTime.now().toUtc();
      await _database
          .into(_database.localAccounts)
          .insert(
            LocalAccountsCompanion.insert(
              id: binding.accountId,
              defaultCurrencyCode: 'BRL',
              createdAt: now,
            ),
            mode: InsertMode.insertOrIgnore,
          );
      await _database
          .into(_database.devices)
          .insert(
            DevicesCompanion.insert(
              id: binding.serverDeviceId,
              accountId: binding.accountId,
              nextSequence: 1,
              createdAt: now,
            ),
            mode: InsertMode.insertOrIgnore,
          );
      await _database
          .into(_database.syncState)
          .insert(
            SyncStateCompanion.insert(
              accountId: binding.accountId,
              accountCursor: const Value(null),
              updatedAt: now,
            ),
            mode: InsertMode.insertOrIgnore,
          );
    });
  }
}

final class DriftHostedSyncGuard implements HostedSyncGuard {
  DriftHostedSyncGuard(this._repository);

  final HostedIdentityRepository _repository;

  @override
  Future<HostedSyncDecision> evaluate(String environmentAlias) async {
    final state = await _repository.load(environmentAlias);
    if (state == null) {
      return const HostedSyncDecision.blocked('enrollment-required');
    }
    if (state.enrollmentState == 'device-revoked') {
      return const HostedSyncDecision.blocked('device-revoked');
    }
    if (state.enrollmentState == 'device-expired') {
      return const HostedSyncDecision.blocked('device-expired');
    }
    final binding = validateHostedIdentityBinding(
      state,
      expectedEnvironmentAlias: environmentAlias,
    );
    if (binding == null) {
      return const HostedSyncDecision.blocked('binding-invalid');
    }
    return HostedSyncDecision.allowedBinding(binding);
  }
}

final class BlockedHostedSyncGuard implements HostedSyncGuard {
  const BlockedHostedSyncGuard(this.reason);

  final String reason;

  @override
  Future<HostedSyncDecision> evaluate(String environmentAlias) async =>
      HostedSyncDecision.blocked(reason);
}

HostedIdentityBinding? validateHostedIdentityBinding(
  HostedIdentityState state, {
  required String expectedEnvironmentAlias,
}) {
  if (state.environmentAlias != expectedEnvironmentAlias) return null;
  if (!_completedActiveStates.contains(state.enrollmentState)) return null;
  final accountId = state.accountId;
  final serverDeviceId = state.serverDeviceId;
  final generation = state.generation;
  if (accountId == null ||
      serverDeviceId == null ||
      generation == null ||
      generation <= 0) {
    return null;
  }
  if (!_uuidV4Pattern.hasMatch(accountId) ||
      !_uuidV4Pattern.hasMatch(serverDeviceId) ||
      !_stableInstallationPattern.hasMatch(state.installationId)) {
    return null;
  }
  return HostedIdentityBinding(
    environmentAlias: state.environmentAlias,
    accountId: accountId,
    serverDeviceId: serverDeviceId,
    installationId: state.installationId,
    generation: generation,
  );
}

const _completedActiveStates = {'device-enrolled', 'duplicate-equivalent'};

final _uuidV4Pattern = RegExp(
  r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
);

final _stableInstallationPattern = RegExp(r'^[A-Za-z0-9._:-]{8,128}$');
