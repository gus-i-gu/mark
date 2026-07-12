import 'package:uuid/uuid.dart';

import '../shared/ids.dart';
import '../shared/quantity.dart';
import 'product_code.dart';

const int productNormalizationVersion = 2;

enum ProductMode { packaged, bulk }

const semanticPunctuationPattern = r'''[-_,.;:!?/\\()\[\]{}'""]+''';

final class Product {
  const Product({
    required this.id,
    required this.accountId,
    required this.userProductCode,
    required this.normalizationVersion,
    required this.displayName,
    required this.displayBrand,
    required this.normalizedName,
    required this.normalizedBrand,
    required this.mode,
    required this.measurementKind,
    this.packageQuantity,
  });

  final ProductId id;
  final AccountId accountId;
  final ProductCode userProductCode;
  final int normalizationVersion;
  final String displayName;
  final String displayBrand;
  final String normalizedName;
  final String normalizedBrand;
  final ProductMode mode;
  final MeasurementKind measurementKind;
  final NormalizedQuantity? packageQuantity;

  String get identityKey {
    final base = [
      accountId.value,
      'v$normalizationVersion',
      normalizedName,
      normalizedBrand,
      mode.name.toUpperCase(),
    ];
    if (mode == ProductMode.bulk) {
      return base.join('|');
    }
    final quantity = packageQuantity;
    if (quantity == null) {
      throw StateError('Packaged products require package quantity.');
    }
    return [
      ...base,
      measurementKind.name.toUpperCase(),
      quantity.decimalText,
      quantity.unit.name.toUpperCase(),
    ].join('|');
  }

  Map<String, Object?> toJson() => {
    'id': id.value,
    'accountId': accountId.value,
    'userProductCode': userProductCode.toJson(),
    'normalizationVersion': normalizationVersion,
    'displayName': displayName,
    'displayBrand': displayBrand,
    'normalizedName': normalizedName,
    'normalizedBrand': normalizedBrand,
    'mode': mode.name.toUpperCase(),
    'measurementKind': measurementKind.name.toUpperCase(),
    'packageQuantity': packageQuantity?.toJson(),
    'identityKey': identityKey,
  };
}

final class ProductDraft {
  const ProductDraft({
    required this.userCode,
    required this.name,
    required this.brand,
    required this.mode,
    required this.measurementKind,
    this.packageAmount,
    this.packageUnit,
  });

  final String userCode;
  final String name;
  final String brand;
  final ProductMode mode;
  final MeasurementKind measurementKind;
  final String? packageAmount;
  final String? packageUnit;
}

final class NormalizedProductFacts {
  const NormalizedProductFacts({
    required this.displayName,
    required this.displayBrand,
    required this.normalizedName,
    required this.normalizedBrand,
    required this.packageQuantity,
  });

  final String displayName;
  final String displayBrand;
  final String normalizedName;
  final String normalizedBrand;
  final NormalizedQuantity? packageQuantity;
}

Product createProductFromDraft({
  required AccountId accountId,
  required ProductDraft draft,
  ProductId? id,
  Uuid uuid = const Uuid(),
}) {
  final facts = normalizeProductFacts(draft);
  return Product(
    id: id ?? ProductId(uuid.v4()),
    accountId: accountId,
    userProductCode: normalizeProductCode(draft.userCode),
    normalizationVersion: productNormalizationVersion,
    displayName: facts.displayName,
    displayBrand: facts.displayBrand,
    normalizedName: facts.normalizedName,
    normalizedBrand: facts.normalizedBrand,
    mode: draft.mode,
    measurementKind: draft.measurementKind,
    packageQuantity: facts.packageQuantity,
  );
}

Product normalizeProductDraft({
  required AccountId accountId,
  required ProductDraft draft,
}) {
  return createProductFromDraft(accountId: accountId, draft: draft);
}

NormalizedProductFacts normalizeProductFacts(ProductDraft draft) {
  final displayName = draft.name.trim();
  if (displayName.isEmpty) {
    throw ArgumentError('Product display name is required.');
  }
  final displayBrand = draft.brand.trim();
  final packageQuantity = switch (draft.mode) {
    ProductMode.packaged => normalizeDisplayQuantity(
      kind: draft.measurementKind,
      amount: draft.packageAmount ?? '',
      unit: draft.packageUnit ?? '',
    ),
    ProductMode.bulk => null,
  };
  return NormalizedProductFacts(
    displayName: displayName,
    displayBrand: displayBrand,
    normalizedName: normalizeSemanticIdentityText(displayName),
    normalizedBrand: normalizeSemanticIdentityText(displayBrand),
    packageQuantity: packageQuantity,
  );
}

String normalizeSemanticIdentityText(String value) {
  final normalized = nfkcCollapse(value).toLowerCase();
  return normalized
      .replaceAll(RegExp(semanticPunctuationPattern), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}

String normalizeIdentityText(String value) =>
    normalizeSemanticIdentityText(value);

bool isSimilarButNotExact(Product a, Product b) {
  if (a.identityKey == b.identityKey) {
    return false;
  }
  if (a.accountId.value != b.accountId.value || a.mode != b.mode) {
    return false;
  }
  return _editDistance(a.normalizedName, b.normalizedName) <= 2 ||
      a.normalizedName.contains(b.normalizedName) ||
      b.normalizedName.contains(a.normalizedName);
}

int _editDistance(String a, String b) {
  final rows = List.generate(
    a.length + 1,
    (i) =>
        List<int>.generate(b.length + 1, (j) => i == 0 ? j : (j == 0 ? i : 0)),
  );
  for (var i = 1; i <= a.length; i++) {
    for (var j = 1; j <= b.length; j++) {
      final cost = a.codeUnitAt(i - 1) == b.codeUnitAt(j - 1) ? 0 : 1;
      rows[i][j] = [
        rows[i - 1][j] + 1,
        rows[i][j - 1] + 1,
        rows[i - 1][j - 1] + cost,
      ].reduce((value, element) => value < element ? value : element);
    }
  }
  return rows[a.length][b.length];
}
