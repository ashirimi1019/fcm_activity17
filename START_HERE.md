# 🚀 IMMEDIATE NEXT STEPS - START HERE!

## ⚡ What to Do Right Now (30 Minutes to Complete)

**Your project code is 100% ready!** Now you just need to configure Firebase and test.

---

## 📝 Step 1: Install Firebase Tools (5 minutes)

### Open PowerShell and run:

```powershell
# Install Firebase CLI
npm install -g firebase-tools

# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Verify installations
firebase --version
flutterfire --version
```

**If you don't have Node.js:**
1. Download from: https://nodejs.org/
2. Install the LTS version
3. Restart PowerShell
4. Run the commands above

---

## 📝 Step 2: Login to Firebase (2 minutes)

```powershell
firebase login
```

- Browser will open
- Sign in with your Google account
- Grant permissions
- Terminal shows "Success!"

---

## 📝 Step 3: Configure Firebase (3 minutes)

**CRITICAL STEP - This generates firebase_options.dart**

```powershell
cd c:\Users\ashir\fcm_activity17
flutterfire configure
```

### What will happen:

1. **Question**: "Select a Firebase project"
   - **Choose**: "Create a new project"
   - **Name**: `fcm-activity17` (or any name)
   - Press Enter

2. **Question**: "Which platforms should your configuration support?"
   - **Press Space** to select: `android`
   - (Optional: also select `ios` if you have a Mac)
   - Press Enter

3. **Wait** ~30 seconds while it:
   - Creates Firebase project
   - Generates `firebase_options.dart`
   - Configures Android
   - Downloads `google-services.json`

4. **Success message**:
   ```
   ✔ Firebase project created
   ✔ Generated lib/firebase_options.dart
   ```

**VERIFY**: Check that `lib/firebase_options.dart` now has actual configuration (not placeholder)

---

## 📝 Step 4: Run the App (2 minutes)

### Connect your Android device:

1. Enable Developer Mode on phone
2. Enable USB Debugging
3. Connect via USB
4. Trust computer

### Run:

```powershell
flutter run
```

### Expected output in terminal:

```
🚀 Starting FCM Activity 17...
✅ Firebase initialized successfully
✅ Background message handler registered
🚀 Initializing Firebase Cloud Messaging...
✅ User granted notification permission

═══════════════════════════════════════
📱 FCM TOKEN (COPY THIS FOR TESTING):
═══════════════════════════════════════
dZ7X9bC... (very long string)
═══════════════════════════════════════

✅ FCM Initialization Complete!
```

**ACTION**: 
- Copy the entire token (select with mouse, Ctrl+C)
- Or tap "Copy Token" button in the app
- Save it in Notepad for next step

---

## 📝 Step 5: Enable Cloud Messaging (1 minute)

1. Go to: https://console.firebase.google.com/
2. Select your project: `fcm-activity17`
3. Left sidebar → **"Build"** → **"Cloud Messaging"**
4. If prompted, click **"Get Started"** or **"Enable"**
5. Done! (Usually already enabled)

---

## 📝 Step 6: Test Regular Notification (3 minutes)

### In Firebase Console:

1. Still in **Cloud Messaging** section
2. Click **"Send your first message"** (or "New campaign")
3. Select **"Firebase Notification messages"**

### Fill in:

**Notification title:**
```
Test Regular Notification
```

**Notification text:**
```
This is a regular notification test from Firebase Console.
```

### Send test:

1. Click **"Send test message"** (blue button, top right)
2. Paste your FCM token
3. Click the **+ (plus)** button
4. Your token appears in list
5. Click **"Test"** button

### Expected result:

**If app is open:**
- Blue dialog appears immediately
- Shows title and body
- Light vibration

**If app is in background:**
- System notification appears
- Tap it → app opens with blue dialog

✅ **Check**: Notification appears in history list at bottom of app

---

## 📝 Step 7: Test Important Notification (5 minutes)

### In Firebase Console:

1. Click **"Send test message"** again (or create new campaign)

### Fill in:

**Notification title:**
```
⚠️ URGENT: Important Alert
```

**Notification text:**
```
This is an important notification requiring immediate attention.
```

### ADD CUSTOM DATA (CRITICAL!):

1. Scroll down to **"Additional options"**
2. Click to expand
3. Find **"Custom data"** section
4. Click **"Add a key-value pair"**

**Enter exactly:**
- **Key**: `type`
- **Value**: `important`

(lowercase, no spaces, no typos!)

### Send test:

1. Click **"Send test message"**
2. Select your token
3. Click **"Test"**

### Expected result:

**Red dialog with:**
- ⚠️ Warning icon (yellow)
- Red background
- "⚠️ IMPORTANT" badge
- Phone vibrates TWICE (heavy)
- Data payload shows: `{type: important}`

✅ **Check**: Red notification card in history

---

## 📝 Step 8: Take Screenshots (5 minutes)

### On your phone, capture these 8 screenshots:

**Use Volume Down + Power button**

1. **Token Display**: Home screen showing token
2. **Regular Dialog**: Blue notification popup
3. **Important Dialog**: Red notification popup
4. **History List**: Screen with multiple notifications
5. **Data Payload**: Dialog showing `{type: important}`
6. **System Notification**: Notification in status bar

