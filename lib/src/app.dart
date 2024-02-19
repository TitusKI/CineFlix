

import 'package:cineflix/src/blocs/movies_bloc.dart';
import 'package:flutter/material.dart';
import 'ui/movie_list.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: const Text('CineFlix',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                )),
          ),
        ),
       body: Listener(onPointerDown: (event){
      bloc.handleHidePopup();
    
       },
       child: MovieList(),),
      )
    );
  }
}
