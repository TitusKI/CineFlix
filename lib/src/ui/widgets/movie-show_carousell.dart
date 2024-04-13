import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MovieShowCarousel extends StatelessWidget {
  const MovieShowCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 250,
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: GestureDetector(
              onTap: () {
                // Add your onTap function here
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Latest Movies',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios),
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
