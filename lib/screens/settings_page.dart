import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For persisting language
import '/services/user_services.dart';
import '/models/user.dart';
import 'package:high_level_application/screens/login_page.dart';
import 'package:high_level_application/main.dart'; // Localization setup

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController = TextEditingController();
  final TextEditingController currentPasswordController = TextEditingController();
  final UserService _userService = UserService();
  String? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadLanguagePreference(); // Load the saved language preference
  }

  // Load user data
  Future<void> _loadUserData() async {
    String? uid = await _userService.getCurrentUserUid();
    if (uid != null) {
      var userData = await _userService.getUserData(uid);
      if (userData != null) {
        setState(() {
          firstNameController.text = userData['firstName'] ?? '';
          lastNameController.text = userData['lastName'] ?? '';
          emailController.text = userData['email'] ?? '';
        });
      }
    }
  }

  // Load the saved language preference
  Future<void> _loadLanguagePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs.getString('languageCode') ?? 'en'; // Default to 'en'
    setState(() {
      _selectedLanguage = savedLanguage;
    });
  }

  // Save the selected language preference
  Future<void> _saveLanguagePreference(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', languageCode); // Save language
  }

  // Update the language
  void _changeLanguage(String? languageCode) {
    if (languageCode != null) {
      setState(() {
        _selectedLanguage = languageCode;
      });

      // Save the selected language
      _saveLanguagePreference(languageCode);

      // Change the locale in the main app
      Locale newLocale = Locale(languageCode);
      HighLevelApplication.of(context)?.setLocale(newLocale);
    }
  }

  // Logout user
  void _logout() {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  // Save user settings group 1 (name, email)
  void saveGroup1() async {
    try {
      String? uid = await _userService.getCurrentUserUid();
      if (uid != null) {
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

  // Save user settings group 2 (password)
  void saveGroup2() async {
    if (passwordController.text == repeatPasswordController.text) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          String currentPassword = currentPasswordController.text;
          AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!,
            password: currentPassword,
          );
          await user.reauthenticateWithCredential(credential);
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
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings)),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Settings Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: Text(AppLocalizations.of(context)!.logout),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: _selectedLanguage,
                  onChanged: (String? newLanguage) {
                    if (newLanguage != null) {
                      _changeLanguage(newLanguage);
                    }
                  },
                  items: <String>['en', 'de']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value == 'en' ? 'English' : 'Deutsch',
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.firstName),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.lastName),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.email),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: saveGroup1,
                      child: Text(AppLocalizations.of(context)!.save),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: currentPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.currentPassword),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.password),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: repeatPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.repeatPassword),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: saveGroup2,
                      child: Text(AppLocalizations.of(context)!.changePassword),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
