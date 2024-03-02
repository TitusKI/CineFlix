import 'package:cineflix/src/models/item_model.dart';
import 'package:meta/meta.dart';
@immutable
abstract class SearchState{}
class SearchInitialState extends SearchState {}
class SearchLoadingState extends SearchState {}
class SearchSuccessState extends SearchState {

  final ItemModel _itemModel;
  final ItemModel? _selectedMovie;
  SearchSuccessState (this._itemModel, this._selectedMovie);
  ItemModel get getItemModel => _itemModel;
  ItemModel? get getSelectedMovie => _selectedMovie;
  @override
  List<Object> get props => [_itemModel, _selectedMovie!];
}
class SearchErrorState extends SearchState {
  final String errorMessage;
  SearchErrorState(this.errorMessage);
}