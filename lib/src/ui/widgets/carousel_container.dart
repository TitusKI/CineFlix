import 'package:cineflix/src/ui/widgets/movie-show_carousell.dart';
import 'package:flutter/widgets.dart';

class CarouselContainer extends StatelessWidget {
  final List<MovieShowCarousel> carouselList;

  const CarouselContainer({
    super.key,
    required this.carouselList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [...carouselList],
    );
  }
}
