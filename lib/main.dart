import 'package:cineflix/global.dart';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import 'src/app.dart';

// void main() {
//   runApp(BlocProvider(create: (context) => SearchBloc(), child: const App()));
// }

Future<void> main() async {
  await Global.init();

  runApp(const App());
}
