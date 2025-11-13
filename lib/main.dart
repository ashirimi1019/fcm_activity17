// ignore_for_file: avoid_print

/// CSC 4360 - In-Class Activity 17: Firebase Cloud Messaging
/// Student: Ashir Imran
/// Date: November 12, 2025
///
/// This app demonstrates Firebase Cloud Messaging (FCM) implementation
/// with support for:
/// - Background, foreground, and terminated state notifications
/// - Different notification types (regular vs important)
/// - Custom notification UI based on type
/// - Notification history display
/// - FCM token display and management

library;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'notification_handler.dart';
import 'screens/home_screen.dart';

/// Entry point of the application
/// Initializes Firebase before running the app
void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  print('🚀 Starting FCM Activity 17...');

  try {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Firebase initialized successfully');

    // Register background message handler BEFORE runApp()
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    print('✅ Background message handler registered');
  } catch (e) {
    print('❌ Error initializing Firebase: $e');
  }

  runApp(const MyApp());
}

/// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FCM Activity 17',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(foregroundColor: Colors.white),
      ),
      home: const FCMHomePage(),
    );
  }
}

/// Home page wrapper that initializes FCM
class FCMHomePage extends StatefulWidget {
  const FCMHomePage({super.key});

  @override
  State<FCMHomePage> createState() => _FCMHomePageState();
}

class _FCMHomePageState extends State<FCMHomePage> {
  final NotificationHandler _notificationHandler = NotificationHandler();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeFCM();
  }

  /// Initialize Firebase Cloud Messaging
  Future<void> _initializeFCM() async {
    try {
      await _notificationHandler.initialize(context);
      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      print('❌ Error initializing FCM: $e');

      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to initialize FCM: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Loading screen while initializing Firebase + FCM
    if (!_isInitialized) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.blue.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                SizedBox(height: 24),
                Text(
                  'Initializing Firebase Cloud Messaging...',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Once initialized → load main home screen
    return HomeScreen(notificationHandler: _notificationHandler);
  }
}
