import 'dart:ui';

import 'package:flutter/material.dart';

class GenreCard extends StatelessWidget {
  final String genreId;
  final String genreName;
  final VoidCallback onPressed;
  const GenreCard(
      {super.key,
      required this.genreId,
      required this.genreName,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    double cardHeight = deviceSize.height * 0.3;
    double cardWidth = deviceSize.width;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      height: cardHeight,
      width: cardWidth,
      key: Key(genreId),
      child: GestureDetector(
        onTap: () {},
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
                child: Image.asset(
                  'assets/images/img.jpg',
                  width: cardWidth,
                  height: cardHeight,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Center(
              child: Text(
            genreName,
            style: TextStyle(
              fontSize: 28,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w900,
              // color: Colors.white.withOpacity(0.8)
            ),
          ))
        ]),
      ),
    );
  }
}
