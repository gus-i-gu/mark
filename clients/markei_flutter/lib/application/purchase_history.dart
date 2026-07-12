import '../domain/shared/ids.dart';

abstract interface class PurchaseHistoryRepository {
  Future<List<PurchaseHistoryEntry>> listRecentPurchases(AccountId accountId);
}

final class PurchaseHistoryEntry {
  const PurchaseHistoryEntry({
    required this.purchaseId,
    required this.storeName,
    required this.occurrenceTime,
    required this.currencyCode,
    required this.totalMinorUnits,
    required this.itemCount,
  });

  final PurchaseId purchaseId;
  final String storeName;
  final DateTime occurrenceTime;
  final String currencyCode;
  final int totalMinorUnits;
  final int itemCount;
}
