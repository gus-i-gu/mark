import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Windows auth0flutter protocol registration contract', () {
    late String script;
    late String readme;

    setUpAll(() {
      script = File(
        'tool/register_windows_auth0flutter_protocol.ps1',
      ).readAsStringSync();
      readme = File('README.md').readAsStringSync();
    });

    test(
      'registers current-user protocol with quoted executable and argument',
      () {
        expect(script, contains(r'HKCU:\Software\Classes\auth0flutter'));
        expect(script, contains(r'$quotedCommand'));
        expect(script, contains("'\"{0}\" \"%1\"'"));
        expect(
          script,
          contains(r'Set-Item -Path $commandPath -Value $quotedCommand'),
        );
        expect(script, isNot(contains('HKLM:')));
        expect(script, isNot(contains('Start-Process')));
        expect(script, isNot(contains('runAs')));
      },
    );

    test('contains no provider configuration or callback data', () {
      for (final forbidden in [
        'clientId',
        'tenant',
        'auth0.com',
        'https://',
        'http://',
        'callback?',
        'access_token',
        'refresh_token',
      ]) {
        expect(script, isNot(contains(forbidden)), reason: forbidden);
      }
    });

    test('documents Windows setup using placeholders only', () {
      expect(readme, contains('VCPKG_ROOT'));
      expect(readme, contains('CMAKE_TOOLCHAIN_FILE'));
      expect(readme, contains('cpprestsdk:x64-windows'));
      expect(readme, contains('MARKEI_NATIVE_CLOSURE_SURFACE=true'));
      expect(readme, contains('<path-to-vcpkg>'));
      expect(readme, contains('<path-to-built-markei.exe>'));
      expect(readme, isNot(contains('auth0.com')));
      expect(readme, isNot(contains('clientId')));
    });
  });
}
