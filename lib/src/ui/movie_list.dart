import 'package:cineflix/src/blocs/search/search_bloc.dart';
import 'package:cineflix/src/blocs/search/search_state.dart';
import 'package:cineflix/src/common/values/colors.dart';
import 'package:cineflix/src/pages/Settings/setting_page.dart';

import 'package:cineflix/src/ui/favorites_page.dart';

import 'package:cineflix/src/ui/genre_page.dart';
import 'package:cineflix/src/ui/home_page.dart';
import 'package:cineflix/src/ui/search_screen.dart';
import 'package:cineflix/src/ui/widgets/bottom_navigation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> with TickerProviderStateMixin {
  int _selectedBottomNavIndex = 0;
  String? _username;
  @override
  void initState() {
    super.initState();
    // Fetch username when the drawer is initialized
    fetchUsername();
  }

  Future<void> fetchUsername() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      setState(() {
        _username = userData.get('username');
      });
    }
  }

  void _onBottomNavIndexChanged(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget? body;
    if (_selectedBottomNavIndex == 0) {
      body = const HomePage();
    } else if (_selectedBottomNavIndex == 1) {
      body = const GenrePage();
    } else if (_selectedBottomNavIndex == 2) {
      body = const FavoritesPage();
    }
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Scaffold(
          drawer: appDrawer(context),
          appBar: AppBar(
            title: const Text(
              'CineFlix',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            actions: [
              Builder(builder: (context) {
                return IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
                  },
                  icon: const Icon(
                    Icons.search,
                    weight: 50.0,
                  ),
                );
              })
            ],
          ),
          body: Stack(alignment: Alignment.bottomCenter, children: [
            body!,
            BottomNavigation(onIndexChanged: _onBottomNavIndexChanged),
          ]),
        );
      },
    );
  }

  Drawer appDrawer(BuildContext context) {
    // RegisterController registerController =RegisterController(context);
    // @override
    // void initState(){
    //   registerController.fetchUsername();
    // }
    return Drawer(
        backgroundColor: AppColors.primaryBackground,
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            SizedBox(
              height: 100.h,
              child: DrawerHeader(
                margin: const EdgeInsets.only(left: 2.0),
                decoration:
                    const BoxDecoration(color: AppColors.primaryBackground),
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/moviesAssets/profile.jpg'),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text("$_username",
                          style: TextStyle(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp))
                    ],
                  ),
                ),
              ),
            ),
            const Divider(
              color: AppColors.primarySecondaryElementText,
              thickness: 1.2,
            ),
            drawerTile("settings", "Settings", () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SettingsPage()));
            }),
            drawerTile("about", "About", () {
              Navigator.of(context).pop();
            }),
          ],
        ));
  }

  Widget drawerTile(String? iconName, String title, void Function() onTile) {
    return ListTile(
        leading: iconName != null ? Icon(getIconData(iconName)) : null,
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onTile);
  }

  IconData? getIconData(String iconName) {
    switch (iconName) {
      case "settings":
        return Icons.settings;
      case "about":
        return Icons.info;

      default:
        return null;
    }
  }
}
