import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:salsa_challenge/app/configurations/build_configuration.dart';
import 'package:salsa_challenge/app/database/app_database.dart';
import 'package:salsa_challenge/app/storage/app_local_storage.dart';
import 'package:salsa_challenge/app/ui/navigation.dart';
import 'package:salsa_challenge/features/auth/auth.dart';
import 'package:salsa_challenge/features/home/home.dart';
import 'package:salsa_challenge/features/locations/locations.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

abstract class BaseServiceLocator {
  BuildConfiguration get buildConfiguration;

  @mustCallSuper
  Future<void> setup();
}

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
    getIt.registerSingleton<GoRouter>(createRouter());
    getIt.registerSingleton<AppDatabase>(AppDatabase());

    getIt.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl());
    getIt.registerSingleton<UserLocalDataSource>(UserLocalDataSource(localStorage: getIt()));
    getIt.registerSingleton<CredentialsLocalDataSource>(CredentialsLocalDataSource(localStorage: getIt()));

    getIt.registerSingleton<AuthRepository>(AuthRepository(authRemoteDataSource: getIt(), userRepository: getIt(), credentialsRepository: getIt()));
    getIt.registerSingleton<UserRepository>(UserRepository(userLocalDataSource: getIt()));
    getIt.registerSingleton<CredentialsRepository>(CredentialsRepository(credentialsLocalDataSource: getIt()));

    getIt.registerSingleton<LocationManager>(getIt<AppDatabase>().managers.locationTable);
    getIt.registerSingleton<LocationsLocalDataSource>(LocationsLocalDataSourceImpl(manager: getIt()));
    getIt.registerSingleton<HomeStore>(HomeStore());
  }
}
