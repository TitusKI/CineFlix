import 'package:cineflix/src/ui/star_rating.dart';
import 'package:flutter/material.dart';

import '../blocs/movies_bloc.dart';
import '../blocs/movies_detail_bloc_provider.dart';
import '../models/item_model.dart';
import 'movie_detail.dart';

import 'movie_list_tile.dart';

class ItemNavigation extends StatefulWidget {
  final int buttonIndex;
  final int itemIndex;
  const ItemNavigation(
      {super.key, required this.buttonIndex, required this.itemIndex});

  @override
  // ignore: no_logic_in_create_state
  State<ItemNavigation> createState() =>
      _ItemNavigationState(buttonIndex: buttonIndex, itemIndex: itemIndex);
}

class _ItemNavigationState extends State<ItemNavigation> {
  final int buttonIndex;
  final int itemIndex;
  _ItemNavigationState({required this.buttonIndex, required this.itemIndex});
  @override
  Widget build(BuildContext context) {
    switch (buttonIndex) {
      case 1:
        switch (itemIndex) {
          case 1:
          case 2:
          case 3:
          case 4:
            bloc.fetchMoviesForIndex(itemIndex);
            break;
          default:
            bloc.fetchMoviesForIndex(2);
        }
        break;
      case 2:
        switch (itemIndex) {
          case 1:
          case 2:
          case 3:
          case 4:
            bloc.fetchTVShowsForIndex(itemIndex);
            break;
          default:
            bloc.fetchTVShowsForIndex(2);
        }
        break;
      case 3:
        switch (itemIndex) {
          case 1:
            bloc.fetchTVShowsForIndex(itemIndex);
            break;
        }
        break;
      case 4:
        switch (itemIndex) {
          case 1:
            bloc.fetchMoviesForIndex(itemIndex);
            break;
        }
        break;
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: Scaffold(
            appBar: AppBar(
              title: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.home_filled,
                            color: Colors.red,
                          )),
                      // ,SizedBox(width: 80,),
                      const Text('Popular Movies',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          )),
                      const Center(
                        child: Text('CineFlix',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            )),
                      ),
                    ]),
              ),
            ),
            body: Listener(
              onPointerDown: (event) {
                bloc.handleHidePopup();
              },
              child: Material(
                child: StreamBuilder(
                  stream: bloc.getStreamForIndex(itemIndex),
                  builder: (context, AsyncSnapshot<ItemModel?> snapshot) {
                    if (snapshot.hasData) {
                      return buildList(snapshot);
                    } else if (snapshot.connectionState ==
                            ConnectionState.none ||
                        snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return const Center(
                        child: Text('No data avaliable'),
                      );
                    }

                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            )));
  }
}

buildList(AsyncSnapshot<ItemModel?> snapshot) {
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
        height: 10,
      ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: GridView.builder(
            itemCount: snapshot.data?.results.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              final voteAverage = snapshot.data?.results[index].vote_average;
              return InkResponse(
                // // we can use GestureDetector instead of InkResponse
                onTap: () {
                  openDetailPage(context, snapshot.data, index);
                },
                child: Container(
                  height: 600,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(

                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.circular(10.0),
                          child: SizedBox(
                            height:300,
                           width: 200,
                            child: AspectRatio(
                              aspectRatio: 2/3,
                              child: Image.network(
                                
                                'https://image.tmdb.org/t/p/w185${snapshot.data?.results[index].poster_path}',
                                fit: BoxFit.cover,
                                // height: 500.0,
                                // height: 400.0,
                                // width: 200.0,
                                errorBuilder: (context, error, StackTrace) {
                                  return const Center(child: CircularProgressIndicator());
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0,),
                      Text(
                        snapshot.data?.results[index].title ?? " ",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        snapshot.data?.results[index].release_date ?? " ",
                        style: const TextStyle(fontWeight: FontWeight.w100),
                      ),
                      StarRating(voteAverage: voteAverage!),
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.favorite,
                      //       color: Colors.red,
                      //     ),
                      //     Text(snapshot.data?.results[index].vote_average.toString() ?? "_"),
                      //   ],
                      // ),
                        const SizedBox(height: 10.0,),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ],
  );
}

openDetailPage(BuildContext context, ItemModel? data, int index) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return MovieDetailBlocProvider(
      // Returning of instances of MovieDetailBlocProvider(InheritedWidget)
      // wrapping the MOvieDetail screen to it.
      // So MovieDetailBloc class will be accessible inside the detail
      // screen and to all the widgets since
      // It is in the Initializer list of the MovieDetailBlocProvider instances
      key: GlobalKey(),
      child: MovieDetail(
        title: data?.results[index].title,
        posterUrl: data?.results[index].poster_path,
        description: data?.results[index].overview,
        releaseDate: data?.results[index].release_date,
        voteAverage: data?.results[index].vote_average,
        movieId: data!.results[index].id,
      ),
    );
  }));
}

Widget buildMovieListTile(String title, List<String> popupContent, int index) {
  MovieListTile movieListTile = MovieListTile(
    txt1: popupContent.isNotEmpty ? popupContent[0] : '',
    txt2: popupContent.length > 1 ? popupContent[1] : '',
    txt3: popupContent.length > 2 ? popupContent[2] : '',
    txt4: popupContent.length > 3 ? popupContent[3] : '',
    index: index,
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
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
  // popupContentMap[movieListTile] = popupContent;
  return movieListTile;
}
