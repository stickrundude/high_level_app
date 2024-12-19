import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/screens/login_page.dart';
import '/widgets/background.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/services/user_services.dart';
import '/main.dart';
import '/generated/l10n.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  final UserService _userService = UserService();
  String _selectedLanguage = 'en';
  bool _isEmailChanged = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadLanguagePreference();

    emailController.addListener(() {
      setState(() {
        _isEmailChanged = emailController.text.isNotEmpty &&
            emailController.text != FirebaseAuth.instance.currentUser?.email;
      });
    });
  }

  @override
  void dispose() {
    emailController.removeListener(() {});
    super.dispose();
  }

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

  Future<void> _loadLanguagePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs.getString('language_code') ?? 'en';
    setState(() {
      _selectedLanguage = savedLanguage;
    });
    Locale newLocale = Locale(savedLanguage, '');
    MyApp.setLocale(context, newLocale);
  }

  void savePersonalInfo() async {
    try {
      String? uid = await _userService.getCurrentUserUid();
      User? user = FirebaseAuth.instance.currentUser;

      if (uid != null && user != null) {
        if (_isEmailChanged) {
          await user.reauthenticateWithCredential(
            EmailAuthProvider.credential(
              email: user.email!,
              password: currentPasswordController.text,
            ),
          );
          await user.updateEmail(emailController.text);
        }

        await _userService.updateUserData(uid, {
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'email': emailController.text,
        });

        Fluttertoast.showToast(msg: S.of(context).personalInfoUpdated);
      }
    } catch (e) {
      _showError(e.toString());
    }
  }

  void savePassword() async {
    if (currentPasswordController.text.isEmpty ||
        passwordController.text.isEmpty ||
        repeatPasswordController.text.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).fillAllFields);
      return;
    }

    if (passwordController.text != repeatPasswordController.text) {
      Fluttertoast.showToast(msg: S.of(context).passwordsDoNotMatch);
      return;
    }

    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.reauthenticateWithCredential(
          EmailAuthProvider.credential(
            email: user.email!,
            password: currentPasswordController.text,
          ),
        );

        await user.updatePassword(passwordController.text);
        Fluttertoast.showToast(msg: S.of(context).passwordUpdated);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: S.of(context).wrongCurrentPassword);
      } else {
        Fluttertoast.showToast(msg: S.of(context).error(e.message ?? ''));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: S.of(context).error(e.toString()));
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _logout() async {
    bool? confirmLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).confirmLogout),
          content: Text(S.of(context).areYouSureYouWantToLogout),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(S.of(context).no),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(S.of(context).yes),
            ),
          ],
        );
      },
    );

    if (confirmLogout == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String languageCode = prefs.getString('language_code') ?? 'en';
      await prefs.clear();

      await prefs.setString('language_code', languageCode);

      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginPage()));
    }
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

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(S.of(context).settings),
          backgroundColor: const Color.fromARGB(255, 75, 177, 246),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor ??
                      const Color.fromARGB(255, 75, 177, 246),
                ),
                child: const Text(
                  "Menu",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: Text(S.of(context).logout),
                onTap: _logout,
              ),
            ],
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildSectionHeader(S.of(context).personalInfo),
            _buildPersonalInfoForm(),
            const SizedBox(height: 20),
            _buildSectionHeader(S.of(context).changePassword),
            _buildPasswordChangeForm(),
            const SizedBox(height: 20),
            _buildLanguageDropdown(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget _buildPersonalInfoForm() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: S.of(context).firstName),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: S.of(context).lastName),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: S.of(context).email),
            ),
            const SizedBox(height: 10),
            if (_isEmailChanged) ...[
              TextField(
                controller: currentPasswordController,
                obscureText: true,
                decoration:
                    InputDecoration(labelText: S.of(context).currentPassword),
              ),
              const SizedBox(height: 10),
              Text(
                S.of(context).emailChangeRequiresPassword,
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: savePersonalInfo,
              child: Text(S.of(context).savePersonalInfo),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordChangeForm() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              decoration:
                  InputDecoration(labelText: S.of(context).currentPassword),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: S.of(context).newPassword),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: repeatPasswordController,
              obscureText: true,
              decoration:
                  InputDecoration(labelText: S.of(context).repeatNewPassword),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: savePassword,
              child: Text(S.of(context).updatePassword),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return Align(
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
    );
  }
}
