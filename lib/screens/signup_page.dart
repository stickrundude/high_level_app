import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/services/signup_services.dart';
import '/utils/validators.dart';
import '/widgets/background.dart';
import '/generated/l10n.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  bool isPasswordVisible = false;
  bool isLoading = false;

  Future<void> signUp(BuildContext context) async {
    final signUpService = SignUpService();

    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final String firstName = firstNameController.text.trim();
    final String lastName = lastNameController.text.trim();

    if (!Validators.isValidName(firstName)) {
      Fluttertoast.showToast(msg: S.of(context).firstNameError);
      return;
    }

    if (!Validators.isValidName(lastName)) {
      Fluttertoast.showToast(msg: S.of(context).lastNameError);
      return;
    }

    if (!Validators.isValidEmail(email)) {
      Fluttertoast.showToast(msg: S.of(context).emailError);
      return;
    }

    if (!Validators.isValidPassword(password)) {
      Fluttertoast.showToast(msg: S.of(context).passwordError);
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      bool isSuccess = await signUpService.signUpUser(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );

      setState(() {
        isLoading = false;
      });

      if (isSuccess) {
        Fluttertoast.showToast(msg: S.of(context).signUpSuccess);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: S.of(context).signUpFailure);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: S.of(context).signUpError(e.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
        centerTitle: true,
      ),
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 200),
                TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: S.of(context).firstNameLabel,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: S.of(context).lastNameLabel,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: S.of(context).emailLabel,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: S.of(context).passwordLabel,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () => signUp(context),
                        child: Text(S.of(context).signUpButton),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
