import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/app_failure.dart';
import 'package:markei/application/history_export.dart';
import 'package:markei/application/purchase_history.dart';
import 'package:markei/application/register_purchase.dart';
import 'package:markei/app/markei_app.dart';
import 'package:markei/app/markei_composition.dart';
import 'package:markei/app/pages/history_page.dart';
import 'package:markei/domain/catalogue/product.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/quantity.dart';
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
    await queries.createStore(
      const AccountId('11111111-1111-4111-8111-111111111111'),
      'Mercado Central',
    );
    final composition = MarkeiComposition(
      database: db,
      purchaseRegistration: LocalPurchaseRepository(db),
      catalogueQueries: queries,
      purchaseHistory: queries,
      references: queries,
      preferences: queries,
      productLists: queries,
      purchaseExports: queries,
      accountId: const AccountId('11111111-1111-4111-8111-111111111111'),
      deviceId: const DeviceId('22222222-2222-4222-8222-222222222222'),
    );

    await tester.pumpWidget(MarkeiApp(composition: composition));
    await _pumpReady(tester);

    expect(find.byKey(const Key('markei.navigationRail')), findsOneWidget);
    expect(find.byKey(const Key('markei.navigationBar')), findsNothing);
    expect(find.byKey(const Key('home.page')), findsOneWidget);

    await tester.tap(find.text('Purchase'));
    await _pumpReady(tester);
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
    await _enterPurchaseMoment(tester);
    await tester.tap(find.byKey(const Key('purchase.review')));
    await _pumpReady(tester);
    await tester.tap(find.byKey(const Key('purchase.register')));
    await _pumpReady(tester);

    expect(find.text('Purchase registered locally.'), findsOneWidget);
    expect(find.textContaining('Device sequence'), findsNothing);

    await tester.tap(find.text('History'));
    await _pumpReady(tester);

    expect(find.text('Mercado Central'), findsOneWidget);
    expect(find.textContaining('2 Purchase Item(s)'), findsOneWidget);
    expect(find.text('BRL 21.49'), findsOneWidget);
  });

  testWidgets('editing an existing Product Item preserves Product identity', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final queries = LocalQueryRepository(db);
    await queries.createStore(
      const AccountId('11111111-1111-4111-8111-111111111111'),
      'Mercado Central',
    );
    final product = await queries.createProduct(
      const AccountId('11111111-1111-4111-8111-111111111111'),
      const ProductDraft(
        userCode: 'CAFE-001',
        name: 'Cafe Especial',
        brand: 'Marca A',
        mode: ProductMode.packaged,
        measurementKind: MeasurementKind.mass,
        packageAmount: '1',
        packageUnit: 'kg',
      ),
    );
    final composition = MarkeiComposition(
      database: db,
      purchaseRegistration: LocalPurchaseRepository(db),
      catalogueQueries: queries,
      purchaseHistory: queries,
      references: queries,
      preferences: queries,
      productLists: queries,
      purchaseExports: queries,
      accountId: const AccountId('11111111-1111-4111-8111-111111111111'),
      deviceId: const DeviceId('22222222-2222-4222-8222-222222222222'),
    );

    await tester.pumpWidget(MarkeiApp(composition: composition));
    await _pumpReady(tester);

    await tester.tap(find.text('Purchase'));
    await _pumpReady(tester);
    await _enterVisibleText(
      tester,
      find.byKey(const Key('item.lineTotal')),
      '10.00',
    );
    await _tapVisible(tester, find.byKey(const Key('purchase.product.select')));
    await _pumpReady(tester);
    await tester.tap(find.text('CAFE-001 · Cafe Especial').last);
    await _pumpReady(tester);
    await _tapVisible(tester, find.byKey(const Key('product.useSelected')));
    await _pumpReady(tester);

    await _tapVisible(tester, find.byKey(const Key('purchase.line.edit.1')));
    await _enterVisibleText(
      tester,
      find.byKey(const Key('item.packageCount')),
      '3',
    );
    await _enterVisibleText(
      tester,
      find.byKey(const Key('item.quantity')),
      '2',
    );
    await _enterVisibleText(
      tester,
      find.byKey(const Key('item.lineTotal')),
      '15.50',
    );
    await _tapVisible(tester, find.byKey(const Key('item.add')));
    await _enterPurchaseMoment(tester);
    await _tapVisible(tester, find.byKey(const Key('purchase.review')));
    await _pumpReady(tester);
    await _tapVisible(tester, find.byKey(const Key('purchase.register')));
    await _pumpReady(tester);

    final products = await queries.listProducts(composition.accountId);
    expect(products, hasLength(1));
    expect(products.single.id.value, product.id.value);

    final purchases = await queries.listRecentPurchases(composition.accountId);
    final detail = await queries.getPurchaseDetail(
      composition.accountId,
      purchases.single.purchaseId,
    );
    final item = detail!.items.single;
    expect(item.productId.value, product.id.value);
    expect(item.packageCount, 3);
    expect(item.purchasedAmount, '2.000000');
    expect(item.lineTotalMinorUnits, 1550);
  });

  testWidgets('phone-width shell shows purchase and history states', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final queries = LocalQueryRepository(db);
    await queries.createStore(
      const AccountId('11111111-1111-4111-8111-111111111111'),
      'Mercado Central',
    );
    final composition = MarkeiComposition(
      database: db,
      purchaseRegistration: LocalPurchaseRepository(db),
      catalogueQueries: queries,
      purchaseHistory: queries,
      references: queries,
      preferences: queries,
      productLists: queries,
      purchaseExports: queries,
      accountId: const AccountId('11111111-1111-4111-8111-111111111111'),
      deviceId: const DeviceId('22222222-2222-4222-8222-222222222222'),
    );

    await tester.pumpWidget(MarkeiApp(composition: composition));
    await _pumpReady(tester);

    expect(find.byKey(const Key('markei.navigationBar')), findsOneWidget);
    expect(find.byKey(const Key('markei.navigationRail')), findsNothing);

    expect(find.byKey(const Key('home.page')), findsOneWidget);

    await tester.tap(find.text('Purchase'));
    await _pumpReady(tester);

    expect(find.byKey(const Key('purchase.localNotice')), findsOneWidget);

    await tester.tap(find.text('History'));
    await _pumpReady(tester);

    expect(find.byKey(const Key('history.empty')), findsOneWidget);
  });

  testWidgets('selected destination survives narrow to wide layout change', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final queries = LocalQueryRepository(db);
    await queries.createStore(
      const AccountId('11111111-1111-4111-8111-111111111111'),
      'Mercado Central',
    );
    final composition = MarkeiComposition(
      database: db,
      purchaseRegistration: LocalPurchaseRepository(db),
      catalogueQueries: queries,
      purchaseHistory: queries,
      references: queries,
      preferences: queries,
      productLists: queries,
      purchaseExports: queries,
      accountId: const AccountId('11111111-1111-4111-8111-111111111111'),
      deviceId: const DeviceId('22222222-2222-4222-8222-222222222222'),
    );

    await tester.pumpWidget(MarkeiApp(composition: composition));
    await _pumpReady(tester);

    await tester.tap(find.text('History'));
    await _pumpReady(tester);

    expect(find.byKey(const Key('history.empty')), findsOneWidget);

    tester.view.physicalSize = const Size(1200, 1600);
    await _pumpReady(tester);

    expect(find.byKey(const Key('markei.navigationRail')), findsOneWidget);
    expect(find.byKey(const Key('markei.navigationBar')), findsNothing);
    expect(find.byKey(const Key('history.empty')), findsOneWidget);
  });

  testWidgets('history separates loading, error, and empty states', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: HistoryPage(
          accountId: const AccountId('11111111-1111-4111-8111-111111111111'),
          history: _FailingThenEmptyHistory(),
          exports: _EmptyExportRepository(),
          refreshSignal: 0,
        ),
      ),
    );

    await tester.pump();

    expect(find.byKey(const Key('history.loading')), findsOneWidget);

    await _pumpReady(tester);

    expect(find.byKey(const Key('history.error')), findsOneWidget);
    expect(find.textContaining('Exception'), findsNothing);

    await tester.tap(find.byKey(const Key('history.retry')));
    await tester.pump();

    expect(find.byKey(const Key('history.loading')), findsOneWidget);

    await _pumpReady(tester);

    expect(find.byKey(const Key('history.empty')), findsOneWidget);
  });

  testWidgets('Products can create, search, and report no match', (
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
      references: queries,
      preferences: queries,
      productLists: queries,
      purchaseExports: queries,
      accountId: const AccountId('11111111-1111-4111-8111-111111111111'),
      deviceId: const DeviceId('22222222-2222-4222-8222-222222222222'),
    );

    await tester.pumpWidget(MarkeiApp(composition: composition));
    await _pumpReady(tester);

    await tester.tap(find.text('Catalogue'));
    await _pumpReady(tester);

    expect(find.byKey(const Key('stores.empty')), findsOneWidget);
    await _enterVisibleText(
      tester,
      find.byKey(const Key('stores.create.name')),
      '  Mercado Central  ',
    );
    await _tapVisible(tester, find.byKey(const Key('stores.create')));
    await _pumpReady(tester);

    final stores = await queries.listStores(composition.accountId);
    expect(stores.single.displayName, 'Mercado Central');
    expect(find.text('Mercado Central'), findsOneWidget);
    expect(find.byKey(const Key('products.empty')), findsOneWidget);

    await _enterVisibleText(
      tester,
      find.byKey(const Key('products.create.code')),
      'ARROZ-100',
    );
    await _enterVisibleText(
      tester,
      find.byKey(const Key('products.create.name')),
      'Arroz Integral',
    );
    await _enterVisibleText(
      tester,
      find.byKey(const Key('products.create.brand')),
      'Marca B',
    );
    await _tapVisible(tester, find.byKey(const Key('products.createAnyway')));
    await _pumpReady(tester);

    final products = await queries.listProducts(composition.accountId);
    expect(products.single.displayName, 'Arroz Integral');
    expect(find.text('Arroz Integral'), findsOneWidget);

    await _enterVisibleText(
      tester,
      find.byKey(const Key('products.search')),
      'banana',
    );
    await _pumpReady(tester);

    expect(find.byKey(const Key('products.noMatch')), findsOneWidget);
  });

  testWidgets('History detail shows Purchase Items and price change', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final queries = LocalQueryRepository(db);
    await queries.createStore(
      const AccountId('11111111-1111-4111-8111-111111111111'),
      'Mercado Central',
    );
    final composition = MarkeiComposition(
      database: db,
      purchaseRegistration: LocalPurchaseRepository(db),
      catalogueQueries: queries,
      purchaseHistory: queries,
      references: queries,
      preferences: queries,
      productLists: queries,
      purchaseExports: queries,
      accountId: const AccountId('11111111-1111-4111-8111-111111111111'),
      deviceId: const DeviceId('22222222-2222-4222-8222-222222222222'),
    );

    await tester.pumpWidget(MarkeiApp(composition: composition));
    await _pumpReady(tester);

    await tester.tap(find.text('Purchase'));
    await _pumpReady(tester);
    await _registerSingleItemPurchase(
      tester,
      code: 'LEITE-001',
      name: 'Leite Po',
      total: '10.00',
    );
    await _registerSingleItemPurchase(
      tester,
      code: 'LEITE-002',
      name: 'Leite Po',
      total: '12.00',
    );

    await tester.tap(find.text('History'));
    await _pumpReady(tester);
    await tester.tap(find.text('Mercado Central').first);
    await _pumpReady(tester);

    expect(find.byKey(const Key('history.detail')), findsOneWidget);
    expect(find.text('Leite Po'), findsOneWidget);
    expect(find.byKey(const Key('history.price.change')), findsOneWidget);
  });

  testWidgets('Purchase requires an existing Store', (tester) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final queries = LocalQueryRepository(db);
    final composition = _composition(
      db: db,
      queries: queries,
      registration: LocalPurchaseRepository(db),
    );

    await tester.pumpWidget(MarkeiApp(composition: composition));
    await _pumpReady(tester);

    await tester.tap(find.text('Purchase'));
    await _pumpReady(tester);
    expect(find.byKey(const Key('purchase.store.required')), findsOneWidget);

    await _stageItem(
      tester,
      code: 'ARROZ-001',
      name: 'Arroz Branco',
      total: '12.99',
    );
    await _enterPurchaseMoment(tester);
    await _tapVisible(tester, find.byKey(const Key('purchase.review')));
    await _pumpReady(tester);
    await _tapVisible(tester, find.byKey(const Key('purchase.register')));
    await _pumpReady(tester);

    expect(find.textContaining('Create a Store in Catalogue'), findsOneWidget);
    expect(find.byKey(const Key('purchase.line.1')), findsOneWidget);
  });

  testWidgets('registration failure preserves the staged draft', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final queries = LocalQueryRepository(db);
    await queries.createStore(
      const AccountId('11111111-1111-4111-8111-111111111111'),
      'Mercado Central',
    );
    final composition = _composition(
      db: db,
      queries: queries,
      registration: const _ThrowingRegistration(
        AppFailure(
          code: 'missing-store',
          operation: 'Purchase registration',
          field: 'Store',
          recovery: 'Choose an existing Store for this account.',
          retryable: true,
          outcome: FailureOutcome.notApplied,
        ),
      ),
    );

    await tester.pumpWidget(MarkeiApp(composition: composition));
    await _pumpReady(tester);

    await tester.tap(find.text('Purchase'));
    await _pumpReady(tester);
    await _registerAttempt(tester);

    expect(find.byKey(const Key('purchase.line.1')), findsOneWidget);
    expect(find.textContaining('missing-store'), findsOneWidget);
    expect(
      find.textContaining('The draft is still available.'),
      findsOneWidget,
    );
  });

  testWidgets('typed AppFailure produces sanitized UI diagnostics', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final queries = LocalQueryRepository(db);
    await queries.createStore(
      const AccountId('11111111-1111-4111-8111-111111111111'),
      'Mercado Central',
    );
    final composition = _composition(
      db: db,
      queries: queries,
      registration: const _ThrowingRegistration(
        AppFailure(
          code: 'invalid-package-count',
          operation: 'Purchase registration',
          field: 'Packages bought',
          recovery: 'Enter a positive whole package count.',
          retryable: true,
          outcome: FailureOutcome.notApplied,
        ),
      ),
    );

    await tester.pumpWidget(MarkeiApp(composition: composition));
    await _pumpReady(tester);

    await tester.tap(find.text('Purchase'));
    await _pumpReady(tester);
    await _registerAttempt(tester);

    expect(find.textContaining('invalid-package-count'), findsOneWidget);
    expect(find.textContaining('StackTrace'), findsNothing);
    expect(find.textContaining('SELECT'), findsNothing);
    expect(find.textContaining('11111111-1111'), findsNothing);
  });

  testWidgets(
    'unexpected failure produces a stable generic code and logs no provider credentials or facts',
    (tester) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final db = LocalDatabase.memory();
      addTearDown(db.close);
      final queries = LocalQueryRepository(db);
      await queries.createStore(
        const AccountId('11111111-1111-4111-8111-111111111111'),
        'Mercado Central',
      );
      final composition = _composition(
        db: db,
        queries: queries,
        registration: _ThrowingRegistration(
          StateError('SELECT internal from C:\\internal\\file 11111111-1111'),
        ),
      );

      await tester.pumpWidget(MarkeiApp(composition: composition));
      await _pumpReady(tester);

      await tester.tap(find.text('Purchase'));
      await _pumpReady(tester);
      await _registerAttempt(tester);

      expect(
        find.textContaining('purchase-registration-unknown'),
        findsOneWidget,
      );
      expect(find.textContaining('SELECT internal'), findsNothing);
      expect(find.textContaining('C:\\internal'), findsNothing);
      expect(find.textContaining('11111111-1111'), findsNothing);
      expect(find.byKey(const Key('purchase.line.1')), findsOneWidget);
    },
  );
}

