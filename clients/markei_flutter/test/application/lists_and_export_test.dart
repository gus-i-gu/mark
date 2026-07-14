import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/history_export.dart';
import 'package:markei/application/product_lists.dart';
import 'package:markei/application/purchase_history.dart';
import 'package:markei/domain/shared/ids.dart';

void main() {
  test('personal-cycle-v1 rounds positive intervals and classifies views', () {
    final cycle = personalCycleV1([
      DateTime(2026, 7, 1),
      DateTime(2026, 7, 11),
      DateTime(2026, 7, 22),
    ], DateTime(2026, 7, 26));
    final item = ProductListProjectionItem(
      productId: const ProductId('p1'),
      productCode: 'P-001',
      productName: 'Arroz',
      productBrand: 'Marca',
      cycle: cycle,
      latestCurrencyCode: 'BRL',
      latestLineTotalMinorUnits: 1000,
    );

    expect(cycle.averageIntervalDays, 11);
    expect(cycle.remainingDays, 7);
    expect(itemBelongsToView(item, ProductListView.storage, 5), isTrue);
    expect(itemBelongsToView(item, ProductListView.shortage, 5), isFalse);
  });

  test(
    'CSV and PDF export are deterministic selected-purchase DTO outputs',
    () {
      final bundle = PurchaseExportBundle(
        purchases: [
          PurchaseDetail(
            entry: PurchaseHistoryEntry(
              purchaseId: const PurchaseId('purchase-1'),
              storeName: 'Mercado, Central',
              occurrenceTime: DateTime.utc(2026, 7, 14, 12),
              currencyCode: 'BRL',
              totalMinorUnits: 1299,
              itemCount: 1,
              personLabel: 'Gus (archived)',
              paymentMethodLabel: 'Debit',
            ),
            items: const [
              PurchaseDetailItem(
                productId: ProductId('product-1'),
                productName: 'Arroz',
                productBrand: 'Marca A',
                productCode: 'ARROZ-001',
                packageCount: 1,
                measurementKind: 'MASS',
                purchasedAmount: '1.000000',
                purchasedUnit: 'KG',
                currencyCode: 'BRL',
                lineTotalMinorUnits: 1299,
              ),
            ],
          ),
        ],
      );

      final csv = purchaseBundleCsv(bundle);
      final pdf = purchaseBundlePdfBytes(bundle);

      expect(csv, contains('"Mercado, Central"'));
      expect(csv, contains('Gus (archived)'));
      expect(ascii.decode(pdf.take(8).toList()), '%PDF-1.4');
    },
  );
}
