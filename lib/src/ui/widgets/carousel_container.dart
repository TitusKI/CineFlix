import 'package:cineflix/src/ui/widgets/movie_show_home_card.dart';
import 'package:flutter/widgets.dart';

class CarouselContainer extends StatelessWidget {
  final List<MovieShowHomeCard> carouselList;

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
