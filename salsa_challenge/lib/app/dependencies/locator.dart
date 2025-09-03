import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:home/home.dart';
import 'package:salsa_challenge/app/ui/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainLocator extends BaseServiceLocator {
  @override
  BuildConfiguration get buildConfiguration => const BuildConfiguration(environment: Environment.development);

  @override
  Future<void> setup() async {
    getIt.registerSingleton(
      const FlutterSecureStorage(
        iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device),
        aOptions: AndroidOptions(sharedPreferencesName: 'salsa_challenge_secure_storage', encryptedSharedPreferences: true),
      ),
    );
    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerSingleton(sharedPreferences);

    final appStorage = AppLocalStorage(secureStorage: getIt(), sharedPreferences: getIt());
    await appStorage.create();

    getIt.registerSingleton(appStorage);
    getIt.registerSingleton<BuildConfiguration>(buildConfiguration);
    getIt.registerSingleton<AppDatabase>(AppDatabase());

    getIt.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl());
    getIt.registerSingleton<UserLocalDataSource>(UserLocalDataSource(localStorage: getIt()));
    getIt.registerSingleton<CredentialsLocalDataSource>(CredentialsLocalDataSource(localStorage: getIt()));

    getIt.registerSingleton<UserRepository>(UserRepository(userLocalDataSource: getIt()));
    getIt.registerSingleton<CredentialsRepository>(CredentialsRepository(credentialsLocalDataSource: getIt()));
    getIt.registerSingleton<AuthRepository>(AuthRepository(authRemoteDataSource: getIt(), userRepository: getIt(), credentialsRepository: getIt()));

    getIt.registerSingleton<GoRouter>(createRouter(authRepository: getIt()));

    getIt.registerSingleton<LoginStore>(LoginStore(authRepository: getIt()));

    getIt.registerSingleton<HomeStore>(HomeStore());
  }
}
