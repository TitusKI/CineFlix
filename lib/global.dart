import 'package:cineflix/firebase_options.dart';
import 'package:cineflix/src/common/services/storage_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Global {
  static late StorageService storageService;
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    // await Future.delayed(const Duration(seconds: 2));
    storageService = await StorageService().init();
  }
}
