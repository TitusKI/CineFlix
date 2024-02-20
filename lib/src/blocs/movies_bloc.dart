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

  // Subscribers or Consumers can listen to this stream to get updates on movie data.

  fetchAllMovies() async {
    // It fetches all movies from the repository then waits
    // and adds the itemModel to the movieFetcher Stream using sink
    ItemModel? itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(itemModel!);
  }

  fetchRatedMovies() async {
    ItemModel? itemModel = await _repository.fetchTopRatedMovies();
    _topRatedFetcher.sink.add(itemModel);
  }

  handleHidePopup() {
    hidePopupSink.add(true);
  }

  handleShowPopup() {
    showPopupSink.add(true);
  }

  handleTileTap(int index, List<String> content) {
    selectedTileIndexSink.add(index);
    List<String> filterdContent =
        content.where((item) => item.isNotEmpty).toList();
    _popupContent.sink.add(filterdContent);
  }

  dispose() {
    // for Closing the _moviesFetcher stream when the moviesBloc is no longer needed
    // it avoids memory leak
    _moviesFetcher.close();
    _topRatedFetcher.close();
    _hideHandler.close();
    _showHandler.close();
    _selectedTileIndex.close();
    _popupContent.close();
  }
}

// Creating a Global instance of the MoviesBloc
// for managing the state that related to movies
final bloc = MoviesBloc();
