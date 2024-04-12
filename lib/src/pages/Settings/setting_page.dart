import 'package:cineflix/global.dart';
import 'package:cineflix/src/common/routes/names.dart';
import 'package:cineflix/src/common/values/colors.dart';
import 'package:cineflix/src/common/values/constant.dart';
import 'package:cineflix/src/pages/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void removeUserData() {
    Global.storageService.remove(AppConstant.STORAGE_USER_TOKEN_KEY);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoutes.SIGN_IN, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: buildAppBar("Settings"),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm logout"),
                        content: const Text("Confirm logout"),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Cancel")),
                          TextButton(
                              onPressed: () => removeUserData(),
                              child: const Text("Confirm"))
                        ],
                      );
                    });
              },
              child: Container(
                height: 100.w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/icons/Logout.png"),
                )),
              ),
            )
          ],
        )),
      ),
    );
  }
}
