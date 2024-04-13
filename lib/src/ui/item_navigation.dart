import 'package:cineflix/src/common/values/colors.dart';
import 'package:cineflix/src/models/people_model.dart';
import 'package:cineflix/src/resources/people_api_provider.dart';
import 'package:cineflix/src/ui/star_rating.dart';
import 'package:cineflix/src/ui/widgets/movie_tile.dart';
import 'package:flutter/material.dart';

import '../blocs/movies_bloc.dart';
import '../blocs/movies_detail_bloc_provider.dart';
import '../models/item_model.dart';
import 'movie_detail.dart';

import 'movie_list_tile.dart';

class ItemNavigation extends StatefulWidget {
  final int? buttonIndex;
  final int? itemIndex;
  final int? genreId;
  final String pageTitle;
  const ItemNavigation(
      {super.key,
      this.buttonIndex,
      this.itemIndex,
      this.genreId,
      required this.pageTitle});

  @override
  // ignore: no_logic_in_create_state
  State<ItemNavigation> createState() => _ItemNavigationState();
}

class _ItemNavigationState extends State<ItemNavigation> {
  @override
  Widget build(BuildContext context) {
    if (widget.genreId == null) {
      switch (widget.buttonIndex) {
        case 1:
          switch (widget.itemIndex) {
            case 1:
            case 2:
            case 3:
            case 4:
              bloc.fetchMoviesForIndex(widget.itemIndex!);
              break;
            default:
              bloc.fetchMoviesForIndex(2);
          }

          break;
        case 2:
          switch (widget.itemIndex) {
            case 1:
            case 2:
            case 3:
            case 4:
              bloc.fetchTVShowsForIndex(widget.itemIndex!);
              break;
            default:
              bloc.fetchTVShowsForIndex(2);
          }
          break;
        case 3:
          switch (widget.itemIndex) {
            case 1:
              bloc.fetchTVShowsForIndex(widget.itemIndex!);
              break;
          }
          break;
        case 4:
          switch (widget.itemIndex) {
            case 1:
              bloc.fetchMoviesForIndex(widget.itemIndex!);
              break;
          }
          break;
      }
    } else {}

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
                  Text(widget.pageTitle,
                      style: const TextStyle(
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
            color: AppColors.primaryBackground,
            child: StreamBuilder(
              stream: bloc.getStreamForIndex(widget.itemIndex!),
              builder: (context, AsyncSnapshot<ItemModel?> snapshot) {
                if (snapshot.hasData) {
                  return buildList(snapshot);
                } else if (snapshot.connectionState == ConnectionState.none ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return const Center(
                    child: Text('No data avaliable'),
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}

buildList(AsyncSnapshot<ItemModel?> snapshot) {
  PeopleApiProvider pplApi = PeopleApiProvider();
  late List<Person> cast;
  return Column(
    children: [
      SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GridView.builder(
            itemCount: snapshot.data?.results.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 5 / 8,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              final voteAverage = snapshot.data?.results[index].vote_average;
              return GestureDetector(
                  // // we can use GestureDetector instead of InkResponse
                  onTap: () async {
                    cast = await pplApi
                        .fetchPeople(snapshot.data!.results[index].id);
                    openDetailPage(
                      context,
                      snapshot.data,
                      cast,
                      index,
                    );
                  },
                  child: MovieTile(
                    itemModel: snapshot.data,
                    index: index,
                    voteAverage: voteAverage,
                  ));
            },
          ),
        ),
      ),
    ],
  );
}

openDetailPage(
    BuildContext context, ItemModel? data, List<Person> cast, int index) {
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
        cast: cast,
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
