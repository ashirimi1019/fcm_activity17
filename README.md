# CSC 4360 – In-Class Activity 17: Firebase Cloud Messaging
## Complete Setup, Testing, and Submission Guide

**Student**: [Your Name Here]  
**Course**: CSC 4360 – Mobile App Development  
**Assignment**: In-Class Activity 17 – Firebase Cloud Messaging  
**Due Date**: November 12, 2025 @ 10:31 PM

---

## 📋 Table of Contents

1. [Project Overview](#project-overview)
2. [Prerequisites](#prerequisites)
3. [Complete Setup Instructions](#complete-setup-instructions)
4. [Firebase Console Configuration](#firebase-console-configuration)
5. [Running the Application](#running-the-application)
6. [Testing Notifications](#testing-notifications)
7. [APK Generation](#apk-generation)
8. [GitHub Submission](#github-submission)
9. [Required Screenshots](#required-screenshots)
10. [Assignment Checklist](#assignment-checklist)
11. [Troubleshooting](#troubleshooting)

---

## 🎯 Project Overview

This Flutter application demonstrates **Firebase Cloud Messaging (FCM)** implementation with:

### ✅ Required Features Implemented

1. **Firebase Integration**
   - ✅ `firebase_core` for Firebase initialization
   - ✅ `firebase_messaging` for FCM functionality
   - ✅ Auto-generated `firebase_options.dart` via FlutterFire CLI

2. **FCM Token Management**
   - ✅ Token retrieval and display in terminal
   - ✅ Token display on screen with copy-to-clipboard functionality
   - ✅ Token refresh handling

3. **Complete Notification Handling**
   - ✅ **Foreground** notifications (app is open)
   - ✅ **Background** notifications (app is minimized)
   - ✅ **Terminated** state notifications (app is closed)
   - ✅ `FirebaseMessaging.onBackgroundMessage` implementation
   - ✅ `FirebaseMessaging.onMessage` implementation
   - ✅ `FirebaseMessaging.onMessageOpenedApp` implementation

4. **Custom Notification UI**
   - ✅ Alert dialogs for incoming notifications
   - ✅ Display of title, body, and data payload

5. **ADVANCED FEATURE: Multiple Notification Types**
   - ✅ **Regular Notifications**: Blue-themed, normal dialog
   - ✅ **Important Notifications**: Red-themed, larger layout, vibration
   - ✅ Parsing of `message.data["type"]` from Firebase
   - ✅ Different UI styling based on type

6. **Enhanced Features**
   - ✅ Notification history list with timestamps
   - ✅ Custom notification cards with different styling
   - ✅ Data payload display
   - ✅ Clear history functionality
   - ✅ Pull-to-refresh

---

## 📦 Prerequisites

### Software Requirements

1. **Flutter SDK** (Latest stable version)
2. **Node.js and npm** (For Firebase CLI) - https://nodejs.org/
3. **Firebase CLI**: `npm install -g firebase-tools`
4. **FlutterFire CLI**: `dart pub global activate flutterfire_cli`
5. **Google Account** for Firebase Console

### Verify Installations

```bash
flutter --version
node --version
npm --version
firebase --version
flutterfire --version
```

---

## 🔧 Complete Setup Instructions

### Step 1: Install Flutter Dependencies

```bash
cd c:\Users\ashir\fcm_activity17
flutter pub get
```

### Step 2: Login to Firebase CLI

```bash
firebase login
```

### Step 3: Configure FlutterFire (CRITICAL!)

```bash
flutterfire configure
```

This will:
1. Prompt for Firebase project (create new or select existing)
2. Ask for platform selection (select Android and/or iOS)
3. Auto-generate `lib/firebase_options.dart`
4. Configure native Android/iOS code
5. Download `google-services.json` and `GoogleService-Info.plist`

**Expected Output:**
```
✔ Firebase project configured successfully
✔ Generated lib/firebase_options.dart
```

---

## 🔥 Firebase Console Configuration

1. Go to https://console.firebase.google.com/
2. Select your project
3. Navigate to **Build** → **Cloud Messaging**
4. Verify Cloud Messaging API is enabled

**That's it!** FlutterFire CLI handled the rest.

---

## ▶️ Running the Application

### Run on Physical Device (RECOMMENDED)

```bash
flutter devices
flutter run
```

### Expected Terminal Output:

```
🚀 Starting FCM Activity 17...
✅ Firebase initialized successfully
✅ Background message handler registered

═══════════════════════════════════════
📱 FCM TOKEN (COPY THIS FOR TESTING):
═══════════════════════════════════════
eXaMpLeToKeN1234567890...
═══════════════════════════════════════

✅ FCM Initialization Complete!
```

**COPY THIS TOKEN - You'll need it for testing!**

---

## 🧪 Testing Notifications

### Send Regular Notification

1. Go to Firebase Console → **Cloud Messaging**
2. Click **"Send your first message"** or **"New campaign"**
3. Enter:
   - Title: `Test Regular Notification`
   - Text: `This is a regular notification test.`
4. Click **"Send test message"**
5. Paste your FCM token
6. Click **"Test"**

**Expected**: Blue dialog appears (or system notification if app in background)

### Send Important Notification

1. Create new test message
2. Enter:
   - Title: `⚠️ URGENT: Important Alert`
   - Text: `This is an important notification.`
3. **Expand "Additional options" → "Custom data"**
4. **Add key-value pair**:
   - Key: `type`
   - Value: `important`
5. Click **"Test"** with your token

**Expected**: Red dialog with warning icon, phone vibrates twice

### Testing Checklist:

- [ ] Regular notification - **Foreground** (app open)
- [ ] Regular notification - **Background** (app minimized)
- [ ] Regular notification - **Terminated** (app closed)
- [ ] Important notification - **Foreground**
- [ ] Important notification - **Background**
- [ ] Important notification - **Terminated**
- [ ] Token displays on screen
- [ ] Notifications appear in history
- [ ] Data payload displays correctly
- [ ] Vibration works for important

---

## 📱 APK Generation

### Build Release APK

```bash
flutter build apk --release
```

### Locate APK

```
build\app\outputs\flutter-apk\app-release.apk
```

### Install on Device

```bash
flutter install
```

Or copy APK to device and install manually.

---

## 📤 GitHub Submission

### Create .gitignore

Create `.gitignore` in project root:

```
# Flutter
.dart_tool/
.packages
build/
.pub-cache/
.pub/

# Firebase (keep firebase_options.dart, exclude sensitive files)
**/android/app/google-services.json
**/ios/Runner/GoogleService-Info.plist

# Android
**/android/local.properties
**/android/.gradle

# iOS
**/ios/Pods/
**/ios/.symlinks/
**/ios/Flutter/ephemeral
```

### Push to GitHub

```bash
git init
git add .
git commit -m "Initial commit: FCM Activity 17"
git remote add origin https://github.com/ashirimi1019/fcm_activity17.git
git push -u origin main
```

---

## 📸 Required Screenshots

Take these screenshots and add to `screenshots/` folder:

1. **01_token_display.png** - Token shown on app screen
2. **02_token_terminal.png** - Token in terminal output
3. **03_regular_notification_foreground.png** - Blue notification dialog
4. **04_important_notification_foreground.png** - Red notification dialog
5. **05_background_notification.png** - System notification tray
6. **06_notification_history.png** - History list with notifications
7. **07_data_payload.png** - Dialog showing data payload
8. **08_firebase_console_test.png** - Firebase Console test setup

```bash
mkdir screenshots
# Add your screenshots
git add screenshots/
git commit -m "Add required screenshots"
git push
```

---

## ✅ Assignment Checklist

### Implementation:
- [x] Firebase initialization with `firebase_core`
- [x] FCM integration with `firebase_messaging`
- [x] `firebase_options.dart` generated
- [x] FCM token retrieval and terminal display
- [x] FCM token UI display
- [x] Background handler (`onBackgroundMessage`)
- [x] Foreground handler (`onMessage`)
- [x] Tap handler (`onMessageOpenedApp`)
- [x] Terminated state handler
- [x] Alert dialog for notifications
- [x] Title, body, data payload display
- [x] Two notification types (regular/important)
- [x] Parse `message.data["type"]`
- [x] Different UI for each type
- [x] Vibration for important
- [x] Notification history

### Testing:
- [ ] All notification types tested
- [ ] All app states tested
- [ ] Token verified
- [ ] Screenshots taken

### Deliverables:
- [ ] Code on GitHub
- [ ] APK built
- [ ] Screenshots committed
- [ ] README complete

---

## 🔧 Troubleshooting

### firebase_options.dart not found
```bash
flutterfire configure
```

### Notifications not received
- Check internet connection
- Verify token copied correctly
- Ensure Firebase Cloud Messaging API enabled
- For iOS: check notification permissions

### Important notification looks like regular
- Verify custom data in Firebase Console: `type: important`

### APK build fails
```bash
flutter clean
flutter pub get
flutter build apk --release
```

---

## 📚 Resources

- [Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging)
- [FlutterFire](https://firebase.flutter.dev/)
- [firebase_messaging plugin](https://pub.dev/packages/firebase_messaging)

---

## ✅ Final Submission Checklist

- [ ] Code compiles without errors
- [ ] Tested on physical device
- [ ] All features working
- [ ] Screenshots taken (8 total)
- [ ] Code on GitHub
- [ ] APK built
- [ ] README complete
- [ ] **Deadline met: 11/12/2025 @ 10:31 PM**

---

## 🎉 Project Complete!

**Features Implemented:**
- ✅ Complete FCM integration
- ✅ Multi-state notification handling
- ✅ Custom notification types with different UI
- ✅ Notification history
- ✅ Professional code structure

**Good luck with your submission! 🚀**
