import 'dart:convert';
import 'dart:io';

Map<String, Object?> loadFixture(String name) {
  final file = File('../../contracts/shared_beta/v2/$name');
  return jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
}

Map<String, Object?> loadVersionedFixture(String version, String name) {
  final file = File('../../contracts/shared_beta/$version/$name');
  return jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
}
