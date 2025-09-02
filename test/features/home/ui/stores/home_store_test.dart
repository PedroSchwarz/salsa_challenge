import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart';
import 'package:salsa_challenge/features/home/home.dart';

void main() {
  group('HomeStore', () {
    late HomeStore store;

    setUp(() {
      store = HomeStore();
    });

    group('Initial State', () {
      test('SHOULD have correct initial values', () {
        expect(store.isLoading, false);
        expect(store.items, isEmpty);
        expect(store.hasItems, false);
        expect(store.itemCount, 0);
      });
    });

    group('Computed Properties', () {
      test('hasItems SHOULD return true WHEN items exist', () {
        store.items.addAll([1, 2, 3]);
        expect(store.hasItems, true);
      });

      test('hasItems SHOULD return false WHEN items are empty', () {
        expect(store.hasItems, false);
      });

      test('itemCount SHOULD return correct count', () {
        store.items.addAll([1, 2, 3, 4, 5]);
        expect(store.itemCount, 5);
      });
    });

    group('load()', () {
      test('SHOULD set loading to true at start and false at end', () async {
        final loadFuture = store.load();

        await asyncWhen((_) => store.isLoading == true);
        expect(store.isLoading, true);

        await loadFuture;

        expect(store.isLoading, false);
      });

      test('SHOULD clear existing items before loading new ones', () async {
        store.items.addAll([10, 20, 30]);
        expect(store.items.length, 3);

        await store.load();

        expect(store.items, equals([1, 2, 3]));
        expect(store.itemCount, 3);
        expect(store.hasItems, true);
      });
    });
  });
}
