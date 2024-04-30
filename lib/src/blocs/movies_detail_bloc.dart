import 'package:cineflix/src/models/item_model.dart';
import 'package:rxdart/rxdart.dart';
import '../models/trailer_model.dart';
import '../resources/repository.dart';

class MovieDetailBloc {
  final _repository = Repository();

  final _movieId = PublishSubject<int>(); // No initial value
  // publishSubject: Subscribers that subscribe later will
  // only receive events that are emitted after their subscription.
  final _trailers = BehaviorSubject<Future<TrailerModel?>>();
  // final _moviesModel = BehaviorSubject<Future<ItemModel?>>();// initial value
  // BehaviorSubject:  emits the most recent event to new subscribers,
  // even if they subscribe after the event has been emitted

  Function(int) get fetchTrailerById => _movieId.sink.add;
  Stream<Future<TrailerModel?>> get movieTrailers => _trailers.stream;
  MovieDetailBloc() {
    _movieId.stream.transform(_itemTransformer()).pipe(_trailers);

    // Chaining of two or more Subjects and get the  final result,
    // eg input data as an id from the 1st subjects
    // and will pipe it into the second Subjects
  }
  dispose() async {
    _movieId.close();
    await _trailers.drain();
    _trailers.close();
  }

  _itemTransformer() {
    return ScanStreamTransformer(
      (
        Future<TrailerModel?> trailer,
        int id,
        int index,
      ) {
        trailer = _repository.fetchTrailers(id);
        return trailer;
      },
      Future<TrailerModel?>.value(null),
    );
  }
}
