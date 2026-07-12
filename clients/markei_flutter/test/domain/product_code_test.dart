import 'package:flutter_test/flutter_test.dart';
import 'package:markei/domain/catalogue/product_code.dart';

void main() {
  test('normalizes product code separately from product meaning', () {
    final code = normalizeProductCode('  CAF-001  ');

    expect(code.displayValue, 'CAF-001');
    expect(code.normalizedKey, 'caf-001');
  });

  test('preserves punctuation in product code key', () {
    expect(normalizeProductCode('CAF-001').normalizedKey, 'caf-001');
    expect(normalizeProductCode('CAF 001').normalizedKey, 'caf 001');
  });

  test('rejects empty or too-long product codes', () {
    expect(() => normalizeProductCode('   '), throwsArgumentError);
    expect(
      () => normalizeProductCode('x'.padRight(65, 'x')),
      throwsArgumentError,
    );
  });
}
