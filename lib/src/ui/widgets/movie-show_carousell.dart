import 'package:cineflix/src/ui/item_navigation.dart';
import 'package:flutter/material.dart';

class MovieShowCarousel extends StatelessWidget {
  final int categoryId;
  final int mediaId;
  final String title;
  const MovieShowCarousel(
      {super.key,
      required this.categoryId,
      required this.title,
      required this.mediaId});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 250,
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
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
          Expanded(
              child: Container(
            color: Colors.green,
          ))
        ],
      ),
    );
  }
}
