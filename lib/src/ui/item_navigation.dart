import 'package:cineflix/src/blocs/movies_detail_bloc_provider.dart';
import 'package:cineflix/src/common/values/colors.dart';
import 'package:cineflix/src/models/people_model.dart';
import 'package:cineflix/src/ui/movie_detail.dart';

import 'package:cineflix/src/ui/widgets/movie_show_list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../blocs/movies_bloc.dart';
import '../models/item_model.dart';

class ItemNavigation extends StatefulWidget {
  final int? buttonIndex;
  final int? itemIndex;
  final String? genreId;
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
          bloc.fetchMoviesForIndex(widget.itemIndex!);
          break;
        case 2:
          bloc.fetchTVShowsForIndex(widget.itemIndex!);
          break;
      }
    } else {
      bloc.fetchMoviesForIndex(5, genreId: widget.genreId!);
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
                        color: AppColors.primaryElement,
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
                          color: AppColors.primaryElement,
                        )),
                  ),
                ]),
          ),
        ),
        body: Material(
          color: AppColors.primaryBackground,
          child: StreamBuilder(
            stream: bloc.getStreamForIndex(widget.itemIndex ?? 5),
            builder: (context, AsyncSnapshot<ItemModel?> snapshot) {
              if (snapshot.hasData) {
                return MovieShowListBuilder(
                  snapshot: snapshot,
                  mediaType: widget.buttonIndex ?? 1,
                );
                // return buildList(snapshot);
              } else if (snapshot.connectionState == ConnectionState.none ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitThreeBounce(
                    color: AppColors.primaryText,
                    size: 20.0,
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return const Center(
                  child: Text('No data avaliable!'),
                );
              }

              return const Center(
                  child: SpinKitThreeBounce(
                color: AppColors.primaryText,
                size: 20.0,
              ));
            },
          ),
        ),
      ),
    );
  }
}

openDetailPage(
    BuildContext context, ItemModel? data, List<Person> cast, int index) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    print("The MovieData : ");
    print(data);

    return MovieDetailBlocProvider(
      // Returning of instances of MovieDetailBlocProvider(InheritedWidget)
      // wrapping the MOvieDetail screen to it.
      // So MovieDetailBloc class will be accessible inside the detail
      // screen and to all the widgets since
      // It is in the Initializer list of the MovieDetailBlocProvider instances
      key: GlobalKey(),
      child: MovieDetail(
        itemModel: data,
        itemIndex: index,
        title: data?.results[index].title,
        posterUrl: data?.results[index].posterPath,
        description: data?.results[index].overview,
        releaseDate: data?.results[index].releaseDate,
        voteAverage: data?.results[index].voteAverage,
        movieId: data!.results[index].id,
        cast: cast,
      ),
    );
  }));
}
