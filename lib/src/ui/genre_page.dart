import 'package:cineflix/src/models/genre_model.dart';
import 'package:cineflix/src/resources/genre_api_provider.dart';
import 'package:cineflix/src/ui/widgets/genre_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    return FutureBuilder<List<Genre>>(
      future: _genresFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Genre> genres = snapshot.data!;
          return ListView.builder(
            itemCount: genres.length,
            itemBuilder: (context, index) {
              Genre genre = genres[index];
              return GenreCard(
                genreId: genre.id.toString(),
                genreName: genre.name,
                onPressed: () {},
              );
            },
          );
        } else if (snapshot.hasError) {
          return const Center(
              child: Text(
            "Could not fetch genres",
            style: TextStyle(fontSize: 28),
          ));
        }
        return const Center(
            child: SpinKitCubeGrid(
          color: Colors.white,
          size: 60.0,
        ));
      },
    );
  }
}
