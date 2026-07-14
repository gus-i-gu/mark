import 'package:flutter_test/flutter_test.dart';
import 'package:markei/domain/catalogue/product.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/quantity.dart';

void main() {
  test('normalization v3 preserves Portuguese accented letters', () {
    final product = createProductFromDraft(
      accountId: const AccountId('11111111-1111-4111-8111-111111111111'),
      draft: const ProductDraft(
        userCode: 'CAF-001',
        name: ' CAFÉ   PILÃO ',
        brand: 'São João',
        mode: ProductMode.packaged,
        measurementKind: MeasurementKind.mass,
        packageAmount: '1',
        packageUnit: 'kg',
      ),
    );

    expect(product.normalizationVersion, 3);
    expect(product.displayName, 'CAFÉ   PILÃO');
    expect(product.displayBrand, 'São João');
    expect(product.normalizedName, 'café pilão');
    expect(product.normalizedBrand, 'são joão');
  });

  test('composed and decomposed accents normalize equally', () {
    final composed = normalizeSemanticIdentityText('Café Pilão');
    final decomposed = normalizeSemanticIdentityText('Cafe\u0301 Pilão');

    expect(composed, decomposed);
  });

  test('semantic punctuation becomes space without stripping accents', () {
    expect(normalizeSemanticIdentityText('Café-Pilão'), 'café pilão');
    expect(normalizeSemanticIdentityText('maçã, pão; óleo'), 'maçã pão óleo');
  });
}
