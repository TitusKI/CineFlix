import 'package:cineflix/src/models/genre_model.dart';
import 'package:cineflix/src/resources/genre_api_provider.dart';
import 'package:flutter/material.dart';

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
    return Container(
      child: FutureBuilder<List<Genre>>(
        future: _genresFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Genre> genres = snapshot.data!;
            return ListView.builder(
              itemCount: genres.length,
              itemBuilder: (context, index) {
                Genre genre = genres[index];
                return ListTile(
                  title: Text(genre.name),
                  subtitle: Text('ID: ${genre.id.toString()}'),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
