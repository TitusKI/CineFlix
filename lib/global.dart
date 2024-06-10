import 'package:cineflix/firebase_options.dart';
import 'package:cineflix/src/common/services/storage_services.dart';
import 'package:cineflix/src/models/item_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class Global {
  static late StorageService storageService;
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    Hive.registerAdapter(ItemModelAdapter());
    Hive.registerAdapter(ResultAdapter());
    await Hive.openBox<ItemModel>('itemBox');
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    // await Future.delayed(const Duration(seconds: 2));
    storageService = await StorageService().init();
  }
}
