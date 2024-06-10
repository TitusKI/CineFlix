import 'package:cineflix/src/blocs/movies_bloc.dart';
import 'package:cineflix/src/common/values/colors.dart';
import 'package:cineflix/src/models/item_model.dart';
import 'package:cineflix/src/ui/item_navigation.dart';
import 'package:cineflix/src/ui/widgets/movie_show_carousell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';

class MovieShowHomeCard extends StatelessWidget {
  final int categoryId;
  final int mediaId;
  final String title; // final string title
  const MovieShowHomeCard(
      {super.key,
      required this.categoryId,
      required this.title,
      required this.mediaId});

  @override
  Widget build(BuildContext context) {
    switch (mediaId) {
      case 1:
        bloc.fetchMoviesForIndex(categoryId);
        break;
      case 2:
        bloc.fetchTVShowsForIndex(categoryId);
        break;
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 260,
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ItemNavigation(
                          pageTitle: title,
                          buttonIndex: mediaId,
                          itemIndex: categoryId,
                        )));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
          StreamBuilder(
            stream: bloc.getStreamForIndex(categoryId),
            builder: (context, AsyncSnapshot<ItemModel?> snapshot) {
              if (snapshot.hasData) {
                return MovieShowCarousel(
                  snapshot: snapshot,
                  mediaType: mediaId,
                );
              } else if (snapshot.connectionState == ConnectionState.none ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitThreeBounce(
                    color: AppColors.primaryText,
                    size: 20.0,
                  ),
                );
              } else {
                final itemBox = Hive.box<ItemModel>('itemBox');
                final cachedItems;
                mediaId == 1
                    ? cachedItems = itemBox.get('cachedMovies')
                    : cachedItems = itemBox.get('cachedTvshows');
                if (cachedItems != null) {
                  return MovieShowCarousel(
                      snapshot: cachedItems as AsyncSnapshot<ItemModel?>,
                      mediaType: mediaId);
                } else {
                  return const Center(
                    child: Text('No item found'),
                  );
                }
              }

              // return const Center(
              //     child: SpinKitThreeBounce(
              //   color: AppColors.primaryText,
              //   size: 20.0,
              // ));
            },
          )
        ],
      ),
    );
  }
}
