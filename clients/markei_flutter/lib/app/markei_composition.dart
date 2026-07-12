import '../application/catalogue_queries.dart';
import '../application/purchase_history.dart';
import '../application/register_purchase.dart';
import '../domain/shared/ids.dart';
import '../infrastructure/local/local_database.dart';
import '../infrastructure/local/local_purchase_repository.dart';
import '../infrastructure/local/local_query_repository.dart';

final class MarkeiComposition {
  MarkeiComposition({
    required this.database,
    required this.purchaseRegistration,
    required this.catalogueQueries,
    required this.purchaseHistory,
    required this.accountId,
    required this.deviceId,
  });

  final LocalDatabase database;
  final PurchaseRegistrationRepository purchaseRegistration;
  final CatalogueQueryRepository catalogueQueries;
  final PurchaseHistoryRepository purchaseHistory;
  final AccountId accountId;
  final DeviceId deviceId;

  factory MarkeiComposition.appPrivate() {
    final database = LocalDatabase.appPrivate();
    final queries = LocalQueryRepository(database);
    return MarkeiComposition(
      database: database,
      purchaseRegistration: LocalPurchaseRepository(database),
      catalogueQueries: queries,
      purchaseHistory: queries,
      accountId: const AccountId('local-account'),
      deviceId: const DeviceId('windows-device'),
    );
  }
}
