import 'package:cineflix/src/common/values/colors.dart';
import 'package:cineflix/src/ui/widgets/movie_show_list_builder.dart';
import 'package:flutter/material.dart';

import '../blocs/movies_bloc.dart';
import '../models/item_model.dart';

class ItemNavigation extends StatefulWidget {
  final int? buttonIndex;
  final int? itemIndex;
  final String? genreId;
  final String pageTitle;
  const ItemNavigation(
      {super.key,
      this.buttonIndex,
      this.itemIndex,
      this.genreId,
      required this.pageTitle});

  @override
  // ignore: no_logic_in_create_state
  State<ItemNavigation> createState() => _ItemNavigationState();
}

class _ItemNavigationState extends State<ItemNavigation> {
  @override
  Widget build(BuildContext context) {
    if (widget.genreId == null) {
      switch (widget.buttonIndex) {
        case 1:
          bloc.fetchMoviesForIndex(widget.itemIndex!);
          break;
        case 2:
          bloc.fetchTVShowsForIndex(widget.itemIndex!);
          break;
      }
    } else {
      bloc.fetchMoviesForIndex(5, genreId: widget.genreId!);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.home_filled,
                        color: Colors.red,
                      )),
                  // ,SizedBox(width: 80,),
                  Text(widget.pageTitle,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      )),
                  const Center(
                    child: Text('CineFlix',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        )),
                  ),
                ]),
          ),
        ),
        body: Material(
          color: AppColors.primaryBackground,
          child: StreamBuilder(
            stream: bloc.getStreamForIndex(widget.itemIndex ?? 5),
            builder: (context, AsyncSnapshot<ItemModel?> snapshot) {
              if (snapshot.hasData) {
                return MovieShowListBuilder(snapshot: snapshot);
              } else if (snapshot.connectionState == ConnectionState.none ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return const Center(
                  child: Text('No data avaliable'),
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

// buildList(AsyncSnapshot<ItemModel?> snapshot) {
//   PeopleApiProvider pplApi = PeopleApiProvider();
//   late List<Person> cast;
//   return Column(
//     children: [
//       const SizedBox(
//         height: 30,
//       ),
//       Expanded(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: GridView.builder(
//             itemCount: snapshot.data?.results.length,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               childAspectRatio: 5 / 8,
//               crossAxisSpacing: 20,
//               mainAxisSpacing: 20,
//               crossAxisCount: 2,
//             ),
//             itemBuilder: (BuildContext context, int index) {
//               final voteAverage = snapshot.data?.results[index].vote_average;
//               return GestureDetector(
//                   // // we can use GestureDetector instead of InkResponse
//                   onTap: () async {
//                     cast = await pplApi
//                         .fetchPeople(snapshot.data!.results[index].id);
//                     openDetailPage(
//                       context,
//                       snapshot.data,
//                       cast,
//                       index,
//                     );
//                   },
//                   child: MovieTile(
//                     itemModel: snapshot.data,
//                     index: index,
//                     voteAverage: voteAverage,
//                   ));
//             },
//           ),
//         ),
//       ),
//     ],
//   );
// }


