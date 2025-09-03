import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salsa_challenge/features/auth/auth.dart';
import 'package:salsa_challenge/features/home/home.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter({required AuthRepository authRepository}) {
  /// The routes that are white listed and don't require authentication.
  final List<String> authWhiteList = [LoginScreen.routeName];

  final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/${LoginScreen.routeName}',
    refreshListenable: GoRouterRefreshStreamListenable(authRepository.currentUser.distinct()),
    redirect: (context, state) {
      /// If the route is in the auth white list, return null.
      if (authWhiteList.contains(state.topRoute?.name)) {
        return null;
      }

      /// If the user is not logged in, redirect to the login screen.
      if (authRepository.currentUser.value == null) {
        return '/${LoginScreen.routeName}';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/${LoginScreen.routeName}', name: LoginScreen.routeName, builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/${HomeScreen.routeName}', name: HomeScreen.routeName, builder: (context, state) => const HomeScreen()),
    ],
  );
  return router;
}

/// A refresh listenable for the GoRouter that refreshes when the stream emits a new value.
class GoRouterRefreshStreamListenable extends ChangeNotifier {
  GoRouterRefreshStreamListenable(Stream<Object?> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<Object?> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
