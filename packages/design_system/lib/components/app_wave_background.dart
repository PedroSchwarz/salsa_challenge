import 'dart:math' as math;

import 'package:flutter/material.dart';

class AppWaveBackground extends StatefulWidget {
  const AppWaveBackground({super.key, required this.child, this.color1, this.color2, required this.waveColor});

  final Widget child;
  final Color? color1;
  final Color? color2;
  final Color waveColor;

  @override
  State<AppWaveBackground> createState() => _AppWaveBackgroundState();
}

class _AppWaveBackgroundState extends State<AppWaveBackground> with SingleTickerProviderStateMixin {
  late final AnimationController _waveController;
  late final Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(duration: const Duration(seconds: 4), vsync: this)..repeat(reverse: true);
    _waveAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(parent: _waveController, curve: Curves.easeOut, reverseCurve: Curves.easeOut));
    _waveAnimation.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: _WaveBackgroundPainter(animation: _waveAnimation, color1: widget.color1, color2: widget.color2, waveColor: widget.waveColor),
          ),
        ),
        widget.child,
      ],
    );
  }
}

// Custom painter for wave background
class _WaveBackgroundPainter extends CustomPainter {
  final Animation<double> animation;
  final Color? color1, color2;
  final Color waveColor;

  _WaveBackgroundPainter({required this.animation, this.color1, this.color2, required this.waveColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Create gradient background
    if (color1 != null && color2 != null) {
      final rect = Rect.fromLTWH(0, 0, size.width, size.height);
      final gradient = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [color1!, color2!]).createShader(rect);

      paint.shader = gradient;
      canvas.drawRect(rect, paint);
    }
    // Draw animated waves
    paint.shader = null;
    paint.color = waveColor.withValues(alpha: 0.3);

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
