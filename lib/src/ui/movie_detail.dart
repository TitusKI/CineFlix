

import '../models/trailer_model.dart';

import '../blocs/movies_detail_bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetail extends StatefulWidget {
  final posterUrl;
  final description;
  final releaseDate;
  final String title;
  final String voteAverage;
  final int movieId;

  MovieDetail({
    required this.title,
    this.posterUrl,
    this.description,
    this.releaseDate,
    required this.voteAverage,
    required this.movieId,
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
    );
  }
}

class MovieDetailState extends State<MovieDetail> {



  final posterUrl;
  final description;
  final releaseDate;
  final String title;
  final String voteAverage;
  final int movieId;
  late MovieDetailBloc bloc;
  MovieDetailState({
    required this.title,
    this.posterUrl,
    this.description,
    this.releaseDate,
    required this.voteAverage,
    required this.movieId,
  });

  double?  _trailerHeight;

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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                          fit: BoxFit.cover)),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.favorite),
                          color: Colors.red,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 1.0, right: 1.0),
                        ),
                        Text(
                          voteAverage,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        ),
                        Text(
                          releaseDate,
                          style: TextStyle(fontSize: 18.0),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      description,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      "Trailer",
                      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
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
                                    if (itemSnapshot.data!.results.length > 0) {
                                      return trailerLayout(itemSnapshot.data);
                                    } else
                                      return noTrailer(itemSnapshot.data);
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                });
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
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

  noTrailer(TrailerModel? data) {
    return Center(
      child: Container(
        child: Text("No trailer avaliable"),
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
            margin: EdgeInsets.all(5.0),
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
                icon: Icon(Icons.play_circle_filled),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    if (videoKey != null) {
                      trailorPlayerScreen(data, videoKey!);
                      print(videoKey);
                    }
                    return trailorPlayerScreen(data, videoKey!);

                  }
                  ));
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

                SizedBox(
                  height: 6,
                ),
                Container(

                  margin: EdgeInsets.only(top: 26),
                  child: YoutubePlayerBuilder(
                    player: YoutubePlayer(

                        controller: YoutubePlayerController(
                          initialVideoId: videoKey,
                          // flags: YoutubePlayerFlags(
                          //
                          // )
                        )
                    ), builder: (BuildContext context, player ) {
                    return Center(

                      child: Container(


                        child: Column(

                          children: [
                            SizedBox(
                              height: _trailerHeight,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Trailer Play',
                                  style: TextStyle(
                                    decoration: TextDecoration.none,

                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: Icon(Icons.clear)),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
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
        ),],
    );
  }
}
