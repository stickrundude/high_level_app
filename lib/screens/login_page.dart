import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home_page.dart';
import 'signup_page.dart';
import '/services/login_services.dart';
import 'package:audioplayers/audioplayers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  AudioPlayer audioPlayer = AudioPlayer();
  String welcomeAudioPath = 'audio/welcome.mp3';

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

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final LoginService loginService = LoginService();

    Future<void> loginUser(BuildContext context) async {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      if (!loginService.isValidEmail(email)) {
        Fluttertoast.showToast(
          msg: "Invalid email format. Please enter a valid email.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        return;
      }

      if (email.isEmpty || password.isEmpty) {
        Fluttertoast.showToast(
          msg: "Please fill in both email and password!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        return;
      }

      bool isSuccess = await loginService.loginUser(email, password);
      if (isSuccess) {
        Fluttertoast.showToast(msg: 'Login Successful');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const TravelMateHomePage(),
          ),
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to TravelMate '),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
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
    );
  }
}
