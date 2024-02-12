import '../blocs/movies_detail_bloc_provider.dart';
import 'movie_detail.dart';
import '../models/item_model.dart';
import '../blocs/movies_bloc.dart';
import 'package:flutter/material.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  //all its properties are immutable
  @override
  State<StatefulWidget> createState() {
    return MovieListState();
  }
}

class MovieListState extends State<MovieList> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllMovies();
    //By using WidgetsBinding.instance.addPostFrameCallback,
    // ensure that _animatedListView is called after the frame is painted,
    // and the ListView is properly built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animatedListView();
    });
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies();
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text('CineFlix',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red),),
        ),
      ),
      body: Column(
        children: [
          Text('Popular Movies'),
          Flexible(

            child: StreamBuilder(

                stream: bloc.allMovies,
                builder: (context, AsyncSnapshot<ItemModel?> snapshot) {
                  if (snapshot.hasData) {
                    return buildList(snapshot);
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ),
          Flexible(
              flex: 2,
              child: Text('Genre')
          )
        ],
      ),
    );
  }
final ScrollController _controller = ScrollController();
 void _animatedListView(){
   Future.delayed(Duration(seconds: 5),(){
     _controller.animateTo(
         _controller.position.maxScrollExtent,
         duration: Duration(seconds: 50),
         curve: Curves.linear
     ).then(
             (_) {

               _controller.jumpTo(_controller.position.minScrollExtent);
               _animatedListView();
             }
     );
   }
   );
 }

  buildList(AsyncSnapshot<ItemModel?> snapshot) {

    return ListView.builder(
      controller:_controller ,
      itemCount: snapshot.data?.results.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          // we can use GestureDetector instead of InkResponse

          onTap: () {
            openDetailPage(snapshot.data, index);
          },
          child: Column(
            children: [

              Container(
                height: 200,
                margin: EdgeInsets.only(top: 8,bottom: 8,right: 5,left: 5),
                child: Image.network(
                    'https://image.tmdb.org/t/p/w185${snapshot.data?.results[index].poster_path}',
                    fit: BoxFit.cover
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  openDetailPage(ItemModel? data, int index) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MovieDetailBlocProvider(
        // Returning of instances of MovieDetailBlocProvider(InheritedWidget)
        // wrapping the MOvieDetail screen to it.
        // So MovieDetailBloc class will be accessible inside the detail
        // screen and to all the widgets since
        // It is in the Initializer list of the MovieDetailBlocProvider instances
        key: GlobalKey(),
        child: MovieDetail(
          title: data!.results[index].title,
          posterUrl: data!.results[index].poster_path,
          description: data!.results[index].overview,
          releaseDate: data!.results[index].release_date,
          voteAverage: data!.results[index].vote_average.toString(),
          movieId: data!.results[index].id,
        ),
      );
    }));
  }
}
