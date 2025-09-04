import 'dart:async';

import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home/home.dart';
import 'package:settings/settings.dart';
import 'package:splash/splash.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter({required AuthRepository authRepository}) {
  /// The routes that are white listed and don't require authentication.
  final List<String> authWhiteList = [SplashScreen.routeName, LoginScreen.routeName];

  final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/${SplashScreen.routeName}',
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
      GoRoute(
        path: '/${SplashScreen.routeName}',
        name: SplashScreen.routeName,
        builder:
            (context, state) => SplashScreen(
              onAuthenticated: () {
                context.goNamed(HomeScreen.routeName);
              },
              onUnauthenticated: () {
                context.goNamed(LoginScreen.routeName);
              },
            ),
      ),
      GoRoute(
        path: '/${LoginScreen.routeName}',
        name: LoginScreen.routeName,
        pageBuilder: (context, state) {
          // Fade transition
          return CustomTransitionPage(
            key: state.pageKey,
            child: LoginScreen(
              onAuthenticated: () {
                context.goNamed(HomeScreen.routeName);
              },
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
      GoRoute(
        path: '/${HomeScreen.routeName}',
        name: HomeScreen.routeName,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: HomeScreen(
              onLocationSelected: (location) {
                context.goNamed(LocationDetailsScreen.routeName, pathParameters: {'id': location.id.toString()});
              },
              onNavigatedToSettings: () {
                context.goNamed(SettingsScreen.routeName);
              },
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
        routes: [
          GoRoute(
            path: '/${LocationDetailsScreen.routeName}/:id',
            name: LocationDetailsScreen.routeName,
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '';

              return LocationDetailsScreen(id: int.tryParse(id) ?? 0);
            },
          ),
          GoRoute(path: '/${SettingsScreen.routeName}', name: SettingsScreen.routeName, builder: (context, state) => const SettingsScreen()),
        ],
      ),
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
