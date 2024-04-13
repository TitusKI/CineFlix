import 'package:cineflix/src/blocs/search/search_bloc.dart';
import 'package:cineflix/src/blocs/search/search_state.dart';

import 'package:cineflix/src/ui/favorites_page.dart';

import 'package:cineflix/src/ui/genre_page.dart';
import 'package:cineflix/src/ui/search_screen.dart';
import 'package:cineflix/src/ui/widgets/bottom_navigation.dart';
import 'package:cineflix/src/ui/widgets/carousel_container.dart';
import 'package:cineflix/src/ui/widgets/drawer.dart';
import 'package:cineflix/src/ui/widgets/movie-show_carousell.dart';
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

class _MovieListState extends State<MovieList> with TickerProviderStateMixin {
  int _selectedBottomNavIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onBottomNavIndexChanged(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
    });

    print(_selectedBottomNavIndex);
  }

  @override
  Widget build(BuildContext context) {
    Widget body = HomePage();

    if (_selectedBottomNavIndex == 1) {
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
              index: _selectedBottomNavIndex,
              onIndexChanged: _onBottomNavIndexChanged),
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
        TabBar(
          dividerColor: Colors.transparent,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
                width: 4.0,
                color: Colors.red), // Customize the indicator width and color
            insets: EdgeInsets.symmetric(
                horizontal: 16.0), // Adjust the indicator padding
          ),
          tabs: const [
            Tab(
              child: Text(
                "Movies",
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            ),
            Tab(
              child: Text(
                "Tv Shows",
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            ),
          ],
          controller: _tabController,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              CarouselContainer(carouselList: [
                MovieShowCarousel(
                  categoryId: 1,
                  mediaId: 1,
                  title: "Popular Movies",
                ),
                MovieShowCarousel(
                  categoryId: 2,
                  mediaId: 1,
                  title: "Upcoming Movies",
                ),
                MovieShowCarousel(
                  categoryId: 3,
                  mediaId: 1,
                  title: "Top Rated",
                ),
                MovieShowCarousel(
                  categoryId: 4,
                  mediaId: 1,
                  title: "Now Playing",
                ),
              ]),
              CarouselContainer(carouselList: [
                MovieShowCarousel(
                  categoryId: 1,
                  mediaId: 2,
                  title: "Popular Shows",
                ),
                MovieShowCarousel(
                  categoryId: 2,
                  mediaId: 2,
                  title: "Airing Today",
                ),
                MovieShowCarousel(
                  categoryId: 2,
                  mediaId: 3,
                  title: "Top Rated",
                ),
                MovieShowCarousel(
                  categoryId: 2,
                  mediaId: 4,
                  title: "On Tv",
                ),
              ]),
            ],
          ),
        ),
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
