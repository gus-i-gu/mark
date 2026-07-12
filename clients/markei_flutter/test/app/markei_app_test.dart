import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/app/markei_app.dart';
import 'package:markei/app/markei_composition.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/infrastructure/local/local_database.dart';
import 'package:markei/infrastructure/local/local_purchase_repository.dart';
import 'package:markei/infrastructure/local/local_query_repository.dart';

void main() {
  testWidgets('registers a multi-item purchase and shows history', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final queries = LocalQueryRepository(db);
    final composition = MarkeiComposition(
      database: db,
      purchaseRegistration: LocalPurchaseRepository(db),
      catalogueQueries: queries,
      purchaseHistory: queries,
      accountId: const AccountId('11111111-1111-4111-8111-111111111111'),
      deviceId: const DeviceId('22222222-2222-4222-8222-222222222222'),
    );

    await tester.pumpWidget(MarkeiApp(composition: composition));

    await _stageItem(
      tester,
      code: 'ARROZ-001',
      name: 'Arroz Branco',
      total: '12.99',
    );
    await _stageItem(
      tester,
      code: 'FEIJAO-001',
      name: 'Feijao Preto',
      total: '8.50',
    );
    await tester.tap(find.byKey(const Key('purchase.register')));
    await tester.pumpAndSettle();

    expect(find.textContaining('Device sequence 1'), findsOneWidget);

    await tester.tap(find.text('History'));
    await tester.pumpAndSettle();

    expect(find.text('Mercado Central'), findsOneWidget);
    expect(find.text('2 item(s)'), findsOneWidget);
    expect(find.text('BRL 21.49'), findsOneWidget);
  });
}

Future<void> _stageItem(
  WidgetTester tester, {
  required String code,
  required String name,
  required String total,
}) async {
  await tester.enterText(find.byKey(const Key('product.code')), code);
  await tester.enterText(find.byKey(const Key('product.name')), name);
  await tester.enterText(find.byKey(const Key('product.brand')), 'Marca A');
  await tester.enterText(find.byKey(const Key('item.lineTotal')), total);
  await tester.tap(find.byKey(const Key('item.add')));
  await tester.pumpAndSettle();
}
