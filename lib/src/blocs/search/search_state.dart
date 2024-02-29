import 'package:cineflix/src/models/item_model.dart';
import 'package:meta/meta.dart';
@immutable
abstract class SearchState{}
class SearchInitialState extends SearchState {}
class SearchLoadingState extends SearchState {}
class SearchSuccessState extends SearchState {

  final ItemModel itemModel;
  SearchSuccessState (this.itemModel);
  ItemModel get getItemModel => itemModel;
  @override
  List<Object> get props => [itemModel];
}
class SearchErrorState extends SearchState {
  final String errorMessage;
  SearchErrorState(this.errorMessage);
}