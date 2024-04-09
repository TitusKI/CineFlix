import 'package:cineflix/firebase_options.dart';
import 'package:cineflix/src/blocs/search/search_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/app.dart';

// void main() {
//   runApp(BlocProvider(create: (context) => SearchBloc(), child: const App()));
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}