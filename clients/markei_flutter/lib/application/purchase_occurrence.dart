final class PurchaseOccurrenceInput {
  const PurchaseOccurrenceInput({
    required this.dateText,
    required this.timeText,
  });

  final String dateText;
  final String timeText;
}

DateTime parsePurchaseOccurrenceUtc(PurchaseOccurrenceInput input) {
  final dateMatch = RegExp(
    r'^(\d{2})/(\d{2})/(\d{4})$',
  ).firstMatch(input.dateText.trim());
  if (dateMatch == null) {
    throw const FormatException('Use dd/mm/yyyy for Purchase date.');
  }
  final timeMatch = RegExp(
    r'^(\d{2}):(\d{2})$',
  ).firstMatch(input.timeText.trim());
  if (timeMatch == null) {
    throw const FormatException('Use HH:mm for Purchase time.');
  }
  final day = int.parse(dateMatch.group(1)!);
  final month = int.parse(dateMatch.group(2)!);
  final year = int.parse(dateMatch.group(3)!);
  final hour = int.parse(timeMatch.group(1)!);
  final minute = int.parse(timeMatch.group(2)!);
  final local = DateTime(year, month, day, hour, minute);
  if (local.year != year ||
      local.month != month ||
      local.day != day ||
      local.hour != hour ||
      local.minute != minute) {
    throw const FormatException('Enter a valid Purchase date and time.');
  }
  return local.toUtc();
}
