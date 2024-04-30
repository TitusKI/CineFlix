import 'package:cineflix/src/models/people_model.dart';
import 'package:cineflix/src/resources/people_api_provider.dart';
import 'package:cineflix/src/ui/item_navigation.dart';
import 'package:cineflix/src/ui/movie_detail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cineflix/src/blocs/search/search_bloc.dart';
import 'package:cineflix/src/blocs/search/search_event.dart';
import 'package:cineflix/src/models/item_model.dart';
import 'package:cineflix/src/blocs/search/search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  String selectedMediaType = 'movie'; // default media Type

  year(String? date) {
    String year = 'N/A';
    if (date != null) {
      DateTime dateTime = DateTime.parse(date);
      year = dateTime.year.toString();
    }
    return year;
  }

  @override
  Widget build(BuildContext context) {
    final SearchBloc searchBloc = BlocProvider.of<SearchBloc>(context);
    PeopleApiProvider pplApi = PeopleApiProvider();
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Colors.grey,
            height: 1,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              minLines: 1,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: const TextStyle(color: Colors.white, fontSize: 20),
                hintText: 'Search for a movie, tvshow.....',
                suffixIcon: PopupMenuButton<String>(
                  onSelected: (String mediaType) {
                    selectedMediaType = mediaType;
                    searchBloc.add(PerformSearchEvent(
                        query: query, mediaType: selectedMediaType));
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

                searchBloc.add(PerformSearchEvent(
                    query: query, mediaType: selectedMediaType));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchSuccessState) {
                    ItemModel? itemModel = state.getItemModel;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: itemModel!.results.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  itemModel.results[index].title ?? " ",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                  "(${year(itemModel.results[index].release_date)})")
                            ],
                          ),
                          onTap: () async {
                            List<Person>? cast;
                            final tapped = itemModel.results[index];

                            cast = await pplApi.fetchPeople(
                                tapped.id, selectedMediaType == "tv" ? 2 : 1);
                            openDetailPage(
                              context,
                              itemModel,
                              cast,
                              index,
                            );

                            // Navigator.of(context)
                            // Navigator.of(context).pushNamed('/movie_detail');

                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => MovieDetail(
                            //       title: tapped.title,
                            //       voteAverage: tapped.vote_average,
                            //       movieId: tapped.id,
                            //       releaseDate: tapped.release_date ?? "",
                            //       cast: cast,
                            //       itemIndex: index,
                            //       //  Since it causes invalid format date exeception
                            //       // releaseDate: tapped.release_date,
                            //       posterUrl: tapped.poster_path,
                            //       description: tapped.overview,
                            //     ),
                            //   ),
                            // );
                          },
                        );
                      },
                    );
                  } else if (state is SearchErrorState) {
                    return Center(
                        child: Text('Error searching: ${state.errorMessage}'));
                  } else {
                    return Container();
                  }
                  // throw Exception("Error displaying");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
