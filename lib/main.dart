import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import '/screens/login_page.dart';
import '/theme/app_theme.dart';
import '/services/firebase_service.dart';
import '/utils/constants.dart';
import 'generated/intl/messages_all.dart'; // Ensure correct import path for generated localization files
import 'package:shared_preferences/shared_preferences.dart';
import 'package:high_level_application/screens/settings_page.dart'; // Ensure you import the settings page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await FirebaseServices.initializeFirebase();

  // Initialize localization messages for default locale 'en'
  await initializeMessages('de');
  print("Localization messages initialized for 'de'");

  runApp(const HighLevelApplication());
}

class HighLevelApplication extends StatefulWidget {
  const HighLevelApplication({super.key});

  static _HighLevelApplicationState? of(BuildContext context) {
    return context.findAncestorStateOfType<_HighLevelApplicationState>();
  }

  @override
  _HighLevelApplicationState createState() => _HighLevelApplicationState();
}

class _HighLevelApplicationState extends State<HighLevelApplication> {
  Locale _locale = const Locale('en'); // Default locale is 'en'

  @override
  void initState() {
    super.initState();
    _loadLanguagePreference(); // Load saved language preference on startup
  }

  // Load the saved language preference
  Future<void> _loadLanguagePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs.getString('languageCode') ?? 'en'; // Default to 'en'
    setState(() {
      _locale = Locale(savedLanguage);
    });
    print("Loaded language preference: $_locale");
  }

  // Set the locale and save the language preference
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });

    // Save the selected language
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('languageCode', locale.languageCode);
      print("Locale set to: ${locale.languageCode}");
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle, // App name preserved
      locale: _locale,
      theme: AppTheme.lightTheme, // Apply custom theme
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,  // Custom localization delegate
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('de', ''),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale != null && supportedLocales.contains(locale)) {
          return locale;
        }
        return const Locale('en', 'US');  // Default to English if unsupported language
      },
      home: const LoginPage(),  // Default home page is LoginPage
    );
  }
}

// Custom localization class to manage translations
class AppLocalizations {
  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Localization strings
  String get welcome => Intl.message('Welcome to TravelMate', name: 'welcome');
  String get login => Intl.message('Login', name: 'login');
  String get signUp => Intl.message('Sign Up', name: 'signUp');
  String get firstName => Intl.message('First Name', name: 'firstName');
  String get lastName => Intl.message('Last Name', name: 'lastName');
  String get email => Intl.message('Email', name: 'email');
  String get password => Intl.message('Password', name: 'password');
  String get currentPassword => Intl.message("Current Password", name: 'currentPassword');
  String get changePassword => Intl.message("Change Password", name: 'changePassword');
  String get repeatPassword => Intl.message("Repeat Password", name: 'repeatPassword');
  String get loginSuccess => Intl.message('Login Successful', name: 'loginSuccess');
  String get loginFailed => Intl.message('Login failed. Please check your credentials.', name: 'loginFailed');
  String get signupFailed => Intl.message('Sign-up failed. Please try again.', name: 'signupFailed');
  String get signupSuccess => Intl.message('Sign-up successful!', name: 'signupSuccess');
  String get save => Intl.message("Save", name: 'save');
  String get language => Intl.message("Language", name: 'language');
  String get settings => Intl.message("Settings", name: 'settings');
  String get logout => Intl.message("Logout", name: 'logout');
}

// Localization delegate
class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'de'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    await initializeMessages(locale.languageCode);
    print("Localization messages initialized for '${locale.languageCode}'");
    return AppLocalizations();
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
