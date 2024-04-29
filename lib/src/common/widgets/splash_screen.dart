// import 'package:cineflix/src/common/services/storage_services.dart';
// import 'package:cineflix/src/common/values/colors.dart';
// import 'package:cineflix/src/pages/sign_in/sign_in.dart';
// import 'package:cineflix/src/pages/welcome/welcome.dart';
// import 'package:cineflix/src/ui/home_page.dart';
// import 'package:cineflix/src/ui/movie_list.dart';

// import 'package:flutter/material.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final StorageService storageService = StorageService();
//     bool isFirstOpen = storageService.getDeviceFirstOpen();
//     bool isLoggedIn = storageService.getIsLoggedIn();
//     Future.delayed(const Duration(milliseconds: 1500), () {
//       Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(
//               builder: (context) => isFirstOpen
//                   ? const Welcome()
//                   : isLoggedIn
//                       ? const MovieList()
//                       : const SignIn()),
//           (route) => false);
//     });

//     return Scaffold(
//       backgroundColor: AppColors.primaryBackground,
//       body: Center(
//         child: Image.asset('assets/cineflix.jpg'), // Replace with your app logo
//       ),
//     );
//   }
// }
