import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salsa_challenge/features/home/home.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter() {
  final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/${HomeScreen.routeName}',
    routes: [GoRoute(path: '/${HomeScreen.routeName}', name: HomeScreen.routeName, builder: (context, state) => const HomeScreen())],
  );
  return router;
}
