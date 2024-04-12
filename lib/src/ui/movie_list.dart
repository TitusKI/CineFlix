import 'package:cineflix/src/blocs/search/search_bloc.dart';
import 'package:cineflix/src/blocs/search/search_state.dart';

import 'package:cineflix/src/common/values/colors.dart';

import 'package:cineflix/src/resources/people_api_provider.dart';
import 'package:cineflix/src/ui/favorites_page.dart';

import 'package:cineflix/src/ui/genre_page.dart';
import 'package:cineflix/src/ui/search_screen.dart';
import 'package:cineflix/src/ui/widgets/bottom_navigation.dart';
import 'package:cineflix/src/ui/widgets/drawer.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'movie_list_tile.dart';

import '../blocs/movies_bloc.dart';
import 'package:flutter/material.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  int _selectedIndex = 0;
  void _onIndexChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });

    print(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    Widget body = HomePage();

    if (_selectedIndex == 1) {
      body = const GenrePage();
    } else if (_selectedIndex == 2) {
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
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            actions: [
              Builder(builder: (context) {
                return IconButton(
                  onPressed: () {
                    bloc.handleHidePopup();
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
          body: Column(
            children: [
              Expanded(child: body),
              const Divider(),
            ],
          ),
          bottomNavigationBar: BottomNavigation(
              index: _selectedIndex, onIndexChanged: _onIndexChanged),
        );
      },
    );
  }

  Widget HomePage() {
    return Listener(
      onPointerDown: (event) {
        bloc.handleHidePopup();
      },
      child: buildList(),
    );
  }

  Widget buildList() {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildMovieListTile('Movies',
                  ["Popular ", 'Top Rated ', 'Now Playing', 'Upcoming '], 1),
              // Padding(padding: EdgeInsets.all(4.0)),
              buildMovieListTile("TV Shows",
                  ['Popular', 'Top Rated', 'Airing Today', 'On TV'], 2),
              // Padding(padding: EdgeInsets.all(4.0)),
              buildMovieListTile('People', ['Popular People'], 3),
              // Padding(padding: EdgeInsets.all(4.0)),
              buildMovieListTile('More', ['Genre'], 4)
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 250,
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: GestureDetector(
                  onTap: () {
                    // Add your onTap function here
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Latest Movies',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                color: Colors.green,
              ))
            ],
          ),
        )
      ],
    );
  }

  Widget buildMovieListTile(
      String title, List<String> popupContent, int index) {
    MovieListTile movieListTile = MovieListTile(
      txt1: popupContent.isNotEmpty ? popupContent[0] : '',
      txt2: popupContent.length > 1 ? popupContent[1] : '',
      txt3: popupContent.length > 2 ? popupContent[2] : '',
      txt4: popupContent.length > 3 ? popupContent[3] : '',
      index: index,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
    // popupContentMap[movieListTile] = popupContent;
    return movieListTile;
  }
}
