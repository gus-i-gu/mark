import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/bulk_pricing.dart';
import 'package:markei/application/purchase_occurrence.dart';
import 'package:markei/domain/shared/quantity.dart';

void main() {
  test('Purchase occurrence parses exact local civil date and time', () {
    final utc = parsePurchaseOccurrenceUtc(
      const PurchaseOccurrenceInput(dateText: '14/07/2026', timeText: '09:30'),
    );

    expect(utc.toLocal().year, 2026);
    expect(utc.toLocal().month, 7);
    expect(utc.toLocal().day, 14);
    expect(utc.toLocal().hour, 9);
    expect(utc.toLocal().minute, 30);
  });

  test(
    'BULK line total uses selected amount unit and half-up currency total',
    () {
      expect(
        bulkLineTotalMinorUnits(
          kind: MeasurementKind.mass,
          amount: '250',
          amountUnit: 'g',
          pricePerSelectedUnit: '0,03',
        ),
        750,
      );
    },
  );

  test('BULK rejects mixed amount and rate units', () {
    expect(
      () => bulkLineTotalMinorUnits(
        kind: MeasurementKind.volume,
        amount: '1',
        amountUnit: 'kg',
        pricePerSelectedUnit: '10',
      ),
      throwsArgumentError,
    );
  });
}
