import 'package:cineflix/src/blocs/movies_detail_bloc_provider.dart';
import 'package:cineflix/src/models/item_model.dart';
import 'package:cineflix/src/models/people_model.dart';
import 'package:cineflix/src/resources/people_api_provider.dart';
import 'package:cineflix/src/ui/movie_detail.dart';
import 'package:cineflix/src/ui/widgets/movie_tile.dart';
import 'package:flutter/material.dart';

class MovieShowListBuilder extends StatefulWidget {
  final AsyncSnapshot<ItemModel?> snapshot;
  const MovieShowListBuilder({super.key, required this.snapshot});

  @override
  State<MovieShowListBuilder> createState() => _MovieShowListBuilderState();
}

class _MovieShowListBuilderState extends State<MovieShowListBuilder> {
  PeopleApiProvider pplApi = PeopleApiProvider();
  late List<Person> cast;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GridView.builder(
              itemCount: widget.snapshot.data?.results.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 5 / 8,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                final voteAverage =
                    widget.snapshot.data?.results[index].vote_average;
                return GestureDetector(
                    // // we can use GestureDetector instead of InkResponse
                    onTap: () async {
                      cast = await pplApi
                          .fetchPeople(widget.snapshot.data!.results[index].id);
                      openDetailPage(
                        context,
                        widget.snapshot.data,
                        cast,
                        index,
                      );
                    },
                    child: MovieTile(
                      itemModel: widget.snapshot.data,
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
