import 'package:flutter_test/flutter_test.dart';
import 'package:markei/domain/shared/quantity.dart';

void main() {
  test(
    'display quantity accepts comma or point and rejects mixed separators',
    () {
      final comma = normalizeDisplayQuantity(
        kind: MeasurementKind.volume,
        amount: '1,5',
        unit: 'L',
      );
      final point = normalizeDisplayQuantity(
        kind: MeasurementKind.volume,
        amount: '1.5',
        unit: 'L',
      );

      expect(comma.microunits, point.microunits);
      expect(comma.unit, CanonicalUnit.l);
      expect(
        () => normalizeDisplayQuantity(
          kind: MeasurementKind.mass,
          amount: '1,000.5',
          unit: 'kg',
        ),
        throwsArgumentError,
      );
    },
  );

  test('count unit accepts un but not fractional COUNT', () {
    final units = normalizeDisplayQuantity(
      kind: MeasurementKind.count,
      amount: '2',
      unit: 'un',
    );

    expect(units.unit, CanonicalUnit.unit);
    expect(
      () => normalizeDisplayQuantity(
        kind: MeasurementKind.count,
        amount: '2,5',
        unit: 'un',
      ),
      throwsArgumentError,
    );
  });
}
