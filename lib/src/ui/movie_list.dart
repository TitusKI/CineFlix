import 'movie_list_tile.dart';
import '../blocs/movies_detail_bloc_provider.dart';
import 'movie_detail.dart';
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
    bloc.fetchMoviesForIndex(1);
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // bloc.fetchAllMovies();
    bloc.fetchMoviesForIndex(1);
    return StreamBuilder(
      stream: bloc.getStreamForIndex(1),
      builder: (context, AsyncSnapshot<ItemModel?> snapshot) {
        if (snapshot.hasData) {
          return buildList(snapshot);
        } else if (snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Center(
            child: Text('No data avaliable'),
          );
        }

        return const Center(child: Text('ERRor'));
      },
    );
  }

  // Map<MovieListTile, List<String>> popupContentMap = {};
  buildList(AsyncSnapshot<ItemModel?> snapshot) {
    return Column(
      children: [
        Container(
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
        SizedBox(
          height: 20,
        ),
        Container(
          color: Color.fromARGB(3, 39, 9, 191),
          child: ListView(shrinkWrap: true, children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/cineflix.jpg'),
                      fit: BoxFit.cover)),
              child: Column(
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 20),
                            hintText: 'Search for a movie, tv show.....',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.filter),
                              onPressed: (){},
                              )
                          ),
                        onChanged: (_){},
                        ),
                     
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  )
                ],
              ),
            ),
            Container(
              child: Column(children: [
                Text(
                  "Trending.",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 66, 62, 62)),
                   
                ),
                  //  ListView(
                  //   scrollDirection: Axis.horizontal,
                  //       children: [
                         
                  //       ],
                      // )
              ]),
            ),
          ]),
        )
      ],
    );
  }

  Widget buildMovieListTile(
      String title, List<String> popupContent, int index) {
    MovieListTile movieListTile = MovieListTile(
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
        child: Container(
          height: 25,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.red,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
      ),
      txt1: popupContent.length > 0 ? popupContent[0] : '',
      txt2: popupContent.length > 1 ? popupContent[1] : '',
      txt3: popupContent.length > 2 ? popupContent[2] : '',
      txt4: popupContent.length > 3 ? popupContent[3] : '',
      index: index,
    );
    // popupContentMap[movieListTile] = popupContent;
    return movieListTile;
  }
}
