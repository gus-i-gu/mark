import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/app_failure.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/infrastructure/local/local_database.dart';
import 'package:markei/infrastructure/local/local_query_repository.dart';

void main() {
  test('Catalogue creates a Store for the active Account', () async {
    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final repository = LocalQueryRepository(db);
    const accountId = AccountId('11111111-1111-4111-8111-111111111111');

    final store = await repository.createStore(
      accountId,
      '  Mercado Central  ',
    );

    expect(store.accountId.value, accountId.value);
    expect(store.displayName, 'Mercado Central');
    final stores = await repository.listStores(accountId);
    expect(stores, hasLength(1));
    expect(stores.single.id.value, store.id.value);
  });

  test('empty Store name is rejected', () async {
    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final repository = LocalQueryRepository(db);

    await expectLater(
      repository.createStore(
        const AccountId('11111111-1111-4111-8111-111111111111'),
        '   ',
      ),
      throwsA(
        isA<AppFailure>()
            .having((failure) => failure.code, 'code', 'empty-store-name')
            .having(
              (failure) => failure.outcome,
              'outcome',
              FailureOutcome.notApplied,
            ),
      ),
    );

    expect(await db.select(db.stores).get(), isEmpty);
  });

  test(
    'same-Account duplicate Store creation reuses the existing Store',
    () async {
      final db = LocalDatabase.memory();
      addTearDown(db.close);
      final repository = LocalQueryRepository(db);
      const accountId = AccountId('11111111-1111-4111-8111-111111111111');

      final first = await repository.createStore(accountId, 'Mercado Central');
      final second = await repository.createStore(accountId, 'Mercado Central');

      expect(second.id.value, first.id.value);
      expect(await db.select(db.stores).get(), hasLength(1));
    },
  );

  test('cross-Account Store visibility is denied', () async {
    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final repository = LocalQueryRepository(db);
    const accountA = AccountId('11111111-1111-4111-8111-111111111111');
    const accountB = AccountId('99999999-9999-4999-8999-999999999999');

    await repository.createStore(accountA, 'Mercado Central');
    await repository.createStore(accountB, 'Foreign Store');

    final stores = await repository.listStores(accountA);

    expect(stores.map((store) => store.displayName), ['Mercado Central']);
  });
}
