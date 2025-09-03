import 'package:auth/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class UserRepository {
  UserRepository({required this.userLocalDataSource});

  @visibleForTesting
  final UserLocalDataSource userLocalDataSource;

  @visibleForTesting
  final userController = BehaviorSubject<UserData?>.seeded(null);
  ValueStream<UserData?> get userStream => userController.stream;

  /// Initializes the user repository by loading the user from the local data source.
  Future<void> init() async {
    final user = await userLocalDataSource.load();

    /// Adds the user to the user controller if it is not null.
    if (user != null) {
      userController.add(user);
    }
  }

  /// Updates the user in the local data source and the user controller.
  Future<void> updateUser(UserData? user) async {
    /// Deletes the user from the local data source if it is null.
    if (user == null) {
      userController.add(null);
      await userLocalDataSource.delete();
    } else {
      userController.add(user);
      await userLocalDataSource.save(user);
    }
  }
}
