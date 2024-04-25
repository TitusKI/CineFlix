import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final ValueChanged<int> onIndexChanged;

  const BottomNavigation({super.key, required this.onIndexChanged});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.,
      margin: const EdgeInsets.symmetric(horizontal: 72, vertical: 12),
      height: 66,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 31, 31, 31),
          border: Border.all(color: Colors.red, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(33)),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(60, 66, 64, 64),
                offset: Offset(0, 20),
                blurRadius: 20)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (currentIndex != 0) {
                setState(() {
                  currentIndex = 0;
                });
                widget.onIndexChanged(currentIndex);
              }
              print(currentIndex);
            },
            child: SizedBox(
              height: 36,
              width: 36,
              child: currentIndex != 0
                  ? const Icon(Icons.home_outlined, size: 32)
                  : const Icon(
                      Icons.home,
                      size: 36,
                      color: Colors.red,
                    ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (currentIndex != 1) {
                setState(() {
                  currentIndex = 1;
                });
                widget.onIndexChanged(currentIndex);
              }
              print(currentIndex);
            },
            child: SizedBox(
              height: 36,
              width: 36,
              child: currentIndex != 1
                  ? const Icon(
                      Icons.movie_outlined,
                      size: 32,
                    )
                  : const Icon(
                      Icons.movie,
                      size: 36,
                      color: Colors.red,
                    ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (currentIndex != 2) {
                setState(() {
                  currentIndex = 2;
                });
                widget.onIndexChanged(currentIndex);
              }
              print(currentIndex);
            },
            child: SizedBox(
              height: 36,
              width: 36,
              child: currentIndex != 2
                  ? const Icon(Icons.favorite_outline, size: 32)
                  : const Icon(
                      Icons.favorite,
                      size: 36,
                      color: Colors.red,
                    ),
            ),
          )
        ],
      ),
    );
  }
}

    //   BottomNavigationBar(
    //       currentIndex: index,
    //       onTap: onIndexChanged,
    //       selectedItemColor: Colors.white,
    //       unselectedItemColor: const Color.fromARGB(255, 190, 190, 190),
    //       iconSize: 30,
    //       // backgroundColor: Colors.black,
    //       items: const [
    //         BottomNavigationBarItem(
    //             icon: Icon(Icons.home_outlined),
    //             activeIcon: Icon(Icons.home),
    //             backgroundColor: Color.fromARGB(255, 187, 187, 187),
    //             label: "Home"),
    //         BottomNavigationBarItem(
    //             activeIcon: Icon(Icons.movie),
    //             icon: Icon(Icons.movie_outlined),
    //             backgroundColor: Color.fromARGB(255, 187, 187, 187),
    //             label: "Genre"),
    //         BottomNavigationBarItem(
    //             activeIcon: Icon(Icons.favorite),
    //             icon: Icon(Icons.favorite_outline),
    //             backgroundColor: Color.fromARGB(255, 187, 187, 187),
    //             label: "Favorites"),
    //       ]);
    // }