import 'package:flutter_test/flutter_test.dart';
import 'package:home/data/mocks/locations_mock.dart';
import 'package:home/home.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' as mockito;
import 'package:mobx/mobx.dart';

import 'home_store_test.mocks.dart';

@GenerateMocks([HomeRepository])
void main() {
  group('HomeStore', () {
    late MockHomeRepository mockHomeRepository;
    late HomeStore store;
    const mockItems = locationsMock;

    setUp(() {
      mockHomeRepository = MockHomeRepository();
      store = HomeStore(homeRepository: mockHomeRepository);
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
        store.items.addAll(mockItems);
        expect(store.hasItems, true);
      });

      test('hasItems SHOULD return false WHEN items are empty', () {
        expect(store.hasItems, false);
      });

      test('itemCount SHOULD return correct count', () {
        store.items.addAll(mockItems);
        expect(store.itemCount, mockItems.length);
      });
    });

    group('load()', () {
      test('SHOULD set loading to true at start and false at end', () async {
        mockito.when(mockHomeRepository.getLocations()).thenAnswer((_) async => mockItems);

        final loadFuture = store.load();

        await asyncWhen((_) => store.isLoading == true);
        expect(store.isLoading, true);

        await loadFuture;

        expect(store.isLoading, false);
      });

      test('SHOULD clear existing items before loading new ones', () async {
        mockito.when(mockHomeRepository.getLocations()).thenAnswer((_) async => mockItems);

        store.items.addAll([mockItems[0], mockItems[1], mockItems[2]]);
        expect(store.items.length, 3);

        await store.load();

        expect(store.items, equals(mockItems));
        expect(store.itemCount, mockItems.length);
        expect(store.hasItems, true);
      });
    });
  });
}
