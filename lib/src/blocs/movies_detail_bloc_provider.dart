import 'package:flutter/material.dart';

import 'movies_detail_bloc.dart';
export 'movies_detail_bloc.dart'; 
// Export keyword here is if another class imports movieo_detail_bloc.dart ,
// they will also have an access to MOvieDetailBlocProvider

class MovieDetailBlocProvider extends InheritedWidget {
  final MovieDetailBloc bloc;

  MovieDetailBlocProvider({required Key key, required Widget child})
      : bloc = MovieDetailBloc(),
        // Initalizer List: Used to initialized the fields of the class before
        // the constructor body is executed.
        // since some transforms (eg _movieId.stream.transform(_itemTransformer()).pipe(_trailers);)
        // should be executed before wraped by MoviesDetailBlocProvider
        super(key: key, child: child);

  @override
  // updateShouldNotify method for determining whether the widget depend on this InheritedWidget
  // and need to rebuild when inheritedWidget's State changes
  bool updateShouldNotify(_) {
    return true;
  }

// Being a static method mean that you can call it on the class itself rather than the instance of the class .
  // It really doesn't require creating an instance of the MovieDetailBlocProvider to use this method
  // Static method can't be called on the instance of the class
  static MovieDetailBloc? of(BuildContext context) {
    final MovieDetailBlocProvider? provider =
        context.dependOnInheritedWidgetOfExactType<MovieDetailBlocProvider>();
    if (provider == null) {
      // Handle the case when MovieDetailBlocProvider is not found.
      // This could be a sign that the widget tree structure is not as expected.
      // You might want to return a default MovieDetailBloc or throw an exception.
      return MovieDetailBloc(); // or throw Exception('MovieDetailBlocProvider not found');
    }
    return provider.bloc;
  }
}
