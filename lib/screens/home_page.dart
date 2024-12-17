import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'settings_page.dart';
import 'map_page.dart';
import 'camera_page.dart';
import 'notes_page.dart';
import '../widgets/custom_navigation_bar.dart'; // Custom Navigation Bar
import '/services/user_services.dart';

class TravelMateHomePage extends StatefulWidget {
  const TravelMateHomePage({super.key});

  @override
  State<TravelMateHomePage> createState() => _TravelMateHomePageState();
}

class _TravelMateHomePageState extends State<TravelMateHomePage> {
  int _selectedIndex = 0;
  String firstName = "";
  final UserService _userService = UserService();

  static final List<Widget> _pages = <Widget>[
    MapPage(),
    CameraPage(),
    NotesPage(),
    SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserData();  // Fetch the user data when the page is initialized
  }

  Future<void> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final userData = await _userService.getUserData(user.uid);
        setState(() {
          firstName = userData?['firstName'] ?? "User"; // Default to "User" if no first name
        });
      } catch (e) {
        Fluttertoast.showToast(msg: "Error fetching user data: $e");
      }
    }
  }

  // Handles the tap on a bottom navigation item
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
          firstName.isNotEmpty ? "Logged in as $firstName" : "Loading...", // Show user's name
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _pages[_selectedIndex]),  // Display page based on selection
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(  // Bottom navigation bar
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
