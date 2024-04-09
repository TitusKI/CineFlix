import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final ValueChanged<int> onIndexChanged;
  final int index;

  const BottomNavigation(
      {super.key, required this.onIndexChanged, required this.index});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: index,
        onTap: onIndexChanged,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 190, 190, 190),
        iconSize: 30,
        backgroundColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              backgroundColor: Color.fromARGB(255, 187, 187, 187),
              label: "Home"),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.movie),
              icon: Icon(Icons.movie_outlined),
              backgroundColor: Color.fromARGB(255, 187, 187, 187),
              label: "Genre"),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.favorite),
              icon: Icon(Icons.favorite_outline),
              backgroundColor: Color.fromARGB(255, 187, 187, 187),
              label: "Favorites"),
        ]);
  }
}
