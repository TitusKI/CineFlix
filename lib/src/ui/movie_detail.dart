import 'package:cineflix/src/common/date_formatter.dart';
import 'package:cineflix/src/common/services/cloud_services.dart';
import 'package:cineflix/src/common/values/colors.dart';
import 'package:cineflix/src/models/item_model.dart';
import 'package:cineflix/src/models/people_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cineflix/src/ui/widgets/star_rating.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../models/trailer_model.dart';

import '../blocs/movies_detail_bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetail extends StatefulWidget {
  final String? posterUrl;
  final String? description;
  final String? releaseDate;
  final String? title;
  final double? voteAverage;
  final int movieId;
  final List<Person>? cast;
  final int itemIndex;
  final ItemModel? itemModel;

  const MovieDetail({
    super.key,
    required this.title,
    this.posterUrl,
    this.description,
    this.releaseDate,
    required this.voteAverage,
    required this.movieId,
    this.cast,
    required this.itemIndex,
    this.itemModel,
  });
  @override
  State<StatefulWidget> createState() {
    return MovieDetailState(
      title: title,
      posterUrl: posterUrl,
      description: description,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      movieId: movieId,
      cast: cast,
      itemIndex: itemIndex,
      itemModel: itemModel,
    );
  }
}

class MovieDetailState extends State<MovieDetail> {
  final String? posterUrl;
  final String? description;
  final String? releaseDate;
  final String? title;
  final double? voteAverage;
  final int movieId;
  late MovieDetailBloc bloc;
  final List<Person>? cast;
  final int itemIndex;
  final ItemModel? itemModel;

  late bool _isFavorite = false;
  late DocumentReference favoriteDocRef = favoriteServices.myCollection
      .doc(itemModel?.results[itemIndex].id.toString());
  //   final CollectionReference myCollection =
  //     FirebaseFirestore.instance.collection('UsersWithFavorite');
  // final DocumentReference favoriteDocRef = myCollection.doc(_user)
  FavoriteServices favoriteServices = FavoriteServices();

  MovieDetailState({
    required this.title,
    this.posterUrl,
    this.description,
    this.releaseDate,
    required this.voteAverage,
    required this.movieId,
    this.cast,
    required this.itemIndex,
    this.itemModel,
  });

  double? _trailerHeight;
  String? _emailAddress;

  @override
  void initState() {
    super.initState();
    // Fetch username when the drawer is initialized
    fetchUsername();
    fetchFavoriteData();
  }

  Future<void> fetchUsername() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      setState(() {
        _emailAddress = userData.get('email');
      });
    }
  }

  Future<void> fetchFavoriteData() async {
    final DocumentSnapshot favortieDocSnap = await favoriteDocRef.get();
    setState(() {
      _isFavorite = favortieDocSnap.exists;
    });
  }

  @override
  void didChangeDependencies() {
    bloc = MovieDetailBlocProvider.of(context)!;
    bloc.fetchTrailerById(movieId);
    _trailerHeight = MediaQuery.of(context).size.height * 0.25;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.dispose();
    //  fetchFavoriteData().ignore();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String baseImgUrl = "https://image.tmdb.org/t/p/w500";
    return Scaffold(
        body: SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  'https://image.tmdb.org/t/p/w500$posterUrl',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, StackTrace) {
                    return const Center(
                        child: SpinKitThreeBounce(
                      color: AppColors.primaryText,
                      size: 20.0,
                    ));
                  },
                ),
              ),
            )
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        title!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (_isFavorite) {
                          onFavoriteRemove(itemModel);
                        } else {
                          onFavoritePressed();
                        }
                      },
                      icon: Icon(
                        _isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: _isFavorite ? Colors.red : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                StarRating(voteAverage: voteAverage!),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  description!,
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  releaseDate != null
                      ? "Released In: ${formatDate(releaseDate!)}"
                      : "Released In: N/A",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Cast",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: cast!.map((item) {
                      // int index = cast!.indexOf(item);
                      return Container(
                        width: 100,
                        height: 160,
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 120,
                              width: 90,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  "$baseImgUrl/${item.profilePath}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const Text(
                  "Trailer",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                StreamBuilder(
                    stream: bloc.movieTrailers,
                    builder: (context,
                        AsyncSnapshot<Future<TrailerModel?>> snapshot) {
                      if (snapshot.hasData) {
                        return FutureBuilder(
                            future: snapshot.data,
                            builder: (context,
                                AsyncSnapshot<TrailerModel?> itemSnapshot) {
                              if (itemSnapshot.hasData) {
                                if (itemSnapshot.data!.results.isNotEmpty) {
                                  return trailerLayout(itemSnapshot.data);
                                } else {
                                  return noTrailer(itemSnapshot.data);
                                }
                              } else {
                                return const Center(
                                  child: SpinKitThreeBounce(
                                    color: AppColors.primaryText,
                                    size: 20.0,
                                  ),
                                );
                              }
                            });
                      } else {
                        return const Center(
                          child: SpinKitThreeBounce(
                            color: AppColors.primaryText,
                            size: 20.0,
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  onFavoritePressed() {
    //  final id = moviesModel!.results[].id;
    favoriteServices.addFavorite(itemModel!, itemIndex);
  }

  onFavoriteRemove(ItemModel? moviesModel) {
    favoriteServices.deleteFavorite(moviesModel!.results[itemIndex].id);
  }

  noTrailer(TrailerModel? data) {
    return Center(
      child: Container(
        child: const Text("No trailer avaliable"),
      ),
    );
  }

  trailerLayout(TrailerModel? data) {
    if (data!.results.length > 1) {
      return SingleChildScrollView(
        child: Row(
          children: <Widget>[
            trailerItem(data, 0),
            trailerItem(data, 1),
          ],
        ),
      );
    } else {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
        ],
      );
    }
  }

  trailerItem(TrailerModel? data, int index) {
    final videoKey = data?.results[index].key;
    return Expanded(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(5.0),
            height: 100.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500$posterUrl',
                  ),
                  fit: BoxFit.cover),
            ),
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.play_circle_filled),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    if (videoKey != null) {
                      trailorPlayerScreen(data, videoKey);
                      print(videoKey);
                    }
                    return trailorPlayerScreen(data, videoKey!);
                  }));
                },
              ),
            ),
          ),
          Text(
            data!.results[index].name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  trailorPlayerScreen(TrailerModel? data, String videoKey) {
    // Screens for the trailer video
    return Stack(
      fit: StackFit.expand,
      children: [
        Center(
          child: Container(
            height: 1000,
            color: Colors.black,
            child: Column(
              children: [
                const SizedBox(
                  height: 6,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 26),
                  child: YoutubePlayerBuilder(
                    player: YoutubePlayer(
                        controller: YoutubePlayerController(
                      initialVideoId: videoKey,
                      // flags: YoutubePlayerFlags(
                      //
                      // )
                    )),
                    builder: (BuildContext context, player) {
                      return Center(
                        child: Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: _trailerHeight,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    title ?? "Trailer play",
                                    style: const TextStyle(
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Icon(Icons.clear)),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  height: 200,
                                  child: player,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
