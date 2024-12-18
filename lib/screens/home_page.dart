import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'settings_page.dart';
import 'map_page.dart';
import 'camera_page.dart';
import 'notes_page.dart';
import '/widgets/custom_navigation_bar.dart';
import '/widgets/background.dart';
import '/services/user_services.dart';
import '/generated/l10n.dart';

class TravelMateHomePage extends StatefulWidget {
  const TravelMateHomePage({super.key});

  @override
  State<TravelMateHomePage> createState() => _TravelMateHomePageState();
}

class _TravelMateHomePageState extends State<TravelMateHomePage> {
  int _selectedIndex = 0;
  String firstName = "";
  final UserService _userService = UserService();

  static const List<Widget> _pages = <Widget>[
    MapPage(),
    CameraPage(),
    NotesPage(),
    SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final userData = await _userService.getUserData(user.uid);
        setState(() {
          firstName = userData?['firstName'] ?? "User";
        });
      } catch (e) {
        Fluttertoast.showToast(msg: "Error fetching user data: $e");
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          firstName.isNotEmpty
              ? '${S.of(context).loggedInAs} $firstName'
              : "Loading...",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: BackgroundWidget(
        child: Column(
          children: [
            Expanded(child: _pages[_selectedIndex]),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
