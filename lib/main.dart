import 'package:cineflix/global.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:flutter/services.dart';

import 'src/app.dart';

Future<void> main() async {
  await Global.init();

  runApp(const App());
}
