// import 'package:cineflix/src/common/values/colors.dart';
// import 'package:cineflix/src/pages/Settings/setting_page.dart';
// import 'package:cineflix/src/pages/register/registe_controller.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// Drawer appDrawer(BuildContext context) {
//   // RegisterController registerController =RegisterController(context);
//   // @override
//   // void initState(){
//   //   registerController.fetchUsername();
//   // }
//   return Drawer(
//       backgroundColor: AppColors.primaryBackground,
//       child: ListView(
//         padding: const EdgeInsets.all(10.0),
//         children: [
//           SizedBox(
//             height: 100.h,
//             child: DrawerHeader(
//               margin: const EdgeInsets.only(left: 2.0),
//               decoration:
//                   const BoxDecoration(color: AppColors.primaryBackground),
//               child: Container(
//                 margin: const EdgeInsets.all(10.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Container(
//                       // margin: const EdgeInsets.all(4.0),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           color: AppColors.primaryBackground),
//                       child: Text(data)
//                     ),
//                     const SizedBox(
//                       width: 5.0,
//                     ),
//                     Text("Cineflix",
//                         style: TextStyle(
//                             color: AppColors.primaryText,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 16.sp))
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           const Divider(
//             color: AppColors.primarySecondaryElementText,
//             thickness: 1.2,
//           ),
//           drawerTile("share", "Share App", () {
//             Navigator.of(context).pop();
//           }),
//           drawerTile("star", "Rate Us", () {
//             Navigator.of(context).pop();
//           }),
//           drawerTile("feedback", "Feedback", () {
//             Navigator.of(context).pop();
//           }),
//           drawerTile("contact", "Contact Us", () {
//             Navigator.of(context).pop();
//           }),
//           const Divider(
//             color: AppColors.primarySecondaryElementText,
//             thickness: 1.2,
//           ),
//           drawerTile("", "Settings", () {
//             Navigator.of(context).pop();
//             Navigator.of(context)
//                 .push(MaterialPageRoute(builder: (context) => SettingsPage()));
//           }),
//           drawerTile("", "About", () {
//             Navigator.of(context).pop();
//           }),
//         ],
//       ));
// }
 
// Widget drawerTile(String? iconName, String title, void Function() onTile) {
//   return ListTile(
//       leading: iconName != null ? Icon(getIconData(iconName)) : null,
//       title: Text(
//         title,
//         style: const TextStyle(
//           color: AppColors.primaryText,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       onTap: onTile);
// }

// IconData? getIconData(String iconName) {
//   switch (iconName) {
//     case "share":
//       return Icons.share;
//     case "star":
//       return Icons.star;
//     case "feedback":
//       return Icons.feedback;
//     case "contact":
//       return Icons.mail;
//     // Add more cases for other icon names as needed
//     default:
//       return null;
//   }
// }
