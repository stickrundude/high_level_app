import 'package:flutter/material.dart';
import '/generated/l10n.dart';

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.map),
          label: S.of(context).map,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.camera),
          label: S.of(context).camera,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.notes),
          label: S.of(context).notes,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: S.of(context).settings,
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      selectedLabelStyle: const TextStyle(color: Colors.white),
      unselectedLabelStyle: const TextStyle(color: Colors.white70),
      backgroundColor: const Color.fromARGB(255, 75, 177, 246),
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed,
    );
  }
}
