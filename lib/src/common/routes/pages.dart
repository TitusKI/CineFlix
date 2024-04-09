// The UNIFICATION Of BlocProvider and routes and pages
import 'package:cineflix/src/blocs/search/search_bloc.dart';
import 'package:cineflix/src/common/routes/names.dart';
import 'package:cineflix/src/pages/application/application.dart';
import 'package:cineflix/src/pages/register/bloc/register_bloc.dart';
import 'package:cineflix/src/pages/register/register.dart';
import 'package:cineflix/src/pages/sign_in/blocs/sign_in_bloc.dart';
import 'package:cineflix/src/pages/sign_in/sign_in.dart';
import 'package:cineflix/src/pages/welcome/blocs/bloc/welcome_bloc.dart';
import 'package:cineflix/src/pages/welcome/welcome.dart';
import 'package:cineflix/src/ui/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppPages {
 static List<PageEntity> routes() {
    return [
      PageEntity(
        route: AppRoutes.INITIAL,
        page: const Welcome(),
        bloc: BlocProvider(
          create: (_) => WelcomeBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.SIGN_IN,
        page: const SignIn(),
        bloc: BlocProvider(
          create: (_) => SignInBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.REGISTER,
        page: const Register(),
        bloc: BlocProvider(
          create: (_) => RegisterBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.APPLICATION,
        page: const MovieList(),
        bloc: BlocProvider(create: (_)=> SearchBloc(),)
        // bloc: BlocProvider(
        //   create: (_) => ApplicationBl(),
        // ),
      )
    ];
  }
  static List<dynamic> allBlocProvider(BuildContext context){
    List<dynamic> blocProviders = <dynamic>[];
    for(var bloc in routes()){
     blocProviders.add(bloc.bloc);
    }
    return blocProviders;
  }
  // models that covers entire screen as we click on navigator object
  static MaterialPageRoute GenerateRouteSettings(RouteSettings settings){
   if(settings.name!=null){
    // check for route name matching when navigator gets triggered
    var result = routes().where((element) => element.route==settings.name);
    if(result.isNotEmpty){
       print("valid route name: ${settings.name}");
      return MaterialPageRoute(builder: (_)=> result.first.page, settings: settings);
    }

   }
   print("Invalid route name: ${settings.name}");
   return MaterialPageRoute(builder: (_)=>const SignIn(), settings: settings);
  }
}


class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({required this.route, required this.page, this.bloc});
}
