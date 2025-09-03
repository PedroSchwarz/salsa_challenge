import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' as mockito;
import 'package:salsa_challenge/features/auth/auth.dart';

import 'login_store_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  group('LoginStore', () {
    late LoginStore store;
    late MockAuthRepository mockAuthRepository;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      store = LoginStore(authRepository: mockAuthRepository);
    });

    group('Initial state', () {
      test('SHOULD have correct initial values', () {
        expect(store.isSubmitting, false);
        expect(store.email, '');
        expect(store.password, '');
        expect(store.showPassword, false);
        expect(store.errorMessage, null);
        expect(store.isAuthenticated, false);
        expect(store.canSubmit, false);
      });
    });

    group('setEmail', () {
      test('SHOULD update email WHEN setEmail is called', () {
        // Arrange
        const testEmail = 'test@example.com';

        // Act
        store.setEmail(testEmail);

        // Assert
        expect(store.email, equals(testEmail));
      });
    });

    group('setPassword', () {
      test('SHOULD update password WHEN setPassword is called', () {
        // Arrange
        const testPassword = 'password123';

        // Act
        store.setPassword(testPassword);

        // Assert
        expect(store.password, equals(testPassword));
      });
    });

    group('canSubmit', () {
      test('canSubmit SHOULD be false WHEN email or password are not set', () {
        // Arrange & Act
        store.setEmail('test@example.com');

        // Assert
        expect(store.canSubmit, equals(false));
      });
      test('SHOULD update canSubmit WHEN email and password are set', () {
        // Arrange & Act
        store.setEmail('test@example.com');
        store.setPassword('password123');

        // Assert
        expect(store.canSubmit, equals(true));
      });
    });

    group('toggleShowPassword', () {
      test('SHOULD toggle showPassword from false to true', () {
        // Arrange
        expect(store.showPassword, false);

        // Act
        store.toggleShowPassword();

        // Assert
        expect(store.showPassword, true);
      });
    });
    group('login', () {
      const testEmail = 'test@example.com';
      const testPassword = 'password123';
      const testLoginRequest = LoginRequest(email: testEmail, password: testPassword);

      setUp(() {
        store.setEmail(testEmail);
        store.setPassword(testPassword);
      });

      test('SHOULD set isAuthenticated to true WHEN login succeeds', () async {
        // Arrange
        mockito.when(mockAuthRepository.login(mockito.any)).thenAnswer((_) async => LoginResult.success);

        // Act
        await store.login();

        // Assert
        expect(store.isAuthenticated, true);
        expect(store.errorMessage, isNull);
        expect(store.isSubmitting, false);
      });

      test('SHOULD set userNotFound error message WHEN login returns userNotFound', () async {
        // Arrange
        mockito.when(mockAuthRepository.login(mockito.any)).thenAnswer((_) async => LoginResult.userNotFound);

        // Act
        await store.login();

        // Assert
        expect(store.isAuthenticated, false);
        expect(store.errorMessage, 'User not found. Please check your credentials.');
        expect(store.isSubmitting, false);
      });

      test('SHOULD set network error message WHEN login returns networkError', () async {
        // Arrange
        mockito.when(mockAuthRepository.login(mockito.any)).thenAnswer((_) async => LoginResult.networkError);

        // Act
        await store.login();

        // Assert
        expect(store.isAuthenticated, false);
        expect(store.errorMessage, 'An error occurred. Try again later.');
        expect(store.isSubmitting, false);
      });

      test('SHOULD set network error message WHEN login throws an exception', () async {
        // Arrange
        mockito.when(mockAuthRepository.login(mockito.any)).thenThrow(Exception('Network error'));

        // Act
        await store.login();

        // Assert
        expect(store.isAuthenticated, false);
        expect(store.errorMessage, 'An error occurred. Try again later.');
        expect(store.isSubmitting, false);
      });

      test('SHOULD call authRepository.login with correct parameters', () async {
        // Arrange
        mockito.when(mockAuthRepository.login(mockito.any)).thenAnswer((_) async => LoginResult.success);

        // Act
        await store.login();

        // Assert
        mockito.verify(mockAuthRepository.login(testLoginRequest)).called(1);
      });
    });
  });
}
