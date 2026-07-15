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
}
