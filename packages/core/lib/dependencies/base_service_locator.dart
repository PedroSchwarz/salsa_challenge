import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

abstract class BaseServiceLocator {
  BuildConfiguration get buildConfiguration;

  @mustCallSuper
  Future<void> setup();
}
