import '../domain/shared/ids.dart';
import '../domain/shared/quantity.dart';

abstract interface class PurchaseHistoryRepository {
  Future<List<PurchaseHistoryEntry>> listRecentPurchases(AccountId accountId);

  Future<PurchaseDetail?> getPurchaseDetail(
    AccountId accountId,
    PurchaseId purchaseId,
  );

  Future<PriceChangeResult> priceChangeForProduct(
    AccountId accountId,
    ProductId productId,
  );
}

final class PurchaseHistoryEntry {
  const PurchaseHistoryEntry({
    required this.purchaseId,
    required this.storeName,
    required this.occurrenceTime,
    required this.currencyCode,
    required this.totalMinorUnits,
    required this.itemCount,
    this.personLabel,
    this.paymentMethodLabel,
  });

  final PurchaseId purchaseId;
  final String storeName;
  final DateTime occurrenceTime;
  final String currencyCode;
  final int totalMinorUnits;
  final int itemCount;
  final String? personLabel;
  final String? paymentMethodLabel;
}

final class PurchaseDetail {
  const PurchaseDetail({required this.entry, required this.items});

  final PurchaseHistoryEntry entry;
  final List<PurchaseDetailItem> items;
}

final class PurchaseDetailItem {
  const PurchaseDetailItem({
    required this.productId,
    required this.productName,
    required this.productBrand,
    required this.productCode,
    required this.packageCount,
    required this.measurementKind,
    required this.purchasedAmount,
    required this.purchasedUnit,
    required this.currencyCode,
    required this.lineTotalMinorUnits,
  });

  final ProductId productId;
  final String productName;
  final String productBrand;
  final String productCode;
  final int? packageCount;
  final String measurementKind;
  final String purchasedAmount;
  final String purchasedUnit;
  final String currencyCode;
  final int lineTotalMinorUnits;
}

final class ProductPriceObservation {
  const ProductPriceObservation({
    required this.productId,
    required this.storeName,
    required this.occurrenceTime,
    required this.currencyCode,
    required this.measurementKind,
    required this.purchasedUnit,
    required this.purchasedMicrounits,
    required this.lineTotalMinorUnits,
  });

  final ProductId productId;
  final String storeName;
  final DateTime occurrenceTime;
  final String currencyCode;
  final MeasurementKind measurementKind;
  final CanonicalUnit purchasedUnit;
  final int purchasedMicrounits;
  final int lineTotalMinorUnits;
}

sealed class PriceChangeResult {
  const PriceChangeResult();
}

final class ComparablePriceChange extends PriceChangeResult {
  const ComparablePriceChange({
    required this.previous,
    required this.latest,
    required this.previousMinorUnitsPerUnit,
    required this.latestMinorUnitsPerUnit,
    required this.changeBasisPoints,
  });

  final ProductPriceObservation previous;
  final ProductPriceObservation latest;
  final int previousMinorUnitsPerUnit;
  final int latestMinorUnitsPerUnit;
  final int changeBasisPoints;
}

final class PriceChangeUnavailable extends PriceChangeResult {
  const PriceChangeUnavailable(this.reason);

  final String reason;
}

PriceChangeResult compareLatestCompatibleObservations(
  List<ProductPriceObservation> observations,
) {
  if (observations.length < 2) {
    return const PriceChangeUnavailable('Not enough comparable purchases.');
  }
  final sorted = [...observations]
    ..sort((a, b) {
      final byTime = b.occurrenceTime.compareTo(a.occurrenceTime);
      if (byTime != 0) {
        return byTime;
      }
      return b.storeName.compareTo(a.storeName);
    });
  final latest = sorted.first;
  final compatible = sorted
      .where((observation) {
        return observation.productId.value == latest.productId.value &&
            observation.currencyCode == latest.currencyCode &&
            observation.measurementKind == latest.measurementKind &&
            observation.purchasedUnit == latest.purchasedUnit &&
            observation.purchasedMicrounits > 0;
      })
      .toList(growable: false);
  if (compatible.length < 2) {
    return const PriceChangeUnavailable('Not enough comparable purchases.');
  }
  final previous = compatible[1];
  final latestPrice = _minorUnitsPerUnit(latest);
  final previousPrice = _minorUnitsPerUnit(previous);
  if (previousPrice <= 0) {
    return const PriceChangeUnavailable('Not enough comparable purchases.');
  }
  final changeBasisPoints =
      ((latestPrice - previousPrice) * 10000) ~/ previousPrice;
  return ComparablePriceChange(
    previous: previous,
    latest: latest,
    previousMinorUnitsPerUnit: previousPrice,
    latestMinorUnitsPerUnit: latestPrice,
    changeBasisPoints: changeBasisPoints,
  );
}

int _minorUnitsPerUnit(ProductPriceObservation observation) {
  return (observation.lineTotalMinorUnits * NormalizedQuantity.factor) ~/
      observation.purchasedMicrounits;
}
