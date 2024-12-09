import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'screens/login_page.dart';

void main() {
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic stuff')
      ],
      debug: true,
  );
  runApp(const TravelMateApp());
}

class TravelMateApp extends StatefulWidget {
  const TravelMateApp({super.key});

  @override
  State<TravelMateApp> createState() => _TravelMateAppState();
}

class _TravelMateAppState extends State<TravelMateApp> {

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if(!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TravelMate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
