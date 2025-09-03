import 'package:auth/auth.dart';

class SplashRepository {
  SplashRepository({required this.authRepository});

  final AuthRepository authRepository;

  Future<void> init() async {
    await authRepository.init();
  }
}
