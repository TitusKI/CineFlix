import 'package:cineflix/src/ui/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cineflix/src/blocs/search/search_bloc.dart';
import 'package:cineflix/src/blocs/search/search_event.dart';
import 'package:cineflix/src/models/item_model.dart';
import 'package:cineflix/src/blocs/search/search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

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
                print("Query: $query");
                searchBloc
                    .add(PerformSearchEvent(query: query, mediaType: 'movie'));
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
                    if (state.getSelectedMovie != null) {
                      ItemModel? selectedMovie = state.getSelectedMovie;
                      try {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            String releaseDate = selectedMovie
                                    ?.results[index].release_date
                                    .toString() ??
                                '';

                            return Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: SizedBox(
                                      height: 200,
                                      width: 150,
                                      child: Expanded(
                                        child: Image.network(
                                            'https://image.tmdb.org/t/p/w185${selectedMovie?.results[index].poster_path}',
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            selectedMovie!.results[index].title
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            year(releaseDate),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          StarRating(
                                              voteAverage: selectedMovie
                                                  .results[index].vote_average),
                                          Text(
                                            selectedMovie
                                                .results[index].overview
                                                .toString(),
                                            maxLines: 3,
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      } catch (e) {
                        print("error $e");
                      }
                    } else {
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
                                Text(
                                  " (${year(itemModel.results[index].release_date ?? " ")})",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            onTap: () {
                              ItemModel tappedMovie = itemModel;
                              String clickedTitle =
                                  itemModel.results[index].title.toString();
                              tappedMovie
                                  .setResults([itemModel.results[index]]);
                              // tappedMovie.setResults([itemModel.results[index]]);
                              searchBloc.add(SelectedMovieEvent(tappedMovie));
                              // if (index >= 0 &&
                              //     index < itemModel.results.length) {
                              //   String clickedTitle =
                              //       itemModel.results[index].title ?? " ";
                              //   ItemModel tappedMovie = itemModel;
                              //   // ItemModel tapMovie = ItemModel.fromJson(itemModel.toJson());
                              //   // ItemModel? tappedMovie= itemModel;
                              //   tappedMovie
                              //       .setResults([itemModel.results[index]]);
                              //   final tappedItem = tappedMovie
                              //       .populateSimilarTitles(clickedTitle);

                              //   if (tappedItem != null) {
                              //     print(tappedMovie);
                              //     searchBloc
                              //         .add(SelectedMovieEvent(tappedMovie));
                              //   } else {
                              //     print("Selected Item not found in results");
                              //   }
                              // }
                              // else{
                              //   print("Invalid index: $index");
                              // }
                            },
                          );
                        },
                      );
                    }
                  } else if (state is SearchErrorState) {
                    return Center(
                        child: Text('Error searching: ${state.errorMessage}'));
                  } else {
                    return Container();
                  }
                  throw Exception("Error displaying");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  year(String date) {
    String year = '';
    if (date.isNotEmpty) {
      DateTime dateTime = DateTime.parse(date);
      year = dateTime.year.toString();
    }
    return year;
  }
}
