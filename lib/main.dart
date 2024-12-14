import 'package:flutter/material.dart';
import '/screens/login_page.dart';
import '/theme/app_theme.dart';
import '/utils/constants.dart';
import '/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseServices.initializeFirebase();

  runApp(const TravelMateApp());
}

class TravelMateApp extends StatelessWidget {
  const TravelMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: AppTheme.lightTheme,
      home: const LoginPage(),
    );
  }
}
