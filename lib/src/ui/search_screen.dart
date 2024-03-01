import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cineflix/src/blocs/search/search_bloc.dart';
import 'package:cineflix/src/blocs/search/search_event.dart';
import 'package:cineflix/src/models/item_model.dart';
import 'package:cineflix/src/blocs/search/search_state.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  String selectedMediaType = 'movie'; // default media Type

  @override
  Widget build(BuildContext context) {
    final SearchBloc searchBloc = BlocProvider.of<SearchBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              minLines: 1,
              maxLines: null,
              decoration: InputDecoration(
               border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                hintText: 'Search for a movie, tv show.....',
                suffixIcon: PopupMenuButton<String>(
                  onSelected: (String mediaType) {
                    selectedMediaType = mediaType;
                    searchBloc.add(PerformSearchEvent(query: query, mediaType: selectedMediaType));
                  },
                  itemBuilder: (BuildContext context) {
                    return ['movie', 'tv'].map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice == 'movie' ? "Movies" : "TV Shows"),
                      );
                    }).toList();
                  },
                ),
              ),
              onChanged: (newQuery) {
                query = newQuery;
                print("Query: $query");
                searchBloc.add(PerformSearchEvent(query: query, mediaType: 'movie'));
              },
            ),
          
          ],
        ),
      ),
      body: Center(
        child: Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            // color: Theme.of(context).primaryColorDark,

            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is SearchSuccessState) {
                  ItemModel itemModel = state.getItemModel;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: itemModel.results.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(itemModel.results[index].title ?? " ", style: TextStyle(color: Colors.white),
                        
                        ),
                        onTap: (){
                        
                        },
                      );
                    },
                  );
                } else if (state is SearchErrorState) {
                  return Center(child: Text('Error searching: ${state.errorMessage}'));
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
