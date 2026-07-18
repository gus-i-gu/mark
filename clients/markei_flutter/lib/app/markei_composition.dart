import 'package:uuid/uuid.dart';

import '../application/catalogue_queries.dart';
import '../application/history_export.dart';
import '../application/hosted_auth_ports.dart';
import '../application/hosted_enrollment_coordinator.dart';
import '../application/local_references.dart';
import '../application/product_lists.dart';
import '../application/purchase_history.dart';
import '../application/register_purchase.dart';
import '../domain/shared/ids.dart';
import '../infrastructure/auth/auth0_native_authentication.dart';
import '../infrastructure/auth/native_auth_config.dart';
import '../infrastructure/local/hosted_identity_repository.dart';
import '../infrastructure/local/local_database.dart';
import '../infrastructure/local/local_device_identity_repository.dart';
import '../infrastructure/local/local_purchase_repository.dart';
import '../infrastructure/local/local_query_repository.dart';
import '../infrastructure/remote/http_device_enrollment_transport.dart';
import 'native_auth_closure_runner.dart';

final class MarkeiComposition {
  MarkeiComposition({
    required this.database,
    required this.purchaseRegistration,
    required this.catalogueQueries,
    required this.purchaseHistory,
    required this.references,
    required this.preferences,
    required this.productLists,
    required this.purchaseExports,
    required this.accountId,
    required this.deviceId,
    this.nativeAuthConfiguration = const NativeAuthConfigurationUnavailable(
      'configuration-missing',
    ),
    this.nativeClosureRunner = const NativeAuthClosureRunner.unavailable(),
  });

  final LocalDatabase database;
  final PurchaseRegistrationRepository purchaseRegistration;
  final CatalogueQueryRepository catalogueQueries;
  final PurchaseHistoryRepository purchaseHistory;
  final LocalReferenceRepository references;
  final AccountPreferenceRepository preferences;
  final ProductListProjectionRepository productLists;
  final PurchaseExportRepository purchaseExports;
  final AccountId accountId;
  final DeviceId deviceId;
  final NativeAuthConfigurationResult nativeAuthConfiguration;
  final NativeAuthClosureRunner nativeClosureRunner;

  static Future<MarkeiComposition> appPrivate() async {
    final database = LocalDatabase.appPrivate();
    final queries = LocalQueryRepository(database);
    final nativeConfig = NativeAuthConfiguration.fromEnvironment();
    final nativeClosureRunner = _nativeClosureRunner(database, nativeConfig);
    const accountId = AccountId('local-account');
    final deviceId = await LocalDeviceIdentityRepository(
      database,
    ).loadOrCreateDeviceId(accountId);
    return MarkeiComposition(
      database: database,
      purchaseRegistration: LocalPurchaseRepository(database),
      catalogueQueries: queries,
      purchaseHistory: queries,
      references: queries,
      preferences: queries,
      productLists: queries,
      purchaseExports: queries,
      accountId: accountId,
      deviceId: deviceId,
      nativeAuthConfiguration: nativeConfig,
      nativeClosureRunner: nativeClosureRunner,
    );
  }

  static NativeAuthClosureRunner _nativeClosureRunner(
    LocalDatabase database,
    NativeAuthConfigurationResult config,
  ) {
    if (config is! NativeAuthConfigurationReady) {
      return NativeAuthClosureRunner.unavailable();
    }
    final authentication = NativeAuth0Authentication(
      configuration: config.configuration,
    );
    final repository = DriftHostedIdentityRepository(database);
    const uuid = Uuid();
    return NativeAuthClosureRunner(
      authenticationSession: authentication,
      enrollmentCoordinator: HostedEnrollmentCoordinator(
        authenticationSession: authentication,
        tokenSource: authentication,
        transport: HttpDeviceEnrollmentTransport(
          origin: config.configuration.hostedOrigin,
        ),
        repository: repository,
        now: DateTime.now,
      ),
      environmentAlias: 'provider-native',
      commandFactory: () => DeviceEnrollmentCommand(
        contractVersion: 1,
        installationId: uuid.v4(),
        enrollmentRequestId: uuid.v4(),
        platform: config.configuration.platform.name,
        applicationId:
            config.configuration.platform == NativeAuthPlatform.android
            ? NativeAuthConfiguration.defaultAndroidApplicationId
            : 'markei.windows',
        applicationVersion: '1.0.0',
      ),
    );
  }
}
