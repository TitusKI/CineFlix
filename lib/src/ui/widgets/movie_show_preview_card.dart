import 'package:cineflix/src/common/values/colors.dart';
import 'package:cineflix/src/models/item_model.dart';
import 'package:cineflix/src/ui/widgets/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MovieShowPreviewCard extends StatelessWidget {
  final ItemModel? itemModel;
  final int index;
  final double? voteAverage;
  const MovieShowPreviewCard(
      {super.key, this.itemModel, required this.index, this.voteAverage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 120,
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150,
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${itemModel?.results[index].poster_path}',
                fit: BoxFit.cover,
                errorBuilder: (context, error, StackTrace) {
                  return const Center(
                      child: SpinKitThreeBounce(
                    color: AppColors.primaryText,
                    size: 20.0,
                  ));
                },
              ),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              maxLines: 2,
              softWrap: true,
              itemModel?.results[index].title ?? " ",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          StarRating(
            voteAverage: voteAverage!,
            iconSize: 12,
          ),
        ],
      ),
    );
  }
}
