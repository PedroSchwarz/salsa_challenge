import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'dart:math' as math;
import 'package:splash/ui/stores/splash_store.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({required this.onAuthenticated, required this.onUnauthenticated, super.key});

  final Function() onAuthenticated;
  final Function() onUnauthenticated;

  static const routeName = 'splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  final store = getIt<SplashStore>();

  late ReactionDisposer _authenticationDisposer;

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    store.load();

    _authenticationDisposer = reaction<bool?>((_) => store.isAuthenticated, (isAuthenticated) {
      final value = isAuthenticated;
      if (value == null) return;

      if (value) {
        widget.onAuthenticated();
      } else {
        widget.onUnauthenticated();
      }
    });

    /// Fade animation
    _fadeController = AnimationController(duration: const Duration(seconds: 2), vsync: this)..repeat(reverse: true);
    _fadeAnimation = Tween<double>(begin: 0.2, end: 1).animate(CurvedAnimation(parent: _fadeController, curve: Curves.linear));
    _fadeAnimation.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _authenticationDisposer();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: AppWaveBackground(
        color1: theme.colorScheme.primary,
        color2: theme.colorScheme.secondary,
        waveColor: theme.colorScheme.onPrimary,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                'Salsa Challenge',
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600, letterSpacing: 1.5, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
