import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Windows runtime packaging contract', () {
    late String runnerCMake;

    setUpAll(() {
      runnerCMake = File('windows/runner/CMakeLists.txt').readAsStringSync();
    });

    test('deploys the executable runtime closure from target metadata', () {
      expect(runnerCMake, contains(r'$<TARGET_RUNTIME_DLLS:${BINARY_NAME}>'));
      expect(runnerCMake, contains(r'$<TARGET_FILE_DIR:${BINARY_NAME}>'));
      expect(runnerCMake, contains('copy_if_different'));
      expect(runnerCMake, contains('COMMAND_EXPAND_LISTS'));
    });

    test('fails during configuration when runtime metadata is unavailable', () {
      expect(runnerCMake, contains('CMAKE_VERSION VERSION_LESS 3.21'));
      expect(runnerCMake, contains('message(FATAL_ERROR'));
      expect(
        runnerCMake,
        contains('target-level runtime dependency deployment'),
      );
    });

    test('keeps Debug and Release deployment configuration-derived', () {
      expect(runnerCMake, isNot(contains('cpprest_2_10.dll')));
      expect(runnerCMake, isNot(contains('debug/bin')));
      expect(runnerCMake, isNot(contains(r'debug\bin')));
      expect(runnerCMake, isNot(contains('Release/bin')));
      expect(runnerCMake, isNot(contains(r'Release\bin')));
    });

    test('does not introduce local machine paths', () {
      expect(runnerCMake, isNot(contains('vcpkg')));
      expect(runnerCMake, isNot(contains('VCPKG_ROOT')));
      expect(runnerCMake, isNot(contains('C:/')));
      expect(runnerCMake, isNot(contains(r'C:\')));
      expect(runnerCMake, isNot(matches(RegExp(r'[A-Za-z]:[\\/]'))));
      expect(runnerCMake, isNot(contains('gusrm')));
      expect(runnerCMake, isNot(contains('Gus')));
    });

    test('does not track generated Windows build artifacts', () {
      final result = Process.runSync('git', [
        'ls-files',
        'build',
        'windows/flutter/ephemeral',
        '*.dll',
        '*.exe',
      ], workingDirectory: Directory.current.path);
      expect(result.exitCode, 0, reason: result.stderr.toString());
      expect(result.stdout.toString().trim(), isEmpty);
    });
  });
}
