import 'package:cineflix/src/models/item_model.dart';
import 'package:cineflix/src/ui/widgets/star_rating.dart';
import 'package:flutter/material.dart';

class MovieTile extends StatelessWidget {
  final ItemModel? itemModel;
  final int index;
  final double? voteAverage;
  const MovieTile(
      {super.key,
      this.itemModel,
      required this.index,
      required this.voteAverage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      color: const Color.fromARGB(161, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(10.0),
              child: AspectRatio(
                aspectRatio: 3 / 2,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w185${itemModel?.results[index].poster_path}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, StackTrace) {
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            itemModel?.results[index].title ?? " ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            itemModel?.results[index].release_date ?? " ",
            style: const TextStyle(fontWeight: FontWeight.w200),
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
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
