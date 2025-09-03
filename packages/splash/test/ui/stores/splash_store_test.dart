import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splash/ui/stores/splash_store.dart';
import 'package:splash/data/repository/splash_repository.dart';
import 'package:auth/auth.dart';

import 'splash_store_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  group('SplashStore', () {
    late SplashStore store;
    late MockAuthRepository mockAuthRepository;
    late BehaviorSubject<UserData?> userStream;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      userStream = BehaviorSubject<UserData?>.seeded(null);

      // Setup the mock
      when(mockAuthRepository.currentUser).thenAnswer((_) => userStream);

      final splashRepository = SplashRepository(authRepository: mockAuthRepository);
      store = SplashStore(splashRepository: splashRepository);
    });

    tearDown(() {
      userStream.close();
    });

    group('Initial state', () {
      test('SHOULD have correct initial values', () {
        expect(store.isAuthenticated, false);
      });
    });

    group('load method', () {
      test('SHOULD set isAuthenticated to true WHEN user is authenticated', () async {
        // Arrange
        final mockUser = UserData(id: '123', firstName: 'John', lastName: 'Doe', email: 'john.doe@example.com');
        userStream.add(mockUser);

        // Act
        await store.load();

        // Assert
        expect(store.isAuthenticated, true);
      });

      test('SHOULD set isAuthenticated to false WHEN user is not authenticated', () async {
        // Arrange
        userStream.add(null);

        // Act
        await store.load();

        // Assert
        expect(store.isAuthenticated, false);
      });
    });
  });
}
