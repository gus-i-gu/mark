import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/hosted_auth_ports.dart';
import 'package:markei/infrastructure/local/hosted_identity_repository.dart';
import 'package:markei/infrastructure/local/local_database.dart';

void main() {
  test(
    'stores hosted InstallationId and server Device binding by environment',
    () async {
      final db = LocalDatabase.memory();
      addTearDown(db.close);
      final repository = DriftHostedIdentityRepository(db);
      final state = HostedIdentityState(
        environmentAlias: 'local-hosted',
        installationId: '33333333-3333-4333-8333-333333333333',
        enrollmentRequestId: '55555555-5555-4555-8555-555555555555',
        enrollmentState: 'device-enrolled',
        accountId: '11111111-1111-4111-8111-111111111111',
        serverDeviceId: '22222222-2222-4222-8222-222222222222',
        generation: 1,
        updatedAt: DateTime.utc(2026, 7, 15),
      );

      await repository.save(state);
      final loaded = await repository.load('local-hosted');

      expect(loaded?.installationId, state.installationId);
      expect(loaded?.serverDeviceId, state.serverDeviceId);
      expect(loaded?.enrollmentState, 'device-enrolled');
    },
  );
}
