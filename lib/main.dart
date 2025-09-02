import 'package:salsa_challenge/app/ui/app.dart';
import 'package:salsa_challenge/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() {
    return const MainApp();
  });
}
