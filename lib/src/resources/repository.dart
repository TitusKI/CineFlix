import 'package:cineflix/src/resources/tv_shows_api_provider.dart';

import '../models/trailer_model.dart';
import 'dart:async';
import 'movies_api_provider.dart';
import '../models/item_model.dart';

enum Types {
  popular,
  topRated,
  nowPlaying,
  upcoming,
  airingToday,
  onTv,
  genre,

  trailers,
}

class Repository {
  final moviesApiProvider = MoviesApiProvider();
  final tvShowsApiProvider = TvShowsApiProvider();
  // final peopleApiProvider = PeopleApiProvider();

  Future<ItemModel?> fetchMovieByType(Types type, {int? movieId}) {
    switch (type) {
      case Types.popular:
        return moviesApiProvider.fetchMovieList();
      case Types.topRated:
        return moviesApiProvider.fetchTopRated();
      case Types.nowPlaying:
        return moviesApiProvider.fetchNowPlaying();
      case Types.upcoming:
        return moviesApiProvider.fetchUpcoming();
      default:
        throw Exception("Invalid Movie Type provided: $type");
    }
  }

  Future<ItemModel?> fetchTVShowByType(Types type, {int? movieId}) {
    switch (type) {
      case Types.popular:
        return tvShowsApiProvider.fetchPopular();
      case Types.topRated:
        return tvShowsApiProvider.fetchTopRated();
      case Types.airingToday:
        return tvShowsApiProvider.fetchAiringToday();
      case Types.onTv:
        return tvShowsApiProvider.fetchOnTv();
      default:
        throw Exception('Invalid TV Shows Type provided: $type');
    }
  }

  // Future<PeopleModel?> fetchPeopleByType(Types type, {int? movieId}) {
  //   switch (type) {
  //     case Types.popular:
  //       return peopleApiProvider.fetchPopularPeople();
  //     default:
  //       throw Exception('Invalid People Type provided : $type');
  //   }
  // }
  //  Future<ItemModel?> fetchMoreByType(Types type,{int? movieId}){
  //   switch (type){
  //     case Types.allMovies
  //   }

  // Future<ItemModel?> fetchAllMovies() {
  //   return moviesApiProvider.fetchMovieList();
  // }
  // Future<ItemModel?> fetchTopRatedMovies(){
  //   return moviesApiProvider.fetchTopRated();
  // }

  Future<TrailerModel?> fetchTrailers(int movieId) {
    return moviesApiProvider.fetchTrailer(movieId);
  }
  // Future<ItemModel?> fetchNowPlaying(){
  //   return moviesApiProvider.fetchNowPlaying();
  // }
  // Future<ItemModel?> fetchUpcoming(){
  //   return moviesApiProvider.fetchUpcoming();
  // }
}
