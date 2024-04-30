import 'dart:async';

import 'package:cineflix/src/blocs/movies_detail_bloc_provider.dart';
import 'package:cineflix/src/models/item_model.dart';
import 'package:cineflix/src/models/people_model.dart';
import 'package:cineflix/src/resources/people_api_provider.dart';
import 'package:cineflix/src/ui/movie_detail.dart';
import 'package:cineflix/src/ui/widgets/movie_show_preview_card.dart';
import 'package:cineflix/src/ui/widgets/movie_tile.dart';
import 'package:flutter/material.dart';

class MovieShowCarousel extends StatelessWidget {
  final AsyncSnapshot<ItemModel?> snapshot;
  final int mediaType;

  const MovieShowCarousel(
      {super.key, required this.snapshot, required this.mediaType});

  // }
  @override
  Widget build(BuildContext context) {
    PeopleApiProvider pplApi = PeopleApiProvider();
    late List<Person> cast;
    return Expanded(
      child: ListView.builder(
        // controller: scrollController,
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final voteAverage = snapshot.data?.results[index].vote_average;
          return GestureDetector(
              // // we can use GestureDetector instead of InkResponse
              onTap: () async {
                cast = await pplApi.fetchPeople(
                    snapshot.data!.results[index].id, mediaType);
                openDetailPage(
                  context,
                  snapshot.data,
                  cast,
                  index,
                );
              },
              child: MovieShowPreviewCard(
                itemModel: snapshot.data,
                index: index,
                voteAverage: voteAverage,
              ));
        },
      ),
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
          itemIndex: index,
          title: data?.results[index].title,
          posterUrl: data?.results[index].poster_path,
          description: data?.results[index].overview,
          releaseDate: data?.results[index].release_date,
          voteAverage: data?.results[index].vote_average,
          movieId: data!.results[index].id,
          cast: cast,
          itemModel: data,
        ));
  }));
}


// int scrolledToTileIndex = 0;
  // ScrollController scrollController = ScrollController();

  // Timer? timer;

  // @override
  // void initState() {
  //   super.initState();

  //   // Start auto-scrolling after 1 second
  //   timer = Timer.periodic(const Duration(seconds: 10), (timer) {
  //     if (scrolledToTileIndex < 20) {
  //       scrolledToTileIndex++;
  //       scrollController.animateTo(
  //         scrolledToTileIndex * 130,
  //         duration: const Duration(milliseconds: 500),
  //         curve: Curves.easeInOut,
  //       );
  //     }
  //   });
  // }

  // @override
  // void dispose() {
  //   // Cancel the timer and dispose the scroll controller to avoid memory leaks
  //   timer?.cancel();
  //   scrollController.dispose();
  //   super.dispose();