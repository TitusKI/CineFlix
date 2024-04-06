import 'package:flutter/material.dart';
import 'package:cineflix/src/blocs/movies_bloc.dart';
import 'package:cineflix/src/ui/search_screen.dart';
import 'package:cineflix/src/ui/movie_list.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'CineFlix',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          actions: [
            Builder(builder: (context) {
              return IconButton(
                onPressed: () {
                   bloc.handleHidePopup();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>  SearchScreen()));
                },
                icon: const Icon(
                  Icons.search,
                  weight: 50.0,
                ),
              );
            })
          ],
        ),
        body: Listener(
          onPointerDown: (event) {
            bloc.handleHidePopup();
          },
          child: const MovieList(),
        ),
      ),
    );
  }
}
