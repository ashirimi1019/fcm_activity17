# 🧪 Complete Testing Guide for FCM Activity 17

## Testing Checklist & Step-by-Step Instructions

---

## 📋 Pre-Testing Setup

### ✅ Before You Begin:

- [ ] Flutter dependencies installed (`flutter pub get`)
- [ ] Firebase CLI installed and logged in
- [ ] FlutterFire configured (`flutterfire configure`)
- [ ] `firebase_options.dart` generated successfully
- [ ] Firebase Cloud Messaging API enabled in console
- [ ] Physical device connected (or emulator running)
- [ ] Device has internet connection

---

## 🎯 Test 1: Firebase Initialization

### Objective: Verify Firebase and FCM initialize correctly

### Steps:

1. Run the app:
   ```bash
   flutter run
   ```

2. Watch terminal output

### Expected Results:

```
🚀 Starting FCM Activity 17...
✅ Firebase initialized successfully
✅ Background message handler registered
🚀 Initializing Firebase Cloud Messaging...
✅ User granted notification permission

═══════════════════════════════════════
📱 FCM TOKEN (COPY THIS FOR TESTING):
═══════════════════════════════════════
[YOUR TOKEN HERE]
═══════════════════════════════════════

✅ FCM Initialization Complete!
```

### Pass Criteria:
- [ ] All checkmarks appear
- [ ] No error messages
- [ ] FCM token displays
- [ ] App shows home screen
- [ ] Loading screen disappears

### Troubleshooting:
❌ **"firebase_options.dart not found"**
- Solution: Run `flutterfire configure`

❌ **"No Firebase App created"**
- Solution: Check `main.dart` has `Firebase.initializeApp()`

---

## 🎯 Test 2: FCM Token Display

### Objective: Verify token displays correctly in app

### Steps:

1. Open app
2. Look at top section (blue gradient area)
3. Find "Your FCM Token" section

### Expected Results:

- [ ] Token displays in white card
- [ ] Token is long string (~150+ characters)
- [ ] Token is selectable
- [ ] "Copy Token" button visible
- [ ] Button is blue

### Actions to Test:

#### Action: Copy Token
1. Tap "Copy Token" button

**Expected**:
- [ ] Button turns green
- [ ] Text changes to "Copied!"
- [ ] Green snackbar appears: "✅ Token copied to clipboard!"
- [ ] After 3 seconds, button returns to blue

#### Action: Verify Copy
1. Open Notes app or any text editor
2. Paste (long press → Paste)

**Expected**:
- [ ] Full FCM token pastes correctly
- [ ] No extra spaces or line breaks

---

## 🎯 Test 3: Regular Notification - Foreground

### Objective: Test regular notification when app is open

### Setup:
1. Keep app open and visible
2. Have FCM token copied

### Steps:

1. Open Firebase Console: https://console.firebase.google.com/
2. Go to your project → **Cloud Messaging**
3. Click **"Send your first message"** or **"New campaign"**
4. Select **"Firebase Notification messages"**

**Fill in:**
- Notification title: `Test Regular Notification`
- Notification text: `This is a regular notification test from Firebase.`

5. Click **"Send test message"**
6. Click **"Add an FCM registration token"**
7. Paste your token
8. Click **+ (Add button)**
9. Click **"Test"**

### Expected Results:

**Immediately:**
- [ ] Terminal shows:
  ```
  📬 Foreground Message Received!
  Title: Test Regular Notification
  Body: This is a regular notification test from Firebase.
  ```

**In App:**
- [ ] Alert dialog appears instantly
- [ ] Dialog has blue theme
- [ ] Shows blue notification icon
- [ ] Badge says "Regular"
- [ ] Title displays: "Test Regular Notification"
- [ ] Body displays correctly
- [ ] Light haptic feedback felt
- [ ] "OK" or "CLOSE" button present

