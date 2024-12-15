import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:high_level_application/utils/constants.dart';
import '/screens/login_page.dart';
import '/theme/app_theme.dart';
import '/services/firebase_service.dart';
import '/services/notification_service.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the notification service
  NotificationService notificationService = NotificationService();
  await notificationService.initialize();

  // Request notification permission (for Android 13+)
  await requestNotificationPermission();

  // Initialize Firebase
  await FirebaseServices.initializeFirebase();

  // Start the background service
  await FlutterBackgroundService().startService();
  print("Background Service started in main.dart");

  runApp(const TravelMateApp());
}

Future<void> requestNotificationPermission() async {
  // Check if the user has already granted notification permission
  final status = await Permission.notification.request();

  if (status.isGranted) {
    print("Notification permission granted");
  } else {
    print("Notification permission denied");
  }
}

class TravelMateApp extends StatefulWidget {
  const TravelMateApp({super.key});

  @override
  State<TravelMateApp> createState() => _TravelMateAppState();
}

class _TravelMateAppState extends State<TravelMateApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state);

    // Detect if the app is minimized or in the background
    if (state == AppLifecycleState.paused) {
      print("App is minimized or backgrounded");

      // Invoke the background service to trigger the notification
      FlutterBackgroundService().invoke("scheduleNotification", {"action": "scheduleNotification"});
      print("Invoke method has been sent from main");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: AppTheme.lightTheme,
      home: const LoginPage(),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Clean up the observer when the widget is disposed
    super.dispose();
  }
}
