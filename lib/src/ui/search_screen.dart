import 'dart:collection';

import 'package:cineflix/src/blocs/search/search_bloc.dart';
import 'package:cineflix/src/blocs/search/search_event.dart';
import 'package:cineflix/src/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/search/search_state.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String query = '';
    String selectedMediaType = 'movie'; // default media Type
    final SearchBloc searchBloc = BlocProvider.of<SearchBloc>(context);
    return Column(
      children: [
        Container(
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.black, fontSize: 20),
                hintText: 'Search for a movie, tv show.....',
                suffixIcon: PopupMenuButton<String>(
                  onSelected: (String mediaType) {
                    selectedMediaType = mediaType;
                    searchBloc.add(
                        PerformSearchEvent(query: query, mediaType: selectedMediaType));
                  },
                  itemBuilder: (BuildContext context) {
                    return ['movie, tv'].map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice == 'movie' ? "Movies" : "TV Shows"),
                      );
                    }).toList();
                  },
                )),
            onChanged: (newQuery) {
              
              query = newQuery;
              print("Query: $query");
              searchBloc
                  .add(PerformSearchEvent(query: query, mediaType: 'movie'));
            },
          ),
        ),
        SizedBox(height: 40,),
        Container(
          // height: 400,
          height: 200,
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchLoadingState) {
                return CircularProgressIndicator();
              } else if (state is SearchSuccessState) {
                ItemModel itemModel = state.getItemModel;
                // Display search results widget
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: itemModel.results.length,
                  itemBuilder: (context, index) {
                    // _Result result = itemModel.results[index];
                    return ListTile(
                      title: Text(itemModel.results[index].title ?? " "),
                      // subtitle: Text(state.searchResult[index].description),
                    );
                  },
                );
                // return Text('Search Results: ${state.searchResult}');
              } else if (state is SearchErrorState) {
                return Text('Error search: ${state.errorMessage}');
              } else {
                return Container();
              }
            },
          ),
        )
      ],
    );
  }
}
