import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/services/user_services.dart'; // Import the UserService
import '/models/user.dart'; // Ensure you have the AppUser model

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController firstNameController = TextEditingController(); // firstName
  final TextEditingController lastNameController = TextEditingController(); // lastName
  final TextEditingController emailController = TextEditingController(); // email
  final TextEditingController passwordController = TextEditingController(); // password
  final TextEditingController repeatPasswordController = TextEditingController(); // repeatPassword
  final TextEditingController currentPasswordController = TextEditingController(); // currentPassword

  final UserService _userService = UserService(); // Instance of UserService

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Function to load user data from Firestore and update the text controllers
  Future<void> _loadUserData() async {
    String? uid = await _userService.getCurrentUserUid();
    if (uid != null) {
      var userData = await _userService.getUserData(uid);
      if (userData != null) {
        setState(() {
          // Set the retrieved data to the controllers
          firstNameController.text = userData['firstName'] ?? '';
          lastNameController.text = userData['lastName'] ?? '';
          emailController.text = userData['email'] ?? '';
        });
      }
    }
  }

  // Function to save the first group (firstName, lastName, email)
  void saveGroup1() async {
    try {
      String? uid = await _userService.getCurrentUserUid();
      if (uid != null) {
        // Save user data to Firestore
        Map<String, dynamic> updatedData = {
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'email': emailController.text,
        };

        await _userService.updateUserData(uid, updatedData);
        Fluttertoast.showToast(msg: "User data updated successfully!");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error updating user data: $e");
    }
  }

  // Function to save the second group (password, repeatPassword)
  void saveGroup2() async {
    if (passwordController.text == repeatPasswordController.text) {
      try {
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          // Reauthenticate with the current password
          String currentPassword = currentPasswordController.text;

          AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!,
            password: currentPassword, // Use the user's current password here
          );

          // Reauthenticate the user
          await user.reauthenticateWithCredential(credential);

          // After reauthentication, update the password
          await user.updatePassword(passwordController.text);
          Fluttertoast.showToast(msg: "Password updated successfully!");
        }
      } catch (e) {
        Fluttertoast.showToast(msg: "Error updating password: $e");
      }
    } else {
      Fluttertoast.showToast(msg: "Passwords do not match!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              child: const Text('Logout'),
            ),
            const SizedBox(height: 20),

            // First group of text inputs and save button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: firstNameController,
                    decoration: const InputDecoration(labelText: 'First Name'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: lastNameController,
                    decoration: const InputDecoration(labelText: 'Last Name'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: saveGroup1,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Second group of text inputs and save button (password fields)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: currentPasswordController,
                    obscureText: true,  // Mask the password
                    decoration: const InputDecoration(labelText: 'Current Password'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    obscureText: true, // For password field
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: repeatPasswordController,
                    obscureText: true, // For repeat password field
                    decoration: const InputDecoration(labelText: 'Repeat Password'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: saveGroup2,
                    child: const Text('Change Password'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
      body: const Center(child: Text('Login Page Content')),
    );
  }
}
