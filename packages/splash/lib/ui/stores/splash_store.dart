import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:splash/data/repository/splash_repository.dart';

part 'splash_store.g.dart';

// ignore: library_private_types_in_public_api
class SplashStore = _SplashStore with _$SplashStore;

abstract class _SplashStore with Store {
  _SplashStore({required this.splashRepository});

  @visibleForTesting
  final SplashRepository splashRepository;

  @readonly
  bool? _isAuthenticated;

  @action
  Future<void> load() async {
    await splashRepository.init();
    await Future.delayed(const Duration(seconds: 1));

    if (splashRepository.authRepository.currentUser.value != null) {
      _isAuthenticated = true;
    } else {
      _isAuthenticated = false;
    }
  }
}
