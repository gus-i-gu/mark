import '../domain/shared/quantity.dart';

int bulkLineTotalMinorUnits({
  required MeasurementKind kind,
  required String amount,
  required String amountUnit,
  required String pricePerSelectedUnit,
}) {
  final unit = amountUnit.trim().toLowerCase();
  final amountMicros = _amountMicrosForSelectedUnit(
    kind: kind,
    amount: amount,
    unit: unit,
  );
  final rateMicroMinor = _parseRateMicroMinor(pricePerSelectedUnit);
  return (amountMicros * rateMicroMinor + 500000000000) ~/ 1000000000000;
}

int _amountMicrosForSelectedUnit({
  required MeasurementKind kind,
  required String amount,
  required String unit,
}) {
  if (kind == MeasurementKind.mass && (unit == 'kg' || unit == 'g')) {
    return parseDisplayDecimalMicrounits(amount);
  }
  if (kind == MeasurementKind.volume && (unit == 'l' || unit == 'ml')) {
    return parseDisplayDecimalMicrounits(amount);
  }
  if (kind == MeasurementKind.count && (unit == 'un' || unit == 'unit')) {
    return parseDisplayDecimalMicrounits(amount);
  }
  throw ArgumentError('Price unit must match the selected amount unit.');
}

int _parseRateMicroMinor(String value) {
  final trimmed = value.trim();
  if (trimmed.contains(',') && trimmed.contains('.')) {
    throw ArgumentError('Use one decimal separator for price.');
  }
  final normalized = trimmed.replaceAll(',', '.');
  final match = RegExp(r'^(\d+)(?:\.(\d{1,6}))?$').firstMatch(normalized);
  if (match == null) {
    throw ArgumentError('Enter price per selected unit.');
  }
  final major = int.parse(match.group(1)!);
  final fraction = (match.group(2) ?? '').padRight(6, '0');
  return (major * 1000000 + int.parse(fraction)) * 100;
}
