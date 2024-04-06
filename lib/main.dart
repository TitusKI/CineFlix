import 'package:cineflix/src/blocs/search/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/app.dart';

void main() {
  runApp(BlocProvider(create: (context) => SearchBloc(), child: const App()));
}
