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

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  final store = getIt<SplashStore>();

  late ReactionDisposer _authenticationDisposer;

  late final AnimationController _waveController;
  late final Animation<double> _waveAnimation;

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    store.load();

    _authenticationDisposer = reaction<bool>((_) => store.isAuthenticated, (isAuthenticated) {
      if (isAuthenticated) {
        widget.onAuthenticated();
      } else {
        widget.onUnauthenticated();
      }
    });

    /// Wave animation
    _waveController = AnimationController(duration: const Duration(seconds: 4), vsync: this)..repeat(reverse: true);
    _waveAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(parent: _waveController, curve: Curves.easeOut, reverseCurve: Curves.easeOut));
    _waveAnimation.addListener(() => setState(() {}));

    /// Fade animation
    _fadeController = AnimationController(duration: const Duration(seconds: 2), vsync: this)..repeat(reverse: true);
    _fadeAnimation = Tween<double>(begin: 0.2, end: 1).animate(CurvedAnimation(parent: _fadeController, curve: Curves.linear));
    _fadeAnimation.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _authenticationDisposer();
    _waveController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // Animated background with waves
          Positioned.fill(
            child: CustomPaint(
              painter: WaveBackgroundPainter(animation: _waveAnimation, color1: theme.colorScheme.primary, color2: theme.colorScheme.secondary),
            ),
          ),

          // Main content
          Padding(
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
        ],
      ),
    );
  }
}

// Custom painter for wave background
class WaveBackgroundPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color1, color2;

  WaveBackgroundPainter({required this.animation, required this.color1, required this.color2});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Create gradient background
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [color1, color2]).createShader(rect);

    paint.shader = gradient;
    canvas.drawRect(rect, paint);

    // Draw animated waves
    paint.shader = null;
    paint.color = Colors.white.withValues(alpha: 0.1);

    final path = Path();
    final waveHeight = 60.0;
    final frequency = 0.02;

    path.moveTo(0, size.height);

    for (double x = 0; x <= size.width; x++) {
      final y =
          size.height * 0.7 +
          math.sin(x * frequency + animation.value) * waveHeight +
          math.sin(x * frequency * 2 + animation.value * 1.5) * waveHeight * 0.5;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
