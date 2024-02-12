import '../models/trailer_model.dart';
import 'dart:async';
import 'movies_api_provider.dart';
import '../models/item_model.dart';

class Repository {
  final moviesApiProvider = MoviesApiProvider();
  Future<ItemModel?> fetchAllMovies() {
    return moviesApiProvider.fetchMovieList();
  }

  Future<TrailerModel?> fetchTrailers(int movieId) {
    return moviesApiProvider.fetchTrailer(movieId);
  }
}
