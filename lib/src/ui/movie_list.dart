import 'package:cineflix/src/blocs/search/search_bloc.dart';
import 'package:cineflix/src/blocs/search/search_state.dart';
import 'package:cineflix/src/ui/search_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_list_tile.dart';
import '../models/item_model.dart';
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
                        builder: (context) => SearchScreen()));
                  },
                  icon: const Icon(
                    Icons.search,
                    weight: 50.0,
                  ),
                );
              })
            ],
          ),
          body: Listener(
            onPointerDown: (event) {
              bloc.handleHidePopup();
            },
            child: buildList(),
          ),
        );
      },
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
          color: const Color.fromARGB(3, 39, 9, 191),
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
                  ),
                  Text(
                    "Millions of movies, TV shows and people to discover. Explore now.",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  //   Stack(
                  //     children: [ClipRRect(
                  //       borderRadius: BorderRadius.circular(25.0),
                  //       child: Container(
                  //         padding:
                  //             EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //         ),
                  //         // child: SearchScreen()

                  //       ),
                  //     ),
                  // ]),
                  SizedBox(
                    height: 25,
                  )
                ],
              ),
            ),
            // Container(
            //   child: Column(children: [
            //     Text(
            //       "Trending.",
            //       style: TextStyle(
            //           fontSize: 20,
            //           fontWeight: FontWeight.bold,
            //           color: const Color.fromARGB(255, 66, 62, 62)),

            //     ),
            //       //  ListView(
            //       //   scrollDirection: Axis.horizontal,
            //       //       children: [

            //       //       ],
            //           // )
            //   ]),
            // ),
          ]),
        )
      ],
    );
  }

  Widget buildMovieListTile(
      String title, List<String> popupContent, int index) {
    MovieListTile movieListTile = MovieListTile(
      // ignore: sort_child_properties_last
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(25.0),
        ),
        child: Container(
          height: 25,
          width: 50,
          decoration: const BoxDecoration(
            color: Colors.red,
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
      ),
      txt1: popupContent.isNotEmpty ? popupContent[0] : '',
      txt2: popupContent.length > 1 ? popupContent[1] : '',
      txt3: popupContent.length > 2 ? popupContent[2] : '',
      txt4: popupContent.length > 3 ? popupContent[3] : '',
      index: index,
    );
    // popupContentMap[movieListTile] = popupContent;
    return movieListTile;
  }
}
