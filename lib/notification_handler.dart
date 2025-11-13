// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/notification_model.dart';

/// Global list to store notification history
/// Accessible throughout the app
List<NotificationModel> notificationHistory = [];

/// REQUIRED: Background message handler
/// Must be a top-level function (not inside a class)
/// This handles notifications when app is in background or terminated
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('🔔 Background Message Received!');
  print('Message ID: ${message.messageId}');
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Data: ${message.data}');

  // Store notification in history
  final notification = NotificationModel(
    id: message.messageId ?? DateTime.now().toString(),
    type: message.data['type'] ?? 'regular',
    title: message.notification?.title ?? 'No Title',
    body: message.notification?.body ?? 'No Body',
    data: message.data,
    timestamp: DateTime.now(),
  );

  notificationHistory.insert(0, notification);
}

/// Main notification handler class
/// Manages all FCM setup and notification handling
class NotificationHandler {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? _fcmToken;

  /// Get the FCM token for this device
  String? get fcmToken => _fcmToken;

  /// Initialize Firebase Cloud Messaging
  /// Requests permissions and sets up listeners
  Future<void> initialize(BuildContext context) async {
    print('🚀 Initializing Firebase Cloud Messaging...');

    // Request permission for iOS (Android auto-grants)
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('✅ User granted notification permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('⚠️ User granted provisional notification permission');
    } else {
      print('❌ User declined notification permission');
    }

    // Get FCM token
    await _getFCMToken();

    // Set up foreground notification presentation options
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Listen to foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (context.mounted) {
        _handleForegroundMessage(context, message);
      }
    });

    // Listen to background/terminated tap events
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (context.mounted) {
        _handleNotificationTap(context, message);
      }
    });

    // Check if app was opened from a terminated state notification
    RemoteMessage? initialMessage = await _firebaseMessaging
        .getInitialMessage();
    if (initialMessage != null && context.mounted) {
      print('📱 App opened from terminated state notification');
      _handleNotificationTap(context, initialMessage);
    }

    print('✅ FCM Initialization Complete!');
  }

  /// Retrieve and print FCM token
  Future<void> _getFCMToken() async {
    try {
      // Get the token
      _fcmToken = await _firebaseMessaging.getToken();

      print('\n═══════════════════════════════════════');
      print('📱 FCM TOKEN (COPY THIS FOR TESTING):');
      print('═══════════════════════════════════════');
      print(_fcmToken);
      print('═══════════════════════════════════════\n');

      // Listen for token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        print('🔄 FCM Token Refreshed: $newToken');
        _fcmToken = newToken;
      });
    } catch (e) {
      print('❌ Error getting FCM token: $e');
    }
  }

  /// Handle foreground messages (when app is open and visible)
  void _handleForegroundMessage(BuildContext context, RemoteMessage message) {
    print('📬 Foreground Message Received!');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Data: ${message.data}');

    // Create notification model
    final notification = NotificationModel(
      id: message.messageId ?? DateTime.now().toString(),
      type: message.data['type'] ?? 'regular',
      title: message.notification?.title ?? 'No Title',
      body: message.notification?.body ?? 'No Body',
      data: message.data,
      timestamp: DateTime.now(),
    );

    // Add to history
    notificationHistory.insert(0, notification);

    // Show dialog based on notification type
    _showNotificationDialog(context, notification);
  }

  /// Handle notification tap (when user taps notification)
  void _handleNotificationTap(BuildContext context, RemoteMessage message) {
    print('👆 Notification Tapped!');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Data: ${message.data}');

    // Create notification model
    final notification = NotificationModel(
      id: message.messageId ?? DateTime.now().toString(),
      type: message.data['type'] ?? 'regular',
      title: message.notification?.title ?? 'No Title',
      body: message.notification?.body ?? 'No Body',
      data: message.data,
      timestamp: DateTime.now(),
    );

    // Show dialog
    _showNotificationDialog(context, notification);
  }

  /// Display notification dialog with different styles based on type
  void _showNotificationDialog(
    BuildContext context,
    NotificationModel notification,
  ) {
    // Vibrate for important notifications
    if (notification.isImportant) {
      HapticFeedback.heavyImpact();
      // Vibrate twice for emphasis
      Future.delayed(const Duration(milliseconds: 200), () {
        HapticFeedback.heavyImpact();
      });
    } else {
      HapticFeedback.lightImpact();
    }

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        if (notification.isImportant) {
          // IMPORTANT NOTIFICATION DIALOG
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.shade900,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.red, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withValues(alpha: 0.5),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Important Icon
                  Icon(
                    Icons.warning_rounded,
                    size: 60,
                    color: Colors.yellow.shade300,
                  ),
                  const SizedBox(height: 15),
                  // Type Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '⚠️ IMPORTANT',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Title
                  Text(
                    notification.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  // Body
                  Text(
                    notification.body,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  // Data payload if exists
                  if (notification.data.isNotEmpty) ...[
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Data Payload:',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            notification.data.toString(),
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  // Close Button
                  ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    label: const Text('CLOSE'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          // REGULAR NOTIFICATION DIALOG
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Row(
              children: [
                Icon(Icons.notifications_active, color: Colors.blue.shade700),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Notification',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Regular',
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  notification.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // Body
                Text(notification.body, style: const TextStyle(fontSize: 16)),
                // Data payload if exists
                if (notification.data.isNotEmpty) ...[
                  const SizedBox(height: 15),
                  const Text(
                    'Data Payload:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      notification.data.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        }
      },
    );
  }
}
