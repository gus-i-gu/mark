import 'package:unorm_dart/unorm_dart.dart' as unorm;

final class ProductCode {
  const ProductCode({required this.displayValue, required this.normalizedKey});

  final String displayValue;
  final String normalizedKey;

  Map<String, Object?> toJson() => {
    'displayValue': displayValue,
    'normalizedKey': normalizedKey,
  };
}

ProductCode normalizeProductCode(String displayCode) {
  final displayValue = nfkcCollapse(displayCode);
  if (displayValue.isEmpty) {
    throw ArgumentError('Product code is required.');
  }
  if (displayValue.length > 64) {
    throw ArgumentError('Product code must be 1-64 characters after trim.');
  }
  return ProductCode(
    displayValue: displayValue,
    normalizedKey: displayValue.toLowerCase(),
  );
}

String nfkcCollapse(String value) {
  return unorm.nfkc(value).trim().replaceAll(RegExp(r'\s+'), ' ');
}
