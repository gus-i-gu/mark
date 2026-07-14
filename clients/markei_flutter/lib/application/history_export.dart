import 'dart:convert';

import '../domain/shared/ids.dart';
import 'purchase_history.dart';

final class PurchaseExportBundle {
  const PurchaseExportBundle({required this.purchases});

  final List<PurchaseDetail> purchases;
}

abstract interface class PurchaseExportRepository {
  Future<PurchaseExportBundle> exportBundle(
    AccountId accountId,
    Set<PurchaseId> purchaseIds,
  );
}

String purchaseBundleCsv(PurchaseExportBundle bundle) {
  final rows = <List<String>>[
    [
      'purchase_id',
      'occurrence_time',
      'store',
      'person',
      'payment_method',
      'currency',
      'purchase_total_minor_units',
      'product_code',
      'product_name',
      'product_brand',
      'package_count',
      'amount',
      'unit',
      'line_total_minor_units',
    ],
  ];
  for (final detail in bundle.purchases) {
    for (final item in detail.items) {
      rows.add([
        detail.entry.purchaseId.value,
        detail.entry.occurrenceTime.toUtc().toIso8601String(),
        detail.entry.storeName,
        detail.entry.personLabel ?? 'Not assigned',
        detail.entry.paymentMethodLabel ?? 'Not assigned',
        detail.entry.currencyCode,
        detail.entry.totalMinorUnits.toString(),
        item.productCode,
        item.productName,
        item.productBrand,
        item.packageCount?.toString() ?? 'Not assigned',
        item.purchasedAmount,
        item.purchasedUnit,
        item.lineTotalMinorUnits.toString(),
      ]);
    }
  }
  return rows.map((row) => row.map(_csvCell).join(',')).join('\r\n');
}

List<int> purchaseBundlePdfBytes(PurchaseExportBundle bundle) {
  final text = StringBuffer('Markei selected purchase list\n\n');
  for (final detail in bundle.purchases) {
    text.writeln(
      '${detail.entry.storeName} - ${detail.entry.occurrenceTime.toLocal()} - ${detail.entry.currencyCode} ${(detail.entry.totalMinorUnits / 100).toStringAsFixed(2)}',
    );
    text.writeln('Person: ${detail.entry.personLabel ?? 'Not assigned'}');
    text.writeln(
      'Payment Method: ${detail.entry.paymentMethodLabel ?? 'Not assigned'}',
    );
    for (final item in detail.items) {
      text.writeln(
        '- ${item.productCode} ${item.productName}: ${item.purchasedAmount} ${item.purchasedUnit} ${item.currencyCode} ${(item.lineTotalMinorUnits / 100).toStringAsFixed(2)}',
      );
    }
    text.writeln();
  }
  return _simplePdf(text.toString());
}

String _csvCell(String value) {
  final mustQuote =
      value.contains(',') || value.contains('"') || value.contains('\n');
  final escaped = value.replaceAll('"', '""');
  return mustQuote ? '"$escaped"' : escaped;
}

List<int> _simplePdf(String text) {
  final escaped = text
      .replaceAll('\\', r'\\')
      .replaceAll('(', r'\(')
      .replaceAll(')', r'\)')
      .replaceAll('\r', '')
      .split('\n')
      .map((line) => '($line) Tj T*')
      .join('\n');
  final stream = 'BT /F1 10 Tf 40 780 Td 14 TL\n$escaped\nET';
  final objects = <String>[
    '1 0 obj << /Type /Catalog /Pages 2 0 R >> endobj\n',
    '2 0 obj << /Type /Pages /Kids [3 0 R] /Count 1 >> endobj\n',
    '3 0 obj << /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Resources << /Font << /F1 4 0 R >> >> /Contents 5 0 R >> endobj\n',
    '4 0 obj << /Type /Font /Subtype /Type1 /BaseFont /Helvetica >> endobj\n',
    '5 0 obj << /Length ${ascii.encode(stream).length} >> stream\n$stream\nendstream endobj\n',
  ];
  final buffer = StringBuffer('%PDF-1.4\n');
  final offsets = <int>[0];
  var length = ascii.encode(buffer.toString()).length;
  for (final object in objects) {
    offsets.add(length);
    buffer.write(object);
    length += ascii.encode(object).length;
  }
  final xrefOffset = length;
  buffer.write('xref\n0 ${objects.length + 1}\n');
  buffer.write('0000000000 65535 f \n');
  for (final offset in offsets.skip(1)) {
    buffer.write('${offset.toString().padLeft(10, '0')} 00000 n \n');
  }
  buffer.write(
    'trailer << /Size ${objects.length + 1} /Root 1 0 R >>\nstartxref\n$xrefOffset\n%%EOF\n',
  );
  return ascii.encode(buffer.toString());
}
