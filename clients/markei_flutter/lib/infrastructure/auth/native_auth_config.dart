import 'package:flutter/foundation.dart';

enum NativeAuthPlatform { android, windows, unsupported }

sealed class NativeAuthConfigurationResult {
  const NativeAuthConfigurationResult();
}

final class NativeAuthConfigurationReady extends NativeAuthConfigurationResult {
  const NativeAuthConfigurationReady(this.configuration);

  final NativeAuthConfiguration configuration;
}

final class NativeAuthConfigurationUnavailable
    extends NativeAuthConfigurationResult {
  const NativeAuthConfigurationUnavailable(this.reason);

  final String reason;
}

final class NativeAuthConfiguration {
  const NativeAuthConfiguration({
    required this.domain,
    required this.clientId,
    required this.audience,
    required this.hostedOrigin,
    required this.platform,
    required this.androidApplicationId,
    required this.windowsCallbackUrl,
  });

  static const defaultAndroidApplicationId = 'com.gusigu.markei';
  static const defaultWindowsCallbackUrl = 'auth0flutter://callback';

  final String domain;
  final String clientId;
  final String audience;
  final Uri hostedOrigin;
  final NativeAuthPlatform platform;
  final String androidApplicationId;
  final String windowsCallbackUrl;

  String get androidCallbackUrl =>
      'https://$domain/android/$androidApplicationId/callback';

  String get androidLogoutUrl =>
      'https://$domain/android/$androidApplicationId/callback';

  String get windowsCallback => windowsCallbackUrl;
  String get windowsLogout => windowsCallbackUrl;

  static NativeAuthConfigurationResult fromEnvironment({
    TargetPlatform? targetPlatform,
    String domain = const String.fromEnvironment('MARKEI_AUTH0_DOMAIN'),
    String androidClientId = const String.fromEnvironment(
      'MARKEI_AUTH0_ANDROID_CLIENT_ID',
    ),
    String windowsClientId = const String.fromEnvironment(
      'MARKEI_AUTH0_WINDOWS_CLIENT_ID',
    ),
    String audience = const String.fromEnvironment('MARKEI_AUTH0_AUDIENCE'),
    String hostedOrigin = const String.fromEnvironment(
      'MARKEI_HOSTED_HTTPS_ORIGIN',
    ),
  }) {
    final platform = _nativePlatform(targetPlatform ?? defaultTargetPlatform);
    final clientId = switch (platform) {
      NativeAuthPlatform.android => androidClientId,
      NativeAuthPlatform.windows => windowsClientId,
      NativeAuthPlatform.unsupported => '',
    };
    return validate(
      domain: domain,
      clientId: clientId,
      audience: audience,
      hostedOrigin: hostedOrigin,
      platform: platform,
    );
  }

  static NativeAuthConfigurationResult validate({
    required String domain,
    required String clientId,
    required String audience,
    required String hostedOrigin,
    required NativeAuthPlatform platform,
  }) {
    final normalizedDomain = domain.trim().toLowerCase();
    final normalizedClientId = clientId.trim();
    final normalizedAudience = audience.trim();
    final origin = Uri.tryParse(hostedOrigin.trim());
    if (platform == NativeAuthPlatform.unsupported) {
      return const NativeAuthConfigurationUnavailable('platform-unsupported');
    }
    if (!_isDomain(normalizedDomain)) {
      return const NativeAuthConfigurationUnavailable('configuration-invalid');
    }
    if (normalizedClientId.isEmpty ||
        normalizedClientId.contains(RegExp(r'\s'))) {
      return const NativeAuthConfigurationUnavailable('configuration-invalid');
    }
    if (!_isHttpsUri(normalizedAudience)) {
      return const NativeAuthConfigurationUnavailable('configuration-invalid');
    }
    if (origin == null ||
        origin.scheme != 'https' ||
        origin.host.isEmpty ||
        origin.hasQuery ||
        origin.hasFragment ||
        origin.userInfo.isNotEmpty) {
      return const NativeAuthConfigurationUnavailable('configuration-invalid');
    }
    return NativeAuthConfigurationReady(
      NativeAuthConfiguration(
        domain: normalizedDomain,
        clientId: normalizedClientId,
        audience: normalizedAudience,
        hostedOrigin: origin,
        platform: platform,
        androidApplicationId: defaultAndroidApplicationId,
        windowsCallbackUrl: defaultWindowsCallbackUrl,
      ),
    );
  }

  static NativeAuthPlatform _nativePlatform(TargetPlatform platform) {
    return switch (platform) {
      TargetPlatform.android => NativeAuthPlatform.android,
      TargetPlatform.windows => NativeAuthPlatform.windows,
      _ => NativeAuthPlatform.unsupported,
    };
  }

  static bool _isDomain(String value) {
    if (value.isEmpty ||
        value.length > 253 ||
        value.contains('/') ||
        value.contains(':') ||
        value.startsWith('.') ||
        value.endsWith('.')) {
      return false;
    }
    return RegExp(r'^[a-z0-9][a-z0-9.-]*[a-z0-9]$').hasMatch(value) &&
        value.contains('.');
  }

  static bool _isHttpsUri(String value) {
    final uri = Uri.tryParse(value);
    return uri != null &&
        uri.scheme == 'https' &&
        uri.host.isNotEmpty &&
        uri.userInfo.isEmpty;
  }
}
