import 'package:cineflix/src/common/values/enums.dart';
import 'package:cineflix/src/resources/tv_shows_api_provider.dart';

import '../models/trailer_model.dart';
import 'dart:async';
import 'movies_api_provider.dart';
import '../models/item_model.dart';

class Repository {
  final moviesApiProvider = MoviesApiProvider();
  final tvShowsApiProvider = TvShowsApiProvider();
  // final peopleApiProvider = PeopleApiProvider();

  Future<ItemModel?> fetchMovieByType(MediaCategories type, {int? movieId}) {
    switch (type) {
      case MediaCategories.popular:
        return moviesApiProvider.fetchMovieList();
      case MediaCategories.topRated:
        return moviesApiProvider.fetchTopRated();
      case MediaCategories.nowPlaying:
        return moviesApiProvider.fetchNowPlaying();
      case MediaCategories.upcoming:
        return moviesApiProvider.fetchUpcoming();
      case MediaCategories.genre:
      // return moviesApiProvider.fetchMovieFromGenre(genreId);
      default:
        throw Exception("Invalid Movie Type provided: $type");
    }
  }

  Future<ItemModel?> fetchTVShowByType(MediaCategories type, {int? movieId}) {
    switch (type) {
      case MediaCategories.popular:
        return tvShowsApiProvider.fetchPopular();
      case MediaCategories.topRated:
        return tvShowsApiProvider.fetchTopRated();
      case MediaCategories.airingToday:
        return tvShowsApiProvider.fetchAiringToday();
      case MediaCategories.onTv:
        return tvShowsApiProvider.fetchOnTv();
      default:
        throw Exception('Invalid TV Shows Type provided: $type');
    }
  }

  // Future<PeopleModel?> fetchPeopleByType(MediaCategories type, {int? movieId}) {
  //   switch (type) {
  //     case MediaCategories.popular:
  //       return peopleApiProvider.fetchPopularPeople();
  //     default:
  //       throw Exception('Invalid People Type provided : $type');
  //   }
  // }
  //  Future<ItemModel?> fetchMoreByType(MediaCategories type,{int? movieId}){
  //   switch (type){
  //     case MediaCategories.allMovies
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
