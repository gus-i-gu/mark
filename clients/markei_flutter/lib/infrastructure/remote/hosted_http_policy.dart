import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

typedef HostedCorrelationSource = String Function();

final class HostedHttpPolicy {
  const HostedHttpPolicy({
    required this.origin,
    this.correlationSource = _defaultCorrelation,
  });

  final Uri origin;
  final HostedCorrelationSource correlationSource;

  Uri route(String path, [Map<String, String>? queryParameters]) {
    if (!_validOrigin(origin)) {
      throw const HostedOriginException();
    }
    if (!path.startsWith('/') || path.contains('\\')) {
      throw const HostedOriginException();
    }
    return origin.replace(
      path: _join(origin.path, path),
      queryParameters: queryParameters,
    );
  }

  String nextCorrelationId() => sanitizeCorrelation(correlationSource());
}

final class HostedOriginException implements Exception {
  const HostedOriginException();
}

String sanitizeCorrelation(String value) {
  final sanitized = value
      .replaceAll(RegExp(r'[\x00-\x1f\x7f]'), '-')
      .replaceAll(RegExp(r'[^A-Za-z0-9._:-]+'), '-');
  final trimmed = sanitized.length <= 96
      ? sanitized
      : sanitized.substring(0, 96);
  return trimmed.isEmpty ? _defaultCorrelation() : trimmed;
}

String correlationFingerprint(String value) {
  final digest = sha256
      .convert(utf8.encode(sanitizeCorrelation(value)))
      .toString();
  return digest.substring(0, 8);
}

String elapsedBand(Duration duration) {
  final ms = duration.inMilliseconds;
  if (ms < 0) return 'elapsed-unavailable';
  if (ms < 250) return 'lt-250ms';
  if (ms < 1000) return 'lt-1s';
  if (ms < 3000) return 'lt-3s';
  if (ms < 10000) return 'lt-10s';
  if (ms < 30000) return 'lt-30s';
  return 'gte-30s';
}

bool _validOrigin(Uri origin) =>
    origin.hasScheme &&
    origin.scheme == 'https' &&
    origin.host.isNotEmpty &&
    origin.userInfo.isEmpty &&
    !origin.hasQuery &&
    !origin.hasFragment;

String _join(String basePath, String path) {
  final prefix = basePath.endsWith('/')
      ? basePath.substring(0, basePath.length - 1)
      : basePath;
  return '$prefix$path';
}

String _defaultCorrelation() => const Uuid().v4();
