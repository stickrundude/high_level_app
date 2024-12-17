import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/services/firebase_service.dart';
import '/utils/validators.dart';
import 'home_page.dart';
import 'signup_page.dart';
import '/services/login_services.dart';
import 'package:audioplayers/audioplayers.dart';
import '/widgets/background.dart';

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

  bool isLoading = false;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      playWelcomeAudio();
    });
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
        msg: "Please fill in both email and password!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    if (!Validators.isValidEmail(email)) {
      Fluttertoast.showToast(
        msg: "Invalid email format. Please enter a valid email.",
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
      Fluttertoast.showToast(msg: 'Login Successful');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TravelMateHomePage(),
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: "Login failed. Please check your credentials.",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to TravelMate'),
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
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () => loginUser(context),
                        style: Theme.of(context).elevatedButtonTheme.style,
                        child: const Text('Login'),
                      ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: navigateToSignUp,
                  style: Theme.of(context).elevatedButtonTheme.style,
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
