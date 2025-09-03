# Splash Screen Package

This package provides sophisticated splash screen animations with multiple animation styles including Angular linear animations, mesh patterns, and geometric effects.

## Features

### 🎨 **Animation Styles**

#### 1. **Classic Splash Screen** (`splash_screen.dart`)
- **Scale Animation**: Pulsing logo and text effects
- **Gradient Animation**: Smooth color transitions
- **Angular Rotation**: Rotating geometric elements
- **Mesh Pattern**: Animated grid overlay
- **Particle System**: Floating particles with physics

#### 2. **Alternative Splash Screen** (`splash_screen_alternative.dart`)
- **Wave Background**: Animated wave effects
- **Geometric Mesh**: Hexagonal grid patterns
- **Floating Shapes**: Rotating triangles, squares, hexagons, and circles
- **Fade & Slide**: Smooth entrance animations
- **Modern Design**: Clean, minimalist aesthetic

### 🚀 **Animation Types**

#### **Angular Linear Animations**
- **Rotation Transitions**: Continuous rotation of geometric elements
- **Scale Transitions**: Pulsing and breathing effects
- **Fade Transitions**: Smooth opacity changes
- **Slide Transitions**: Position-based animations

#### **Mesh Animations**
- **Grid Patterns**: Animated line grids
- **Hexagonal Meshes**: Complex geometric patterns
- **Wave Effects**: Fluid, organic movements
- **Particle Systems**: Dynamic floating elements

#### **Geometric Elements**
- **Triangles**: Rotating triangular shapes
- **Squares**: Angular, modern elements
- **Hexagons**: Complex geometric patterns
- **Circles**: Smooth, continuous rotations

## Usage

### Basic Implementation

```dart
import 'package:splash/ui/views/splash_screen.dart';

// Use the classic splash screen
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      // ... other app configuration
    );
  }
}
```

### Alternative Style

```dart
import 'package:splash/ui/views/splash_screen_alternative.dart';

// Use the alternative splash screen
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreenAlternative(),
      // ... other app configuration
    );
  }
}
```

### Customization

#### **Animation Timing**
```dart
// Adjust animation durations
_controller = AnimationController(
  duration: const Duration(seconds: 3), // Customize duration
  vsync: this
);
```

#### **Colors and Themes**
```dart
// Customize gradient colors
_gradientAnimation = ColorTween(
  begin: const Color(0xFF6B73FF), // Custom start color
  end: const Color(0xFF000DFF),   // Custom end color
).animate(/* ... */);
```

#### **Particle System**
```dart
// Adjust particle count and behavior
void _initializeParticles() {
  for (int i = 0; i < 100; i++) { // Increase particle count
    _particles.add(Particle(
      // ... particle configuration
    ));
  }
}
```

## Technical Details

### **Animation Controllers**
- **Main Controller**: Manages primary animations
- **Gradient Controller**: Handles color transitions
- **Rotation Controller**: Manages geometric rotations
- **Mesh Controller**: Controls pattern animations
- **Particle Controller**: Manages particle system

### **Custom Painters**
- **MeshPatternPainter**: Draws animated grid patterns
- **ParticlePainter**: Renders particle system
- **WaveBackgroundPainter**: Creates wave effects
- **GeometricMeshPainter**: Draws hexagonal meshes
- **TrianglePainter**: Renders triangular shapes
- **HexagonPainter**: Draws hexagonal shapes

### **Performance Considerations**
- **Optimized Rendering**: Efficient canvas operations
- **Memory Management**: Proper disposal of controllers
- **Smooth Animations**: 60fps target performance
- **Responsive Design**: Adapts to different screen sizes

## Customization Examples

### **Change Animation Speed**
```dart
// Faster animations
_controller = AnimationController(
  duration: const Duration(milliseconds: 1500), // 1.5 seconds
  vsync: this
);
```

### **Modify Particle Behavior**
```dart
// More dynamic particles
final particle = Particle(
  vx: (_random.nextDouble() - 0.5) * 4, // Faster horizontal movement
  vy: (_random.nextDouble() - 0.5) * 4, // Faster vertical movement
  // ... other properties
);
```

### **Custom Color Schemes**
```dart
// Warm color palette
_gradientAnimation = ColorTween(
  begin: const Color(0xFFFF6B6B), // Warm red
  end: const Color(0xFFFFE66D),   // Warm yellow
).animate(/* ... */);
```

## Best Practices

1. **Dispose Controllers**: Always dispose animation controllers in `dispose()`
2. **Performance**: Use `shouldRepaint` efficiently in custom painters
3. **Responsiveness**: Test on different screen sizes and orientations
4. **Accessibility**: Ensure animations don't interfere with accessibility features
5. **Testing**: Test animations on both high-end and low-end devices

## Dependencies

- `flutter/material.dart`: Core Flutter framework
- `dart:math`: Mathematical operations for animations
- Custom store implementations for state management

## Contributing

To add new animation styles:

1. Create a new file following the naming convention
2. Implement required animation controllers and painters
3. Add proper documentation and examples
4. Test on multiple devices and screen sizes
5. Update this README with new features

## License

This package is part of the Salsa Challenge project and follows the project's licensing terms.
