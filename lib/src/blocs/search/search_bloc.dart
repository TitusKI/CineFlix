import 'dart:convert';
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cineflix/src/models/item_model.dart';
import 'search_event.dart';
import 'search_state.dart';
import 'package:http/http.dart' show Client;

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitialState()) {
    on<PerformSearchEvent>((event, emit) async {
      emit(SearchLoadingState());

      try {
        dynamic searchResult = await searchAll(event.query, event.mediaType);
        emit(SearchSuccessState(searchResult, null));
      } catch (error) {
        emit(SearchErrorState('Failed to search ${event.mediaType}'));
      }
    });
    on<SelectedMovieEvent>((event, emit) async {
      if (state is SearchSuccessState) {
        ItemModel? selectedMovie =
            (state as SearchSuccessState).getSelectedMovie;
        if (selectedMovie != null) {
          selectedMovie.populateSimilarTitles(
              event.selectedMovie.similarTitles.single as String);
          emit(SearchSuccessState(
              (state as SearchSuccessState).getItemModel, selectedMovie));
        }
      }
    });
  }

  Future<dynamic> searchAll(String query, String mediaType) async {
    Client client = Client();
    const String apiKey = 'fdd7db0a47ca786d8055a9120ed43d35';
    final String apiUrl = "https://api.themoviedb.org/3/search/$mediaType";

    final String url = "$apiUrl?query=$query&api_key=$apiKey";
    print('API URL: $url');

    final response = await client.get(Uri.parse(url));
    final parsedJson = json.decode(response.body);
    print('Response status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      return ItemModel.fromJson(parsedJson as Map<String, dynamic>);
    } else {
      throw Exception('Failed to search $mediaType');
    }
  }
}
