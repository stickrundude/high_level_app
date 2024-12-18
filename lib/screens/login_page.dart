import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/services/firebase_service.dart';
import '/utils/validators.dart';
import 'home_page.dart';
import 'signup_page.dart';
import '/services/login_services.dart';
import 'package:audioplayers/audioplayers.dart';
import '/widgets/background.dart';
import '/main.dart';
import '/generated/l10n.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AudioPlayer audioPlayer = AudioPlayer();
  final String welcomeAudioPath = 'audio/welcome.mp3';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginService loginService =
      LoginService(firebaseServices: FirebaseServices());

  String _selectedLanguage = 'en';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    checkIfUserIsLoggedIn();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      playWelcomeAudio();
    });
  }

  void checkIfUserIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TravelMateHomePage(),
        ),
      );
    }
  }

  void playWelcomeAudio() {
    audioPlayer.play(AssetSource(welcomeAudioPath));
    print("Audio played");
  }

  Future<void> loginUser(BuildContext context) async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (Validators.isEmptyField(email) || Validators.isEmptyField(password)) {
      Fluttertoast.showToast(
        msg: S.of(context).fillEmailPassword,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    if (!Validators.isValidEmail(email)) {
      Fluttertoast.showToast(
        msg: S.of(context).invalidEmail,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    bool isSuccess = await loginService.loginUser(email, password);
    setState(() {
      isLoading = false;
    });

    if (isSuccess) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);

      Fluttertoast.showToast(msg: S.of(context).loginSuccess);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TravelMateHomePage(),
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: S.of(context).loginFailed,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  void navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      ),
    );
  }

  void changeLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', languageCode);

    Locale newLocale = Locale(languageCode, '');
    MyApp.setLocale(context, newLocale);
    setState(() {
      _selectedLanguage = languageCode;
    });
  }

  void _setLanguageFromLocale() {
    Locale currentLocale = Localizations.localeOf(context);
    setState(() {
      _selectedLanguage = currentLocale.languageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).welcomeToTravelMate),
        centerTitle: true,
      ),
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 250,
                    width: 500,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: S.of(context).email,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: S.of(context).password,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () => loginUser(context),
                        style: Theme.of(context).elevatedButtonTheme.style,
                        child: Text(S.of(context).login),
                      ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: navigateToSignUp,
                  style: Theme.of(context).elevatedButtonTheme.style,
                  child: Text(S.of(context).signUp),
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 200,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedLanguage,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          changeLanguage(newValue);
                        }
                      },
                      items: const [
                        DropdownMenuItem(value: 'en', child: Text('English')),
                        DropdownMenuItem(value: 'de', child: Text('Deutsch')),
                      ],
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