**Notification History:**
- [ ] Close dialog
- [ ] Check notification history section
- [ ] New notification card appears at top
- [ ] Card has blue border
- [ ] Shows "📬 Regular" badge
- [ ] Timestamp shows "Just now"

### Pass Criteria:
- [ ] All visual elements correct
- [ ] No errors in terminal
- [ ] History updates automatically

---

## 🎯 Test 4: Important Notification - Foreground

### Objective: Test important notification with custom styling

### Setup:
1. Keep app open and visible
2. Have FCM token ready

### Steps:

1. Firebase Console → **"Send test message"** again
2. **Notification title**: `⚠️ URGENT: Important Alert`
3. **Notification text**: `This is an important notification requiring immediate attention.`

4. **CRITICAL STEP** - Add Custom Data:
   - Scroll down to **"Additional options"**
   - Click to expand
   - Find **"Custom data"** section
   - Click **"Add a key-value pair"**
   - **Key**: `type` (lowercase, no spaces)
   - **Value**: `important` (lowercase, no spaces)

5. Click **"Send test message"**
6. Select your token
7. Click **"Test"**

### Expected Results:

**Immediately:**
- [ ] Terminal shows:
  ```
  📬 Foreground Message Received!
  Title: ⚠️ URGENT: Important Alert
  Body: This is an important notification...
  Data: {type: important}
  ```

**In App:**
- [ ] Dialog appears instantly
- [ ] **RED background** (dark red, not blue)
- [ ] Large warning icon (⚠️) at top, yellow color
- [ ] Badge says "⚠️ IMPORTANT" with yellow background
- [ ] Red border (thick, ~3px)
- [ ] Glowing red shadow effect
- [ ] Title in white, large font
- [ ] Body in white
- [ ] **Phone vibrates TWICE** (heavy vibration)
- [ ] Data payload section shows: `{type: important}`
- [ ] White "CLOSE" button at bottom

**Notification History:**
- [ ] Close dialog
- [ ] New notification at top
- [ ] **Red border and red gradient background**
- [ ] Shows "⚠️ IMPORTANT" badge (red background)
- [ ] Warning icon (red)
- [ ] Higher elevation/shadow than regular

### Pass Criteria:
- [ ] Red theme clearly different from blue
- [ ] Double vibration felt
- [ ] Data payload displays
- [ ] All visual differences from regular notification

### Troubleshooting:
❌ **Important notification looks like regular (blue)**
- Check Firebase Console: custom data MUST have `type: important`
- Verify spelling: lowercase, no spaces
- Try sending again

---

## 🎯 Test 5: Background Notification

### Objective: Test notification when app is minimized

### Steps:

