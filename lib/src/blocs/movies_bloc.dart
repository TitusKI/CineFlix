import 'package:cineflix/src/common/values/enums.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class MoviesBloc {
  final _repository = Repository(); // Responsible for fetching movies
  final _moviesFetcher = PublishSubject<ItemModel>();
  final _topRatedFetcher = PublishSubject<ItemModel?>();
  final _hideHandler = BehaviorSubject<bool>();
  final _showHandler = BehaviorSubject<bool>();
  final _selectedTileIndex = BehaviorSubject<int>();
  final _popupContent = BehaviorSubject<List<String>>();

  // in Dart StreamController = PublishSubject/Subject in Rxdart
// PublishSubject is a type of subject that,
// when a new subscriber joins, emits the most recent item to that subscriber.
// It then continues to emit any new items that are added to the stream.
  Stream<bool> get showPopupStream => _showHandler.stream;
  Sink<bool> get showPopupSink => _showHandler.sink;
  Stream<bool> get hidePopupStream => _hideHandler.stream;
  Sink<bool> get hidePopupSink => _hideHandler.sink;
  Stream<int> get selectedTileIndexStream => _selectedTileIndex.stream;
  Sink<int> get selectedTileIndexSink => _selectedTileIndex.sink;
  Stream<List<String>> get popupContentStream => _popupContent.stream;

  Stream<ItemModel> get allMovies => _moviesFetcher.stream;
  Stream<ItemModel?> get topRatedMovies => _topRatedFetcher.stream;
// Subscribers or Consumers can listen to this stream to get updates on movie data

  final _popupContentMap = <int, BehaviorSubject<List<String>>>{};

  MoviesBloc() {
    for (int i = 1; i <= 4; i++) {
      _popupContentMap[i] = BehaviorSubject<List<String>>.seeded([]);
    }
  }

  final Map<int, PublishSubject<ItemModel>> _streamMap = {
    1: PublishSubject<ItemModel>(),
    2: PublishSubject<ItemModel>(),
    3: PublishSubject<ItemModel>(),
    4: PublishSubject<ItemModel>(),
    5: PublishSubject<ItemModel>(),
  };
  Stream<ItemModel> getStreamForIndex(int index) {
    return _streamMap[index]!;
  }

  ItemModel? itemModel;
  void fetchMoviesForIndex(int index, {String? genreId}) async {
    switch (index) {
      case 1:
        itemModel = await _repository.fetchMovieByType(MediaCategories.popular);
        _streamMap[index]!.add(itemModel!);

        break;
      case 2:
        itemModel =
            await _repository.fetchMovieByType(MediaCategories.topRated);
        _streamMap[index]!.add(itemModel!);

        break;
      case 3:
        itemModel =
            await _repository.fetchMovieByType(MediaCategories.nowPlaying);
        _streamMap[index]!.add(itemModel!);

        break;
      case 4:
        itemModel =
            await _repository.fetchMovieByType(MediaCategories.upcoming);
        _streamMap[index]!.add(itemModel!);

        break;
      case 5:
        itemModel = await _repository.fetchMovieByType(MediaCategories.genre,
            movieId: genreId);
        _streamMap[5]!.add(itemModel!);
        break;
    }
  }

  void fetchTVShowsForIndex(int index) async {
    switch (index) {
      case 1:
        itemModel =
            await _repository.fetchTVShowByType(MediaCategories.popular);
        break;
      case 2:
        itemModel =
            await _repository.fetchTVShowByType(MediaCategories.topRated);
        break;
      case 3:
        itemModel =
            await _repository.fetchTVShowByType(MediaCategories.airingToday);
        break;
      case 4:
        itemModel = await _repository.fetchTVShowByType(MediaCategories.onTv);
        break;
    }
    _streamMap[index]!.add(itemModel!);
  }

  dispose() {
    // for Closing the _moviesFetcher stream when the moviesBloc is no longer needed
    // it avoids memory leak
    _moviesFetcher.close();
    _topRatedFetcher.close();
    _hideHandler.close();
    _showHandler.close();
    _selectedTileIndex.close();
    _popupContentMap.forEach((key, value) {
      value.close();
    });

    _popupContent.close();
  }
}

// Creating a Global instance of the MoviesBloc
// for managing the state that related to movies
final bloc = MoviesBloc();