final class _FailingThenEmptyHistory implements PurchaseHistoryRepository {
  var _attempts = 0;

  @override
  Future<List<PurchaseHistoryEntry>> listRecentPurchases(AccountId accountId) {
    _attempts++;
    if (_attempts == 1) {
      return Future<List<PurchaseHistoryEntry>>.delayed(
        Duration.zero,
        () => throw StateError('database unavailable'),
      );
    }
    return Future<List<PurchaseHistoryEntry>>.delayed(
      Duration.zero,
      () => const <PurchaseHistoryEntry>[],
    );
  }

  @override
  Future<PurchaseDetail?> getPurchaseDetail(
    AccountId accountId,
    PurchaseId purchaseId,
  ) async {
    return null;
  }

  @override
  Future<PriceChangeResult> priceChangeForProduct(
    AccountId accountId,
    ProductId productId,
  ) async {
    return const PriceChangeUnavailable('Not enough comparable purchases.');
  }
}

final class _EmptyExportRepository implements PurchaseExportRepository {
  @override
  Future<PurchaseExportBundle> exportBundle(
    AccountId accountId,
    Set<PurchaseId> purchaseIds,
  ) async {
    return const PurchaseExportBundle(purchases: []);
  }
}

final class _ThrowingRegistration implements PurchaseRegistrationRepository {
  const _ThrowingRegistration(this.error);

