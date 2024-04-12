import 'package:cineflix/src/blocs/search/search_bloc.dart';
import 'package:cineflix/src/blocs/search/search_state.dart';
<<<<<<< HEAD
import 'package:cineflix/src/common/values/colors.dart';
=======
import 'package:cineflix/src/resources/people_api_provider.dart';
import 'package:cineflix/src/ui/favorites_page.dart';
>>>>>>> 143074ab4b27096615a2c8f185d646cd47bd116c
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

  //all its properties are immutable
  @override
  State<StatefulWidget> createState() {
    return MovieListState(hidePopup: () {});
  }
}

class MovieListState extends State<MovieList> {
  int _selectedIndex = 0;

  void _onIndexChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });

    print(_selectedIndex);
  }

  final VoidCallback hidePopup;
  MovieListState({required this.hidePopup});

  // ignore: empty_constructor_bodies
  @override
  void initState() {
    super.initState();
    // bloc.fetchAllMovies();
    // bloc.fetchMoviesForIndex(1);
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget body = HomePage();

    if (_selectedIndex == 1) {
      body = const GenrePage();
    } else if (_selectedIndex == 2) {
      body = const FavoritesPage();
    }
    // bloc.fetchAllMovies();
    // bloc.fetchMoviesForIndex(1);
    // return StreamBuilder(
    //   stream: bloc.getStreamForIndex(1),
    //   builder: (context, AsyncSnapshot<ItemModel?> snapshot) {
    //     if (snapshot.hasData) {
    //       return buildList(snapshot);
    //     } else if (snapshot.connectionState == ConnectionState.none ||
    //         snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     } else if (snapshot.connectionState == ConnectionState.done) {
    //       return const Center(
    //         child: Text('No data avaliable'),
    //       );
    //     }

    //     return const Center(child: Text('ERRor'));
    //   },
    // );
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

  // ignore: non_constant_identifier_names
  Widget HomePage() {
    return Listener(
      onPointerDown: (event) {
        bloc.handleHidePopup();
      },
      child: buildList(),
    );
  }

// AsyncSnapshot<ItemModel?> snapshot
  // Map<MovieListTile, List<String>> popupContentMap = {};
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
<<<<<<< HEAD
          color: AppColors.primaryBackground,
          child: ListView(shrinkWrap: true, children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/cineflix.jpg'),
                      fit: BoxFit.cover)),
              child: const Column(
                // crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    "Welcome.",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
=======
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
>>>>>>> 143074ab4b27096615a2c8f185d646cd47bd116c
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
        // Container(
//   color: const Color.fromARGB(3, 39, 9, 191),
        //   child: ListView(shrinkWrap: true, children: [
// Container(
        //       decoration: const BoxDecoration(
        //           image: DecorationImage(
//     image: AssetImage('assets/cineflix.jpg')//     fit: BoxFit.cover)),
        //
        //        const Column(
        //         // crossAxisAlignment: CrossAxisAlignment.baseline,
        //         children: [
        //           Text(
        //             "Welcome.",
        //             style: TextStyle(
        //                 fontSize: 25,
        //                 fontWeight: FontWeight.bold,
        //                 color: Colors.white),
        //           ),
        //           Text(
        //             "Millions of movies, TV shows and people to discover. Explore now.",
        //             style: TextStyle(
        //                 fontSize: 20,
        //// color: Colors.white//        ),
        //           SizedBox(
        //             height: 25,
        //////Stack(
        //           //     children: [ClipRRect(
        //           //       borderRadius: BorderRadius.circular(25.0),
        //           //       child: Container(
        //           //         padding:
        //           //             EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        //           //         decoration: BoxDecoration(
        //           //           color: Colors.white,
        //           //         ),
        //           //         // child: SearchScreen()

        //           //       ),
        //           //     ),
        //           // ]),
        //           SizedBox(
        //             height: 25,
        //           )
        //         ],
        //       ),
        //     ),
        //     // Container(
        //     //   child: Column(children: [
        //     //     Text(
        //     //       "Trending.",
        //     //       style: TextStyle(
        //     //           fontSize: 20,
////    fontWeight: FontWeight.bold////      color: const Color.fromARGB(255, 66, 62, 62)
//  //
        //     //       //  ListView(
        //     //       //   scrollDirection: Axis.horizontal,
        //     //       //       children: [

        //     //       //       ],
        //     //           // )
        //     //   ]),
        //     // ),
        //   ]),
        // )
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
