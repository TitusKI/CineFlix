import 'package:cineflix/src/common/routes/pages.dart';
import 'package:cineflix/src/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:cineflix/src/blocs/movies_bloc.dart';
import 'package:cineflix/src/ui/search_screen.dart';
import 'package:cineflix/src/ui/movie_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     theme: ThemeData.dark(),
  //     onGenerateRoute: ,
  //   );
  // }

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...AppPages.allBlocProvider(context)],
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          // theme: ThemeData(
            
          //   iconTheme: const IconThemeData(color: AppColors.primaryText),
          //   appBarTheme: const AppBarTheme(
          //     elevation: 0,
          //     backgroundColor: Colors.white,
          //   ),
          // ),
        onGenerateRoute: AppPages.GenerateRouteSettings,

          // home: const Welcome(),
          // routes: {
          //   // "myHomePage": (context) => const MyHomePage(),
          //   "signIn": (context) => const SignIn(),
          //   "register": (context) => const Register(),
          // },
        ),
      ),
    );
  }
}
