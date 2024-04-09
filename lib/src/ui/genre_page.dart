import 'package:cineflix/src/models/genre_model.dart';
import 'package:cineflix/src/resources/genre_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GenrePage extends StatefulWidget {
  const GenrePage({super.key});

  @override
  State<GenrePage> createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {
  late Future<List<Genre>> _genresFuture;
  final GenreApiProvider _genreApiProvider = GenreApiProvider();

  @override
  void initState() {
    super.initState();
    _genresFuture = _genreApiProvider.fetchGenres();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    double cardHeight = deviceSize.height * 0.3;
    double cardWidth = deviceSize.width;
    return FutureBuilder<List<Genre>>(
      future: _genresFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Genre> genres = snapshot.data!;
          return ListView.builder(
            itemCount: genres.length,
            itemBuilder: (context, index) {
              Genre genre = genres[index];
              return SizedBox(
                height: cardHeight,
                width: cardWidth,
                key: Key(genre.id.toString()),
                child: Stack(children: [
                  Image.asset(
                    'assets/images/img.jpg',
                    width: cardWidth,
                    height: cardHeight,
                    fit: BoxFit.fill,
                  ),
                  Center(
                      child: Text(
                    genre.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      // color: Colors.white.withOpacity(0.8)
                    ),
                  ))
                ]),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