  final Object error;

  @override
  Future<PurchaseRegistrationResult> registerPurchase(
    RegisterPurchaseCommand command,
  ) async {
    throw error;
  }
}

MarkeiComposition _composition({
  required LocalDatabase db,
  required LocalQueryRepository queries,
  required PurchaseRegistrationRepository registration,
}) {
  return MarkeiComposition(
    database: db,
    purchaseRegistration: registration,
    catalogueQueries: queries,
    purchaseHistory: queries,
    references: queries,
    preferences: queries,
    productLists: queries,
    purchaseExports: queries,
    accountId: const AccountId('11111111-1111-4111-8111-111111111111'),
    deviceId: const DeviceId('22222222-2222-4222-8222-222222222222'),
  );
}

Future<void> _stageItem(
  WidgetTester tester, {
  required String code,
  required String name,
  required String total,
}) async {
  await _enterVisibleText(tester, find.byKey(const Key('product.code')), code);
  await _enterVisibleText(tester, find.byKey(const Key('product.name')), name);
  await _enterVisibleText(
    tester,
    find.byKey(const Key('product.brand')),
    'Marca A',
  );
  await _enterVisibleText(
    tester,
    find.byKey(const Key('item.lineTotal')),
    total,
  );
  await _tapVisible(tester, find.byKey(const Key('item.add')));
  await _pumpReady(tester);
}

