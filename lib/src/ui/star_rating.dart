import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double voteAverage;
  const StarRating({super.key, required this.voteAverage});

  @override
  Widget build(BuildContext context) {
    int numberOfStars = (voteAverage / 2).round();
    return Row(
      children: List.generate(5, (index) {
        if (index < numberOfStars) {
          return Icon(
            Icons.star,
            color: Colors.amber,
          );
        } else {
          return Icon(
            Icons.star_border,
            color: Colors.amber,
          );
        }
      }),
    );
  }
}
