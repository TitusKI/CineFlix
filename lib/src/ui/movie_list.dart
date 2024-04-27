import 'package:cineflix/src/blocs/search/search_bloc.dart';
import 'package:cineflix/src/blocs/search/search_state.dart';

import 'package:cineflix/src/ui/favorites_page.dart';

import 'package:cineflix/src/ui/genre_page.dart';
import 'package:cineflix/src/ui/home_page.dart';
import 'package:cineflix/src/ui/search_screen.dart';
import 'package:cineflix/src/ui/widgets/bottom_navigation.dart';
import 'package:cineflix/src/ui/widgets/drawer.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> with TickerProviderStateMixin {
  int _selectedBottomNavIndex = 0;

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
}
