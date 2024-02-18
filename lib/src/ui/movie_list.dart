import 'dart:io';
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
    bloc.fetchAllMovies();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies();
    return StreamBuilder(
      stream: bloc.allMovies,
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

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  buildList(AsyncSnapshot<ItemModel?> snapshot) {
    return Column(
      children: [
        Container(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              MovieListTile(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                  child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                      ),
                      child: Center(
                          child: Text(
                        'Movies',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ))),
                ),
                txt1: 'Popular Movies',
                txt2: 'Top Rated Movies',
                txt3: "Upcoming Movies",
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
                child: Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Center(
                        child: Text(
                      'TV Shows',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ))),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
                child: Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Center(
                        child: Text(
                      'People',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ))),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
                child: Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Center(
                        child: Text(
                      'More',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ))),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: GridView.builder(
            itemCount: snapshot.data?.results.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return InkResponse(
                // we can use GestureDetector instead of InkResponse
                onTap: () {
                  openDetailPage(snapshot.data, index);
                },
                child: Image.network(
                  'https://image.tmdb.org/t/p/w185${snapshot.data?.results[index].poster_path}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, StackTrace) {
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  openDetailPage(ItemModel? data, int index) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MovieDetailBlocProvider(
        // Returning of instances of MovieDetailBlocProvider(InheritedWidget)
        // wrapping the MOvieDetail screen to it.
        // So MovieDetailBloc class will be accessible inside the detail
        // screen and to all the widgets since
        // It is in the Initializer list of the MovieDetailBlocProvider instances
        key: GlobalKey(),
        child: MovieDetail(
          title: data!.results[index].title,
          posterUrl: data!.results[index].poster_path,
          description: data!.results[index].overview,
          releaseDate: data!.results[index].release_date,
          voteAverage: data!.results[index].vote_average.toString(),
          movieId: data!.results[index].id,
        ),
      );
    }));
  }
}
