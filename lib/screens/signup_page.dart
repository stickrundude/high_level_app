import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();

    bool isValidName(String name) {
      final nameRegex = RegExp(r'^[a-zA-Z]+$');
      return name.isNotEmpty && nameRegex.hasMatch(name);
    }

    bool isValidEmail(String email) {
      final emailRegex =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      return emailRegex.hasMatch(email);
    }

    bool isValidPassword(String password) {
      final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');
      return password.length >= 6 && passwordRegex.hasMatch(password);
    }

    Future<void> signUpUser(BuildContext context) async {
      try {
        final String email = emailController.text.trim();
        final String password = passwordController.text.trim();
        final String firstName = firstNameController.text.trim();
        final String lastName = lastNameController.text.trim();

        if (!isValidName(firstName)) {
          Fluttertoast.showToast(
              msg: "First Name must only contain letters and cannot be empty.");
          return;
        }

        if (!isValidName(lastName)) {
          Fluttertoast.showToast(
              msg: "Last Name must only contain letters and cannot be empty.");
          return;
        }

        if (!isValidEmail(email)) {
          Fluttertoast.showToast(msg: "Please enter a valid email.");
          return;
        }

        if (!isValidPassword(password)) {
          Fluttertoast.showToast(
              msg:
                  "Password should be at least 6 characters and contain both letters and numbers.");
          return;
        }

        final UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'firstName': firstName,
            'lastName': lastName,
            'email': email,
          });
        }

        Fluttertoast.showToast(msg: "Sign-up successful!");
        Navigator.pop(context);
      } catch (e) {
        Fluttertoast.showToast(msg: "Sign-up failed: $e");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
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
              onPressed: () => signUpUser(context),
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