1. With app running, press **Home button** or **Recent Apps**
2. Minimize app (don't force close)
3. Wait 2 seconds

4. Send test notification (regular OR important):
   - Follow steps from Test 3 or Test 4
   - Send from Firebase Console

### Expected Results:

**System Notification Tray:**
- [ ] Notification appears in status bar
- [ ] Title shows correctly
- [ ] Body shows correctly
- [ ] App icon visible
- [ ] Sound plays (if device not silent)

**Terminal Output:**
- [ ] Shows:
  ```
  🔔 Background Message Received!
  Message ID: [some ID]
  Title: [your title]
  Body: [your body]
  Data: [your data]
  ```

**Action: Tap Notification**
1. Swipe down notification tray
2. Tap the notification

**Expected:**
- [ ] App comes to foreground
- [ ] Dialog appears (blue or red based on type)
- [ ] Terminal shows:
  ```
  👆 Notification Tapped!
  ```
- [ ] Notification added to history

### Pass Criteria:
- [ ] System notification appears
- [ ] Background handler prints to console
- [ ] Tapping opens app with dialog
- [ ] Correct styling based on type

---

## 🎯 Test 6: Terminated State Notification

### Objective: Test notification when app is completely closed

### Steps:

1. **Force close the app**:
   - Android: Recent apps → Swipe away
   - iOS: Double-tap home → Swipe away
   - Or stop from IDE

2. Verify app is not running:
   - Check recent apps list (should not show)
   - Or run: `flutter devices` → app should not be running

3. Wait 5 seconds

4. Send test notification from Firebase Console:
   - Use either regular or important notification
   - Send test message to your token

### Expected Results:

**System Notification:**
- [ ] Notification appears in tray
- [ ] Title and body correct
- [ ] Can see without opening app

**NO Terminal Output** (app is closed)

**Action: Tap Notification**
1. Tap notification in system tray

**Expected:**
- [ ] App launches (cold start)
- [ ] Shows loading screen briefly
- [ ] Firebase initializes
- [ ] Token retrieves
- [ ] Home screen appears
- [ ] Dialog appears immediately (blue or red)
- [ ] Terminal (if you run app after) shows:
  ```
  📱 App opened from terminated state notification
  ```

### Pass Criteria:
- [ ] App launches from notification tap
- [ ] Initializes correctly
- [ ] Shows notification dialog
- [ ] Notification added to history

### Troubleshooting:
❌ **App doesn't launch when tapping notification**
- Check notification permissions granted
- Verify app installed correctly
- Try regular install (not debug): `flutter build apk && flutter install`

---

## 🎯 Test 7: Notification History

### Objective: Verify history list functionality

### Prerequisite:
- Send at least 3 notifications (mix of regular and important)

### Test Cases:

#### 7.1: History Display
- [ ] All notifications show in list
- [ ] Newest at top
- [ ] Each card has correct color (blue/red)
- [ ] Timestamps accurate
- [ ] Icons correct (bell vs warning)
- [ ] Badges correct ("Regular" vs "IMPORTANT")

#### 7.2: Data Payload Display
1. Find important notification in history
2. Check data payload section

**Expected:**
- [ ] Gray box with "Data Payload:" label
- [ ] Shows: `type: important`
- [ ] Monospace font

#### 7.3: Empty State
1. Open app fresh (before sending notifications)

**Expected:**
- [ ] Large gray notification icon
- [ ] Text: "No notifications yet"
- [ ] Instruction text visible

#### 7.4: Pull to Refresh
1. Pull down on notification list

**Expected:**
- [ ] Refresh indicator appears
- [ ] List updates (if new notifications)

#### 7.5: Clear History
1. Tap floating action button (trash icon, red)
2. Confirmation dialog appears

**Expected Dialog:**
- [ ] Title: "Clear History"
- [ ] Message asks for confirmation
- [ ] "Cancel" button
- [ ] "Clear" button (red)

3. Tap "Clear"

**Expected:**
- [ ] All notifications removed
- [ ] Empty state appears
- [ ] Snackbar: "Notification history cleared"

---

## 🎯 Test 8: Multiple Notification Types Side-by-Side

### Objective: Verify different types display correctly

### Steps:

1. Send **Regular** notification
2. Wait 5 seconds
3. Send **Important** notification (with `type: important`)
4. Wait 5 seconds
5. Send another **Regular** notification

### Expected Results in History:

**List Order (top to bottom):**
1. Regular (newest) - Blue border
2. Important (middle) - Red border, gradient
3. Regular (oldest) - Blue border

**Visual Verification:**
- [ ] Important notification stands out
- [ ] Clear visual difference between types
- [ ] Icons different (bell vs warning)
- [ ] Colors distinct
- [ ] Important has higher elevation

---

## 🎯 Test 9: Token Persistence

### Objective: Verify token remains same across app restarts

### Steps:

1. Copy token from app
2. Note down last 10 characters
3. Close app completely
4. Reopen app
5. Check token again

### Expected Results:
- [ ] Token is identical
- [ ] Last 10 characters match
- [ ] Token doesn't change on restart

**Note**: Token may change if:
- App reinstalled
- Device ID changes
- Firebase project changed

---

## 🎯 Test 10: Error Handling

### Objective: Test app behavior under error conditions

### Test Cases:

#### 10.1: No Internet on Launch
1. Turn off WiFi and mobile data
2. Launch app

**Expected:**
- [ ] App still launches
- [ ] Shows loading or error state
- [ ] Doesn't crash
- [ ] Error message shown if Firebase fails

#### 10.2: Internet Lost During Use
1. Open app (working)
2. Turn off internet
3. Try sending notification

**Expected:**
- [ ] App remains functional
- [ ] Notification won't arrive (expected)
- [ ] No crash

#### 10.3: Invalid Token (Manual Test)
1. In Firebase Console, use fake token: `invalid_token_123`
2. Try sending test

**Expected:**
- [ ] Firebase shows error
- [ ] "Invalid registration token" message

---

## 📊 Complete Testing Summary Checklist

### Core Functionality:
- [ ] Firebase initializes successfully
- [ ] FCM token retrieves and displays
- [ ] Token copyable to clipboard
- [ ] Regular notifications received (foreground)
- [ ] Regular notifications received (background)
- [ ] Regular notifications received (terminated)
- [ ] Important notifications received (foreground)
- [ ] Important notifications received (background)
- [ ] Important notifications received (terminated)

### UI/UX:
- [ ] Regular notification: blue theme, normal dialog
- [ ] Important notification: red theme, warning icon, vibration
- [ ] Data payload displays correctly
- [ ] Notification history updates automatically
- [ ] History shows correct chronological order
- [ ] Different card styles for regular vs important
- [ ] Timestamps accurate
- [ ] Pull-to-refresh works
- [ ] Clear history works
- [ ] Empty state displays correctly

### Platform:
- [ ] Android: system notifications work
- [ ] iOS: system notifications work (if testing iOS)
- [ ] Permissions requested and granted
- [ ] APK installs and runs correctly
- [ ] No crashes or errors

---

## 📸 Screenshot Capture Checklist

While testing, capture these screenshots:

1. **Token Display** (Test 2)
   - [ ] Home screen with token visible
   - [ ] Copy button visible

2. **Token in Terminal** (Test 1)
   - [ ] Terminal output with token between `═══` lines

3. **Regular Notification Foreground** (Test 3)
   - [ ] Blue dialog open

4. **Important Notification Foreground** (Test 4)
   - [ ] Red dialog with warning icon

5. **System Notification** (Test 5)
   - [ ] Notification tray with notification

6. **Notification History** (Test 7)
   - [ ] List with multiple notifications

7. **Data Payload** (Test 4 or 7)
   - [ ] Dialog or card showing `{type: important}`

8. **Firebase Console** (Any test)
   - [ ] Test message setup with custom data

---

## 🎯 Acceptance Criteria

### Minimum to Pass:

✅ **Must Have:**
- Firebase initialized
- Token displays
- Regular notifications work in all states
- Important notifications work in all states
- Different UI for each type
- History displays notifications

✅ **Should Have:**
- Token copyable
- Vibration for important
- Data payload displays
- Clear history works
- No major bugs

✅ **Nice to Have:**
- Timestamps
- Pull-to-refresh
- Empty state
- Error handling

---

## 🐛 Bug Report Template

If you find issues during testing:

**Bug Title**: [Short description]

**Steps to Reproduce**:
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Expected Behavior**:
[What should happen]

**Actual Behavior**:
[What actually happens]

**Environment**:
- OS: [Android 12 / iOS 16]
- Device: [Pixel 6 / iPhone 13]
- Flutter version: [3.x.x]

**Screenshots**:
[If applicable]

**Console Output**:
```
[Error logs]
```

---

## ✅ Final Testing Sign-Off

Once all tests pass:

- [ ] All 10 test scenarios passed
- [ ] All 8 screenshots captured
- [ ] No critical bugs found
- [ ] App ready for submission

**Tested By**: [Your Name]  
**Date**: [Test Date]  
**Device**: [Device Model]  
**Result**: PASS / FAIL

---

🎉 **Testing Complete!** Your app is ready for submission.
