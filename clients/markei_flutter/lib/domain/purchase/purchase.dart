import '../catalogue/product.dart';
import '../shared/ids.dart';
import '../shared/money.dart';
import '../shared/quantity.dart';
import '../store/store.dart';

final class PurchaseItem {
  const PurchaseItem({
    required this.id,
    required this.purchaseId,
    required this.productId,
    required this.packageCount,
    required this.purchasedQuantity,
    required this.lineTotal,
  });

  final PurchaseItemId id;
  final PurchaseId purchaseId;
  final ProductId productId;
  final int? packageCount;
  final NormalizedQuantity purchasedQuantity;
  final Money lineTotal;

  void validate() {
    if (packageCount != null && packageCount! <= 0) {
      throw ArgumentError('Purchase Item packageCount must be positive.');
    }
    if (purchasedQuantity.microunits <= 0) {
      throw ArgumentError('Purchase Item quantity must be positive.');
    }
    if (lineTotal.minorUnits < 0) {
      throw ArgumentError('Purchase Item line total cannot be negative.');
    }
  }

  Map<String, Object?> toJson() => {
    'id': id.value,
    'purchaseId': purchaseId.value,
    'productId': productId.value,
    'packageCount': packageCount,
    'purchasedQuantity': purchasedQuantity.toJson(),
    'lineTotal': lineTotal.toJson(),
  };
}

final class Purchase {
  const Purchase({
    required this.id,
    required this.accountId,
    required this.store,
    required this.occurrenceTime,
    required this.currencyCode,
    required this.items,
    this.personId,
    this.paymentMethodId,
  });

  final PurchaseId id;
  final AccountId accountId;
  final Store store;
  final DateTime occurrenceTime;
  final String currencyCode;
  final List<PurchaseItem> items;
  final String? personId;
  final String? paymentMethodId;

  void validate() {
    if (items.isEmpty) {
      throw ArgumentError('Purchase requires at least one Item.');
    }
    for (final item in items) {
      item.validate();
      if (item.lineTotal.currencyCode != currencyCode) {
        throw ArgumentError(
          'Purchase Item currency must match Purchase currency.',
        );
      }
    }
  }

  int get totalMinorUnits =>
      items.fold(0, (total, item) => total + item.lineTotal.minorUnits);

  Map<String, Object?> toJson() => {
    'id': id.value,
    'accountId': accountId.value,
    'store': store.toJson(),
    'personId': personId,
    'paymentMethodId': paymentMethodId,
    'occurrenceTime': occurrenceTime.toUtc().toIso8601String(),
    'currencyCode': currencyCode,
    'totalMinorUnits': totalMinorUnits,
    'items': items.map((item) => item.toJson()).toList(growable: false),
  };
}

sealed class ProductReference {
  const ProductReference();
}

final class ExistingProductReference extends ProductReference {
  const ExistingProductReference(this.productId);

  final ProductId productId;
}

final class NewProductReference extends ProductReference {
  const NewProductReference(this.productDraft);

  final ProductDraft productDraft;
}

final class PurchaseItemDraft {
  const PurchaseItemDraft({
    required this.productReference,
    required this.packageCount,
    required this.purchasedQuantity,
    required this.lineTotal,
  });

  final ProductReference productReference;
  final int? packageCount;
  final NormalizedQuantity purchasedQuantity;
  final Money lineTotal;
}