Future<void> _registerSingleItemPurchase(
  WidgetTester tester, {
  required String code,
  required String name,
  required String total,
}) async {
  await _stageItem(tester, code: code, name: name, total: total);
  await _enterPurchaseMoment(tester);
  await _tapVisible(tester, find.byKey(const Key('purchase.review')));
  await _pumpReady(tester);
  await _tapVisible(tester, find.byKey(const Key('purchase.register')));
  await _pumpReady(tester);
}

Future<void> _registerAttempt(WidgetTester tester) async {
  await _stageItem(
    tester,
    code: 'ARROZ-001',
    name: 'Arroz Branco',
    total: '12.99',
  );
  await _enterPurchaseMoment(tester);
  await _tapVisible(tester, find.byKey(const Key('purchase.review')));
  await _pumpReady(tester);
  await _tapVisible(tester, find.byKey(const Key('purchase.register')));
  await _pumpReady(tester);
}

Future<void> _enterPurchaseMoment(WidgetTester tester) async {
  await _enterVisibleText(
    tester,
    find.byKey(const Key('purchase.date')),
    '14/07/2026',
  );
  await _enterVisibleText(
    tester,
    find.byKey(const Key('purchase.time')),
    '09:30',
  );
}

Future<void> _enterVisibleText(
  WidgetTester tester,
  Finder finder,
  String text,
) async {
  await Scrollable.ensureVisible(
    tester.element(finder),
    duration: const Duration(milliseconds: 1),
  );
  await _pumpReady(tester);
  await tester.enterText(finder, text);
}

Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await Scrollable.ensureVisible(
    tester.element(finder),
    duration: const Duration(milliseconds: 1),
  );
  await _pumpReady(tester);
  await tester.tap(finder);
}

Future<void> _pumpReady(WidgetTester tester) async {
  for (var i = 0; i < 20; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
