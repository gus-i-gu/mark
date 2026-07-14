import '../application/catalogue_queries.dart';
import '../application/history_export.dart';
import '../application/local_references.dart';
import '../application/product_lists.dart';
import '../application/purchase_history.dart';
import '../application/register_purchase.dart';
import '../domain/shared/ids.dart';
import '../infrastructure/local/local_database.dart';
import '../infrastructure/local/local_device_identity_repository.dart';
import '../infrastructure/local/local_purchase_repository.dart';
import '../infrastructure/local/local_query_repository.dart';

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

  static Future<MarkeiComposition> appPrivate() async {
    final database = LocalDatabase.appPrivate();
    final queries = LocalQueryRepository(database);
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
    );
  }
}
