# Send Money App

A Flutter application for managing wallet transactions and sending money. This app follows Clean Architecture principles with BLoC pattern for state management.

## Prerequisites

Before running this application, ensure you have the following installed:

- **Flutter SDK**: Version 3.0.0 or higher
  - [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK**: Version 2.17.0 or higher (comes with Flutter)
- **IDE**: Android Studio, VS Code, or IntelliJ IDEA with Flutter plugin
- **Platform-specific requirements**:
  - **iOS**: Xcode 13.0+ and CocoaPods
  - **Android**: Android Studio and Android SDK

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/Mr-MahendraGurjar/Super-money-app.git
cd send_money_app
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the Application

#### For iOS:
```bash
# Install iOS dependencies
cd ios && pod install && cd ..

# Run on iOS simulator
flutter run -d ios
```

#### For Android:
```bash
# Run on Android emulator
flutter run -d android
```

#### For Web:
```bash
flutter run -d chrome
```

## Running Unit Tests

This project includes comprehensive unit tests for the business logic layer.

### Run All Tests

```bash
flutter test
```

### Run Tests with Coverage

```bash
# Generate coverage report
flutter test --coverage

# Generate HTML coverage report (requires lcov)
genhtml coverage/lcov.info -o coverage/html

# Open coverage report in browser
open coverage/html/index.html
```

### Run Specific Test Files

```bash
# Run wallet repository tests
flutter test test/features/wallet/data/repositories/wallet_repository_impl_test.dart

# Run wallet cubit tests
flutter test test/features/wallet/presentation/cubit/wallet_cubit_test.dart

# Run use case tests
flutter test test/features/wallet/domain/usecases/
```

### Run Tests in Watch Mode

For continuous testing during development:

```bash
flutter test --reporter expanded
```

## Project Structure

```
lib/
├── core/                    # Core functionality and shared code
│   ├── constants/          # App constants, colors, and themes
│   ├── errors/             # Error handling classes
│   ├── usecases/          # Base use case classes
│   └── utils/             # Utility functions
├── features/              # Feature modules
│   └── wallet/           # Wallet feature
│       ├── data/         # Data layer
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/       # Domain layer
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/ # Presentation layer
│           ├── cubit/
│           ├── pages/
│           └── widgets/
├── injection/            # Dependency injection
└── main.dart            # Application entry point
```

## Test Structure

```
test/
├── features/
│   └── wallet/
│       ├── data/
│       │   └── repositories/
│       │       └── wallet_repository_impl_test.dart
│       ├── domain/
│       │   └── usecases/
│       │       ├── get_wallet_test.dart
│       │       └── send_money_test.dart
│       └── presentation/
│           └── cubit/
│               └── wallet_cubit_test.dart
└── widget_test.dart
```

## Available Test Suites

1. **Repository Tests** (`wallet_repository_impl_test.dart`)
   - Tests data layer implementation
   - Validates API calls and error handling
   - Tests local data caching

2. **Use Case Tests**
   - `get_wallet_test.dart`: Tests wallet retrieval logic
   - `send_money_test.dart`: Tests money transfer logic

3. **Cubit Tests** (`wallet_cubit_test.dart`)
   - Tests state management
   - Validates UI state transitions
   - Tests error scenarios

## Development Commands

### Code Generation (if using build_runner)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Format Code
```bash
flutter format .
```

### Analyze Code
```bash
flutter analyze
```

### Clean Build
```bash
flutter clean
flutter pub get
```

## Debugging

### Enable Verbose Logging
```bash
flutter run --verbose
```

### Run in Debug Mode
```bash
flutter run --debug
```

### Run in Profile Mode
```bash
flutter run --profile
```

### Run in Release Mode
```bash
flutter run --release
```

## Common Issues and Solutions

### Issue: CocoaPods not installed (iOS)
```bash
sudo gem install cocoapods
```

### Issue: Build fails on Android
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

### Issue: Tests fail due to missing mocks
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.
