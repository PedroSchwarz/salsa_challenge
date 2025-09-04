# Salsa Challenge

A Flutter application built as a challenge project for Salsa Tech, organized as a Dart workspace with multiple packages for modular architecture.

## Prerequisites

- **Dart SDK**: Version 3.7.2 or higher
- **Flutter SDK**: Version 3.29.2 or higher

## Getting Started

### 1. Install Dependencies

First, install dependencies for the entire workspace from the root directory:

```bash
dart pub get
```

This command will automatically resolve dependencies for all packages in the workspace.

### 2. Run the Application

Navigate to the main application directory and run:

```bash
cd salsa_challenge
flutter run
```

The application will start and you can choose your target platform (iOS, Android, Web, etc.).

### 3. Code Generation (if needed)

If you need to generate code for packages that use code generation (like MobX, Freezed, or Drift), run:

```bash
# From the root directory
dart run build_runner build --delete-conflicting-outputs
```

## Project Structure

This project is organized as a **Dart workspace** with the following structure:

```
salsa_challenge_workspace/
├── salsa_challenge/          # Main Flutter application
├── packages/                 # Shared packages
│   ├── auth/                # Authentication module
│   ├── core/                # Core utilities and dependencies
│   ├── database/            # Database layer with Drift
│   ├── design_system/       # UI components and theming
│   ├── home/                # Home screen module
│   ├── settings/            # Settings module
│   └── splash/              # Splash screen module
└── mason.yaml               # Mason configuration for code generation
```

## Packages Overview

### 🏠 **salsa_challenge** (Main Application)
The main Flutter application that orchestrates all modules. It uses:
- **GoRouter** for navigation
- **MobX** for state management
- **Flutter Secure Storage** for secure data storage
- **Shared Preferences** for local storage

### 🔐 **auth** (Authentication Package)
Handles user authentication and authorization:
- **Dependencies**: MobX, Freezed, JSON serialization, RxDart
- **Features**: Login/logout functionality, user session management
- **Testing**: Includes unit tests with Mockito

### 🏗️ **core** (Core Package)
Foundation package providing shared utilities:
- **Dependencies**: GetIt for dependency injection, Flutter Secure Storage, Shared Preferences
- **Features**: Dependency injection setup, storage abstractions, configurations
- **Usage**: Used by all other packages as a foundation

### 🗄️ **database** (Database Package)
Database layer using Drift (SQLite):
- **Dependencies**: Drift, Drift Flutter
- **Features**: Local database operations, data persistence
- **Code Generation**: Uses Drift's code generation for type-safe database operations

### 🎨 **design_system** (Design System Package)
UI components and theming:
- **Dependencies**: Pure Flutter (no external dependencies)
- **Features**: Reusable UI components, consistent theming, design tokens
- **Usage**: Provides consistent UI across all modules

### 🏡 **home** (Home Package)
Home screen and main content:
- **Dependencies**: Cached Network Image, WebView Flutter, MobX, Freezed
- **Features**: Main content display, web content integration, image caching
- **Testing**: Includes UI tests

### ⚙️ **settings** (Settings Package)
Application settings and preferences:
- **Dependencies**: MobX, Collection utilities, Logging
- **Features**: User preferences, app configuration
- **Testing**: Includes unit tests with Mockito

### 🚀 **splash** (Splash Package)
Application splash screen:
- **Dependencies**: MobX, RxDart, Logging
- **Features**: App initialization, loading states, navigation to main app
- **Testing**: Includes UI tests

## Development Workflow

### Adding New Dependencies

1. Add dependencies to the specific package's `pubspec.yaml`
2. Run `dart pub get` from the root directory
3. The workspace will automatically resolve dependencies across all packages

### Code Generation

Several packages use code generation:
- **MobX**: State management code generation
- **Freezed**: Immutable data classes
- **Drift**: Database code generation
- **JSON Serializable**: JSON serialization

Run code generation when needed:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Testing

Each package includes its own test suite:
```bash
# Run tests for a specific package
cd packages/auth
flutter test

# Run all tests from root
flutter test
```

## Architecture

This project follows a **modular architecture** pattern:
- **Separation of Concerns**: Each package handles a specific domain
- **Dependency Injection**: Using GetIt for loose coupling
- **State Management**: MobX for reactive state management
- **Code Generation**: Extensive use of code generation for boilerplate reduction
- **Type Safety**: Strong typing with Freezed and Drift

## Mason Integration

The project uses Mason for code generation templates:
- **Template**: `flutter_app_template` from PedroSchwarz's repository
- **Usage**: Helps maintain consistent code structure across the project

## Platform Support

The application supports multiple platforms:
- ✅ **iOS**
- ✅ **Android** 
- ✅ **Web**
- ✅ **macOS**
- ✅ **Linux**
- ✅ **Windows**

## Contributing

1. Follow the existing package structure
2. Add tests for new features
3. Run code generation when adding new models or stores
4. Ensure all packages pass their respective tests
5. Update this README when adding new packages or significant changes

## License

This project is part of a challenge for Salsa Tech and is not intended for public distribution.
