import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:json_schema/json_schema.dart';

void main() {
  for (final name in [
    'catalogue_identity',
    'purchase_aggregate',
    'sync_event',
  ]) {
    test('$name example validates against v2 schema', () {
      final schemaJson = _loadJson('$name.schema.json');
      final exampleJson = _loadJson('$name.json');
      final schema = JsonSchema.create(schemaJson);

      final result = schema.validate(exampleJson, validateFormats: false);

      expect(result.isValid, isTrue, reason: result.errors.join('\n'));
    });
  }
}

Map<String, Object?> _loadJson(String name) {
  final file = File('../../contracts/shared_beta/v2/$name');
  return jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
}
