import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:salsa_challenge/features/auth/auth.dart';

import 'auth_repository_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource, UserRepository, CredentialsRepository])
void main() {
  group('AuthRepository', () {
    late AuthRepository repository;
    late MockAuthRemoteDataSource mockAuthRemoteDataSource;
    late MockUserRepository mockUserRepository;
    late MockCredentialsRepository mockCredentialsRepository;

    setUp(() {
      mockAuthRemoteDataSource = MockAuthRemoteDataSource();
      mockUserRepository = MockUserRepository();
      mockCredentialsRepository = MockCredentialsRepository();

      repository = AuthRepository(
        authRemoteDataSource: mockAuthRemoteDataSource,
        userRepository: mockUserRepository,
        credentialsRepository: mockCredentialsRepository,
      );
    });

    group('init', () {
      test('SHOULD call init method on user repository WHEN init is called', () async {
        // Arrange
        when(mockUserRepository.init()).thenAnswer((_) async {});

        // Act
        await repository.init();

        // Assert
        verify(mockUserRepository.init()).called(1);
      });
    });

    group('login', () {
      const loginRequest = LoginRequest(email: 'test@example.com', password: 'password');
      final mockAuthResponse = AuthResponse(
        id: '123',
        accessToken: 'access_token_123',
        refreshToken: 'refresh_token_123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        createdAt: DateTime(2024, 1, 1),
      );

      test('SHOULD return success WHEN login is successful', () async {
        // Arrange
        when(mockAuthRemoteDataSource.login(loginRequest)).thenAnswer((_) async => mockAuthResponse);
        when(mockUserRepository.updateUser(any)).thenAnswer((_) async {});
        when(mockCredentialsRepository.saveCredentials(any)).thenAnswer((_) async {});

        // Act
        final result = await repository.login(loginRequest);

        // Assert
        expect(result, equals(LoginResult.success));
        verify(mockAuthRemoteDataSource.login(loginRequest)).called(1);
        verify(mockUserRepository.updateUser(any)).called(1);
        verify(mockCredentialsRepository.saveCredentials(any)).called(1);
      });

      test('SHOULD update user with correct data WHEN login succeeds', () async {
        // Arrange
        when(mockAuthRemoteDataSource.login(loginRequest)).thenAnswer((_) async => mockAuthResponse);
        when(mockUserRepository.updateUser(any)).thenAnswer((_) async {});
        when(mockCredentialsRepository.saveCredentials(any)).thenAnswer((_) async {});

        // Act
        await repository.login(loginRequest);

        // Assert
        final expectedUserData = UserData(
          id: mockAuthResponse.id,
          firstName: mockAuthResponse.firstName,
          lastName: mockAuthResponse.lastName,
          email: mockAuthResponse.email,
        );
        verify(mockUserRepository.updateUser(expectedUserData)).called(1);
      });

      test('SHOULD save credentials with correct data WHEN login succeeds', () async {
        // Arrange
        when(mockAuthRemoteDataSource.login(loginRequest)).thenAnswer((_) async => mockAuthResponse);
        when(mockUserRepository.updateUser(any)).thenAnswer((_) async {});
        when(mockCredentialsRepository.saveCredentials(any)).thenAnswer((_) async {});

        // Act
        await repository.login(loginRequest);

        // Assert
        final expectedCredentials = CredentialsData(accessToken: mockAuthResponse.accessToken, refreshToken: mockAuthResponse.refreshToken);
        verify(mockCredentialsRepository.saveCredentials(expectedCredentials)).called(1);
      });

      test('SHOULD return networkError WHEN remote data source throws an error', () async {
        // Arrange
        when(mockAuthRemoteDataSource.login(loginRequest)).thenThrow(Exception('Network error'));

        // Act
        final result = await repository.login(loginRequest);

        // Assert
        expect(result, equals(LoginResult.networkError));
        verify(mockAuthRemoteDataSource.login(loginRequest)).called(1);
        verifyNever(mockUserRepository.updateUser(any));
        verifyNever(mockCredentialsRepository.saveCredentials(any));
      });

      test('SHOULD return networkError WHEN user repository update fails', () async {
        // Arrange
        when(mockAuthRemoteDataSource.login(loginRequest)).thenAnswer((_) async => mockAuthResponse);
        when(mockUserRepository.updateUser(any)).thenThrow(Exception('User update failed'));

        // Act
        final result = await repository.login(loginRequest);

        // Assert
        expect(result, equals(LoginResult.networkError));
        verify(mockAuthRemoteDataSource.login(loginRequest)).called(1);
        verify(mockUserRepository.updateUser(any)).called(1);
        verifyNever(mockCredentialsRepository.saveCredentials(any));
      });

      test('SHOULD return networkError WHEN credentials repository save fails', () async {
        // Arrange
        when(mockAuthRemoteDataSource.login(loginRequest)).thenAnswer((_) async => mockAuthResponse);
        when(mockUserRepository.updateUser(any)).thenAnswer((_) async {});
        when(mockCredentialsRepository.saveCredentials(any)).thenThrow(Exception('Credentials save failed'));

        // Act
        final result = await repository.login(loginRequest);

        // Assert
        expect(result, equals(LoginResult.networkError));
        verify(mockAuthRemoteDataSource.login(loginRequest)).called(1);
        verify(mockUserRepository.updateUser(any)).called(1);
        verify(mockCredentialsRepository.saveCredentials(any)).called(1);
      });
    });

    group('currentUser', () {
      test('SHOULD return user stream from user repository WHEN currentUser is called', () {
        // Arrange
        final mockStream = BehaviorSubject<UserData?>.seeded(null);
        when(mockUserRepository.userStream).thenAnswer((_) => mockStream);

        // Act
        final result = repository.currentUser;

        // Assert
        expect(result, equals(mockStream));
        verify(mockUserRepository.userStream).called(1);
      });
    });
  });
}
