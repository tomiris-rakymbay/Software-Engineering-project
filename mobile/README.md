# Supplier Consumer App

A Flutter mobile application for connecting suppliers and consumers.

## Prerequisites

- **Flutter SDK**: Version 3.10.0 or higher
- **Dart SDK**: Included with Flutter
- **Development Environment**: 
  - For Android: Android Studio with Android SDK
  - For iOS: Xcode (macOS only)
  - For Web: Chrome/Edge browser

## Getting Started

### 1. Install Flutter

If you haven't installed Flutter yet, follow the official installation guide:
- [Install Flutter](https://docs.flutter.dev/get-started/install)

Verify your installation:
```bash
flutter doctor
```

### 2. Navigate to the Mobile Directory

```bash
cd mobile
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run the App

#### Run on Android Emulator/Device
```bash
flutter run
```

Or specify a device:
```bash
flutter devices  # List available devices
flutter run -d <device-id>
```

#### Run on iOS Simulator/Device (macOS only)
```bash
flutter run
```

#### Run on Web
```bash
flutter run -d chrome
```

#### Run on Windows Desktop
```bash
flutter run -d windows
```

## Test Credentials

The app currently uses mock authentication. Use these credentials to log in:

**Consumer Account:**
- Email: `consumer@test.com`
- Password: `123456`

**Sales Account:**
- Email: `sales@test.com`
- Password: `123456`

## Project Structure

```
mobile/
├── lib/
│   ├── app/           # Main app configuration
│   └── features/      # Feature modules
│       ├── auth/      # Authentication
│       ├── catalog/   # Product catalog
│       ├── chat/      # Messaging
│       ├── consumer/  # Consumer features
│       ├── linking/   # Supplier linking
│       ├── orders/    # Order management
│       └── sales/     # Sales features
└── assets/
    └── translations/  # Localization files (en, ru, kk)
```

## Features

- Multi-language support (English, Russian, Kazakh)
- Consumer and Sales roles
- Supplier linking system
- Product catalog browsing
- Chat functionality
- Order management

## Technologies Used

- **Flutter**: UI framework
- **Riverpod**: State management
- **GoRouter**: Navigation
- **Dio**: HTTP client (configured for future backend integration)
- **SharedPreferences**: Local storage
- **EasyLocalization**: Internationalization

## Notes

- The app currently uses mock data and doesn't require a backend server
- Backend API integration is prepared but commented out in the codebase
- All data is stored locally using SharedPreferences

## Troubleshooting

### Flutter Doctor Issues
Run `flutter doctor` and fix any reported issues.

### Clean Build
If you encounter build issues:
```bash
flutter clean
flutter pub get
flutter run
```

### Android Build Issues
- Ensure Android SDK is properly installed
- Check that `ANDROID_HOME` environment variable is set

### iOS Build Issues (macOS only)
- Ensure Xcode is installed and updated
- Run `pod install` in the `ios` directory if needed
