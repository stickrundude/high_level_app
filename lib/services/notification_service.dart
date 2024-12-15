import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize notification service
  Future<void> initialize() async {
    print("Initialize BG Service");

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Configure background service
    FlutterBackgroundService().configure(
      androidConfiguration: AndroidConfiguration(
        onStart: NotificationService.onStart, // Make sure this is static
        isForegroundMode: false,
        autoStart: true,
        initialNotificationContent: 'Background Service is running',
        initialNotificationTitle: 'Background Service',
        notificationChannelId: 'background_service_channel',
        foregroundServiceNotificationId: 112233,
        foregroundServiceTypes: [
          AndroidForegroundType.location,
          AndroidForegroundType.dataSync,
        ],
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
      ),
    );
  }

  // Static function to be used as onStart
  static void onStart(ServiceInstance service) {
    print("Background service started");

    // Listen for events from main.dart (this allows communication between main and background service)
    service.on('scheduleNotification').listen((event) async {
      print('Received scheduleNotification invoke from main.dart');
      await NotificationService().scheduleNotification();
    });

    // Perform background work (e.g., waiting 10 seconds)
    Future.delayed(const Duration(seconds: 10));

    // Trigger the notification after 10 seconds
    print("Triggering notification after 10 seconds");
    NotificationService().scheduleNotification();
  }

  // Function to schedule the notification
  Future<void> scheduleNotification() async {
    print("Notification Scheduled");
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'background_service_channel',
      'Background Service Channel',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Background Alert',
      'You have been away for 10 seconds!',
      notificationDetails,
      payload: 'background_notification_payload',
    );
  }
}
