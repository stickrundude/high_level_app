import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'settings_page.dart';
import 'map_page.dart';
import 'camera_page.dart';
import 'notes_page.dart';
import '../widgets/custom_navigation_bar.dart';

class TravelMateHomePage extends StatefulWidget {
  const TravelMateHomePage({super.key});

  @override
  State<TravelMateHomePage> createState() => _TravelMateHomePageState();
}

class _TravelMateHomePageState extends State<TravelMateHomePage> {
  int _selectedIndex = 0;
  String firstName = "";

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
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            firstName = userDoc['firstName'] ?? "User";
          });
        }
      } catch (e) {
        print("Error fetching user data: $e");
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
          firstName.isNotEmpty ? "Logged in as $firstName" : "Loading...",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
