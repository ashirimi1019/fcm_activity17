# Quick Start Guide

## Get Running in 5 Minutes

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Setup Firebase

```bash
# Login
firebase login

# Configure
flutterfire configure
```

Select your project or create new one, select Android platform.

### 3. Run App

```bash
flutter run
```

### 4. Copy FCM Token

Look for token in terminal output between the `═══` lines, or copy from app screen.

### 5. Send Test Notification

1. Go to https://console.firebase.google.com/
2. Your project → Cloud Messaging
3. "Send test message"
4. Paste your token
5. Click "Test"

## Important Notification Test

When creating test message:
1. Add title and text
2. Expand "Additional options"
3. Go to "Custom data"
4. Add: key=`type`, value=`important`
5. Send test

You'll see:
- Regular: Blue dialog
- Important: Red dialog with vibration

## Common Issues

**No firebase_options.dart?**
```bash
flutterfire configure
```

**Notifications not working?**
- Check internet connection
- Verify token is correct
- Ensure Firebase Cloud Messaging API is enabled

**APK Build:**
```bash
flutter build apk --release
```

APK location: `build\app\outputs\flutter-apk\app-release.apk`

## That's It!

You're ready to test FCM. See full README.md for detailed instructions.
