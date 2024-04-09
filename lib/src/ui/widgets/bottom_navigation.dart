import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final ValueChanged<int> onIndexChanged;

  const BottomNavigation({super.key, required this.onIndexChanged});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: 0,
        onTap: onIndexChanged,
        selectedItemColor: Colors.blue,
        iconSize: 30,
        backgroundColor: Colors.amber,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              backgroundColor: Color.fromARGB(255, 17, 93, 156),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              backgroundColor: Color.fromARGB(255, 17, 93, 156),
              label: "Genre"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              backgroundColor: Color.fromARGB(255, 17, 93, 156),
              label: "Favorites"),
        ]);
  }
}
