import '../shared/ids.dart';

enum LocalReferenceKind { person, paymentMethod }

final class LocalReference {
  const LocalReference({
    required this.id,
    required this.accountId,
    required this.kind,
    required this.nickname,
    required this.normalizedNickname,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    this.archivedAt,
  });

  final String id;
  final AccountId accountId;
  final LocalReferenceKind kind;
  final String nickname;
  final String normalizedNickname;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? archivedAt;

  String get historyLabel => active ? nickname : '$nickname (archived)';
}

String normalizeReferenceNickname(String value) =>
    value.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
