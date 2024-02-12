import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class MoviesBloc {
  final _repository = Repository(); // Responsible for fetching movies
  final _moviesFetcher = PublishSubject<ItemModel>();
  // in Dart StreamController = PublishSubject/Subject in Rxdart
// PublishSubject is a type of subject that,
// when a new subscriber joins, emits the most recent item to that subscriber.
// It then continues to emit any new items that are added to the stream.
  Stream<ItemModel> get allMovies => _moviesFetcher.stream;
  // Subscribers or Consumers can listen to this stream to get updates on movie data.

  fetchAllMovies() async {
    // It fetches all movies from the repository then waits
    // and adds the itemModel to the movieFetcher Stream using sink
    ItemModel? itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(itemModel!);
  }

  dispose() {
    // for Closing the _moviesFetcher stream when the moviesBloc is no longer needed
    // it avoids memory leak
    _moviesFetcher.close();
  }
}

// Creating a Global instance of the MoviesBloc
// for managing the state that related to movies
final bloc = MoviesBloc();
