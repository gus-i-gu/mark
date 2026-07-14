import '../domain/shared/ids.dart';

enum ProductListView { storage, shortage, market, all }

final class PersonalCycleResult {
  const PersonalCycleResult.available({
    required this.version,
    required this.averageIntervalDays,
    required this.expectedNextPurchaseDate,
    required this.remainingDays,
  }) : unavailableReason = null;

  const PersonalCycleResult.unavailable(this.unavailableReason)
    : version = 'personal-cycle-v1',
      averageIntervalDays = null,
      expectedNextPurchaseDate = null,
      remainingDays = null;

  final String version;
  final int? averageIntervalDays;
  final DateTime? expectedNextPurchaseDate;
  final int? remainingDays;
  final String? unavailableReason;

  bool get isAvailable => unavailableReason == null;
}

final class ProductListProjectionItem {
  const ProductListProjectionItem({
    required this.productId,
    required this.productCode,
    required this.productName,
    required this.productBrand,
    required this.cycle,
    required this.latestCurrencyCode,
    required this.latestLineTotalMinorUnits,
  });

  final ProductId productId;
  final String productCode;
  final String productName;
  final String productBrand;
  final PersonalCycleResult cycle;
  final String? latestCurrencyCode;
  final int? latestLineTotalMinorUnits;
}

final class ProductListProjection {
  const ProductListProjection({
    required this.view,
    required this.items,
    required this.shortageThresholdDays,
    this.approximateTotalCurrencyCode,
    this.approximateTotalMinorUnits,
  });

  final ProductListView view;
  final List<ProductListProjectionItem> items;
  final int shortageThresholdDays;
  final String? approximateTotalCurrencyCode;
  final int? approximateTotalMinorUnits;
}

abstract interface class ProductListProjectionRepository {
  Future<ProductListProjection> productListProjection({
    required AccountId accountId,
    required ProductListView view,
    required DateTime today,
  });
}

PersonalCycleResult personalCycleV1(List<DateTime> localDates, DateTime today) {
  final uniqueDays =
      localDates
          .map((date) => DateTime(date.year, date.month, date.day))
          .toSet()
          .toList()
        ..sort();
  if (uniqueDays.length < 2) {
    return const PersonalCycleResult.unavailable('Not enough history');
  }
  final intervals = <int>[];
  for (var i = 1; i < uniqueDays.length; i++) {
    final days = uniqueDays[i].difference(uniqueDays[i - 1]).inDays;
    if (days > 0) {
      intervals.add(days);
    }
  }
  if (intervals.isEmpty) {
    return const PersonalCycleResult.unavailable('Not enough history');
  }
  final average = (intervals.reduce((a, b) => a + b) / intervals.length)
      .round();
  final latest = uniqueDays.last;
  final expected = latest.add(Duration(days: average));
  final todayDate = DateTime(today.year, today.month, today.day);
  return PersonalCycleResult.available(
    version: 'personal-cycle-v1',
    averageIntervalDays: average,
    expectedNextPurchaseDate: expected,
    remainingDays: expected.difference(todayDate).inDays,
  );
}

bool itemBelongsToView(
  ProductListProjectionItem item,
  ProductListView view,
  int threshold,
) {
  if (view == ProductListView.all) {
    return true;
  }
  final remaining = item.cycle.remainingDays;
  if (remaining == null) {
    return false;
  }
  return switch (view) {
    ProductListView.storage => remaining > threshold,
    ProductListView.shortage => remaining >= 0 && remaining <= threshold,
    ProductListView.market => remaining < 0,
    ProductListView.all => true,
  };
}
