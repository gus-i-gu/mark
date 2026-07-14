import '../domain/purchase/purchase.dart';
import '../domain/shared/ids.dart';

sealed class StoreReference {
  const StoreReference();
}

final class ExistingStoreReference extends StoreReference {
  const ExistingStoreReference(this.storeId);

  final StoreId storeId;
}

final class NewStoreReference extends StoreReference {
  const NewStoreReference(this.displayName);

  final String displayName;
}

final class RegisterPurchaseCommand {
  RegisterPurchaseCommand({
    required this.accountId,
    required this.deviceId,
    String? storeName,
    StoreReference? storeReference,
    required this.occurrenceTime,
    required this.currencyCode,
    required this.items,
    this.personId,
    this.paymentMethodId,
  }) : storeReference =
           storeReference ?? NewStoreReference(storeName?.trim() ?? '');

  final AccountId accountId;
  final DeviceId deviceId;
  final StoreReference storeReference;
  final DateTime occurrenceTime;
  final String currencyCode;
  final List<PurchaseItemDraft> items;
  final String? personId;
  final String? paymentMethodId;
}

abstract interface class PurchaseRegistrationRepository {
  Future<PurchaseRegistrationResult> registerPurchase(
    RegisterPurchaseCommand command,
  );
}

final class PurchaseRegistrationResult {
  const PurchaseRegistrationResult({
    required this.purchaseId,
    required this.eventId,
    required this.deviceSequence,
  });

  final PurchaseId purchaseId;
  final EventId eventId;
  final int deviceSequence;
}