### On computer:

7. **Terminal Token**: Screenshot terminal showing token between `═══` lines
8. **Firebase Console**: Screenshot showing test message setup with custom data

### Save screenshots:

```powershell
mkdir screenshots
# Transfer phone screenshots to PC
# Put all 8 screenshots in screenshots folder
```

---

## 📝 Step 9: Build APK (3 minutes)

```powershell
flutter build apk --release
```

Wait 2-5 minutes for build to complete.

**APK location:**
```
c:\Users\ashir\fcm_activity17\build\app\outputs\flutter-apk\app-release.apk
```

### Test APK:

1. Copy APK to your phone
2. Install it
3. Open app
4. Send test notification
5. Verify it works

---

## 📝 Step 10: Push to GitHub (3 minutes)

```powershell
cd c:\Users\ashir\fcm_activity17

# Initialize git
git init

# Add all files
git add .

# Commit
git commit -m "CSC 4360 Activity 17 - Complete FCM Implementation"

# Create repo on GitHub first, then:
git remote add origin https://github.com/ashirimi1019/fcm_activity17.git

# Push
git branch -M main
git push -u origin main

# Add screenshots
git add screenshots/
git commit -m "Add required screenshots"
git push
```

---

## ✅ Verification Checklist

Before submitting, verify:

- [ ] `firebase_options.dart` has actual config (not placeholder)
- [ ] App runs without errors
- [ ] Token displays on screen
- [ ] Token printed in terminal
- [ ] Regular notification works (blue dialog)
- [ ] Important notification works (red dialog, vibration)
- [ ] Notifications appear in background
- [ ] Notifications work when app closed
- [ ] History shows all notifications
- [ ] Data payload displays
- [ ] 8 screenshots captured
- [ ] Screenshots in `screenshots/` folder
- [ ] APK builds successfully
- [ ] APK tested on device
- [ ] Code pushed to GitHub
- [ ] Screenshots pushed to GitHub

---

## 🚨 Common Issues & Fixes

### Issue: "firebase_options.dart not found"
```powershell
flutterfire configure
```

### Issue: Token not showing
- Check internet connection
- Restart app
- Check terminal for errors

### Issue: Important notification looks like regular (blue)
- **Fix**: In Firebase Console, verify custom data:
  - Key: `type`
  - Value: `important`
  - (must be lowercase, exactly as shown)

### Issue: Notifications not arriving
- Check device has internet
- Verify token is correct (no extra spaces)
- Check Firebase Cloud Messaging API is enabled
- For Android: ensure Google Play Services installed

### Issue: APK build fails
```powershell
flutter clean
flutter pub get
flutter build apk --release
```

---

## 📚 Need Help?

### Read These Files:

1. **Quick start**: `QUICKSTART.md`
2. **Complete guide**: `README.md`
3. **Testing instructions**: `TESTING_GUIDE.md`
4. **Code explanation**: `PROJECT_STRUCTURE.md`

### Test Each State:

- **Foreground**: App open → Send notification → Dialog appears
- **Background**: Minimize app → Send notification → Tap notification → Dialog
- **Terminated**: Close app → Send notification → Tap notification → App opens with dialog

---

## 🎯 What to Submit

### On Canvas/Submission Portal:

1. **GitHub Repository Link**
   ```
   https://github.com/ashirimi1019/fcm_activity17
   ```

2. **Screenshots** (in repo under `screenshots/` folder)

3. **APK File** (if required by instructor)
   - Upload to Google Drive
   - Share link, OR
   - Upload to GitHub Release

4. **Written Report** (if required)
   - Document your testing
   - Include screenshots
   - Explain implementation

---

## ⏰ Time Estimate

| Step | Time | Status |
|------|------|--------|
| 1. Install tools | 5 min | ⬜ |
| 2. Firebase login | 2 min | ⬜ |
| 3. Configure Firebase | 3 min | ⬜ |
| 4. Run app | 2 min | ⬜ |
| 5. Enable messaging | 1 min | ⬜ |
| 6. Test regular | 3 min | ⬜ |
| 7. Test important | 5 min | ⬜ |
| 8. Screenshots | 5 min | ⬜ |
| 9. Build APK | 3 min | ⬜ |
| 10. GitHub push | 3 min | ⬜ |
| **TOTAL** | **30 min** | |

---

## 🎉 You're Ready!

Your code is complete and professional. Just follow these 10 steps and you'll have a perfect submission.

**Deadline**: November 12, 2025 @ 10:31 PM

**Let's get started! 🚀**

---

## 📞 Quick Reference Commands

```powershell
# Setup
npm install -g firebase-tools
dart pub global activate flutterfire_cli
firebase login
cd c:\Users\ashir\fcm_activity17
flutterfire configure

# Run
flutter run

# Build
flutter build apk --release

# Git
git init
git add .
git commit -m "CSC 4360 Activity 17 - Complete"
git remote add origin <your-repo-url>
git push -u origin main
```

**Good luck! You've got this! 💪**
