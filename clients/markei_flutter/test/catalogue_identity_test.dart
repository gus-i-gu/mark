import 'package:flutter_test/flutter_test.dart';
import 'package:markei/domain/catalogue/product.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/quantity.dart';

import 'fixture_support.dart';

void main() {
  test('normalizes packaged and equivalent gram inputs to exact identity', () {
    final fixture = loadFixture('catalogue_identity.json');
    final accountId = AccountId(fixture['accountId']! as String);
    final packaged = fixture['packaged']! as Map<String, Object?>;
    final equivalent = fixture['equivalentPackaged']! as Map<String, Object?>;

    final product = normalizeProductDraft(
      accountId: accountId,
      draft: _productDraft(packaged['input']! as Map<String, Object?>),
    );
    final equivalentProduct = normalizeProductDraft(
      accountId: accountId,
      draft: _productDraft(equivalent['input']! as Map<String, Object?>),
    );
    final expected = packaged['expected']! as Map<String, Object?>;

    expect(product.normalizedName, expected['normalizedName']);
    expect(product.normalizedBrand, expected['normalizedBrand']);
    expect(
      product.userProductCode.normalizedKey,
      expected['normalizedUserProductCode'],
    );
    expect(product.packageQuantity?.decimalText, expected['packageAmount']);
    expect(product.identityKey, expected['identityKey']);
    expect(equivalentProduct.identityKey, equivalent['expectedIdentityKey']);
    expect(equivalentProduct.id.value == product.id.value, isFalse);
  });

  test('normalizes bulk identity without package amount', () {
    final fixture = loadFixture('catalogue_identity.json');
    final accountId = AccountId(fixture['accountId']! as String);
    final bulk = fixture['bulk']! as Map<String, Object?>;

    final product = normalizeProductDraft(
      accountId: accountId,
      draft: _productDraft(bulk['input']! as Map<String, Object?>),
    );
    final expected = bulk['expected']! as Map<String, Object?>;

    expect(product.mode, ProductMode.bulk);
    expect(product.packageQuantity, isNull);
    expect(product.identityKey, expected['identityKey']);
  });

  test('similar product spelling warns but does not auto merge', () {
    final fixture = loadFixture('catalogue_identity.json');
    final accountId = AccountId(fixture['accountId']! as String);
    final similarity = fixture['similarity']! as Map<String, Object?>;
    final a = normalizeProductDraft(
      accountId: accountId,
      draft: _productDraft(similarity['inputA']! as Map<String, Object?>),
    );
    final b = normalizeProductDraft(
      accountId: accountId,
      draft: _productDraft(similarity['inputB']! as Map<String, Object?>),
    );

    expect(a.identityKey == b.identityKey, isFalse);
    expect(isSimilarButNotExact(a, b), isTrue);
    expect(a.id.value == b.id.value, isFalse);
  });

  test('rejects fractional count as durable identity quantity', () {
    expect(
      () => NormalizedQuantity.fromDecimalString(
        kind: MeasurementKind.count,
        unit: CanonicalUnit.unit,
        decimal: '1.5',
      ),
      throwsArgumentError,
    );
  });
}

ProductDraft _productDraft(Map<String, Object?> input) {
  return ProductDraft(
    userCode: (input['userCode'] as String?) ?? input['name']! as String,
    name: input['name']! as String,
    brand: input['brand']! as String,
    mode: _mode(input['mode']! as String),
    measurementKind: _kind(input['measurementKind']! as String),
    packageAmount: input['packageAmount'] as String?,
    packageUnit: input['packageUnit'] as String?,
  );
}

ProductMode _mode(String value) => switch (value) {
  'PACKAGED' => ProductMode.packaged,
  'BULK' => ProductMode.bulk,
  _ => throw ArgumentError('Unknown mode $value'),
};

MeasurementKind _kind(String value) => switch (value) {
  'MASS' => MeasurementKind.mass,
  'VOLUME' => MeasurementKind.volume,
  'COUNT' => MeasurementKind.count,
  _ => throw ArgumentError('Unknown kind $value'),
};
