import 'package:flutter/material.dart';
import '/screens/login_page.dart';
import '/theme/app_theme.dart';
import '/utils/constants.dart';
import '/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const TravelMateApp());
}

class TravelMateApp extends StatefulWidget {
  const TravelMateApp({super.key});

  @override
  _TravelMateAppState createState() => _TravelMateAppState();
}

class _TravelMateAppState extends State<TravelMateApp> {
  bool _isFirebaseInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    try {
      await FirebaseServices.initializeFirebase();
      if (mounted) {
        setState(() {
          _isFirebaseInitialized = true;
        });
      }
    } catch (e) {
      print('Error initializing Firebase: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: AppTheme.lightTheme,
      home: _isFirebaseInitialized
          ? const LoginPage()
          : const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
