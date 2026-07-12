import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/register_purchase.dart';
import 'package:markei/domain/catalogue/product.dart';
import 'package:markei/domain/purchase/purchase.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/money.dart';
import 'package:markei/domain/shared/quantity.dart';
import 'package:markei/infrastructure/local/local_database.dart';
import 'package:markei/infrastructure/local/local_purchase_repository.dart';

void main() {
  test(
    'device sequence increments monotonically and skips rolled back writes',
    () async {
      final db = LocalDatabase.memory();
      addTearDown(db.close);
      final repository = LocalPurchaseRepository(db);

      final first = await repository.registerPurchase(_command('ARROZ-001'));
      final second = await repository.registerPurchase(_command('FEIJAO-001'));
      await expectLater(
        repository.registerPurchase(_command('CAFE-001', packageCount: 0)),
        throwsArgumentError,
      );
      final third = await repository.registerPurchase(_command('BANANA-001'));

      expect(first.deviceSequence, 1);
      expect(second.deviceSequence, 2);
      expect(third.deviceSequence, 3);
      expect(await db.select(db.syncEvents).get(), hasLength(3));
    },
  );
}

RegisterPurchaseCommand _command(String code, {int packageCount = 1}) {
  return RegisterPurchaseCommand(
    accountId: const AccountId('11111111-1111-4111-8111-111111111111'),
    deviceId: const DeviceId('22222222-2222-4222-8222-222222222222'),
    storeName: 'Mercado Central',
    occurrenceTime: DateTime.utc(2026, 7, 12, 12, 30),
    currencyCode: 'BRL',
    items: [
      PurchaseItemDraft(
        productReference: NewProductReference(
          ProductDraft(
            userCode: code,
            name: 'Produto $code',
            brand: 'Marca A',
            mode: ProductMode.packaged,
            measurementKind: MeasurementKind.mass,
            packageAmount: '1',
            packageUnit: 'kg',
          ),
        ),
        packageCount: packageCount,
        purchasedQuantity: NormalizedQuantity.fromDecimalString(
          kind: MeasurementKind.mass,
          unit: CanonicalUnit.kg,
          decimal: '1',
        ),
        lineTotal: const Money(currencyCode: 'BRL', minorUnits: 100),
      ),
    ],
  );
}
