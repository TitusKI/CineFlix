import 'package:cineflix/src/common/values/colors.dart';
import 'package:cineflix/src/pages/common_widgets.dart';
import 'package:cineflix/src/pages/register/bloc/register_bloc.dart';
import 'package:cineflix/src/pages/register/bloc/register_event.dart';
import 'package:cineflix/src/pages/register/bloc/register_state.dart';
import 'package:cineflix/src/pages/register/registe_controller.dart';
import 'package:flutter/material.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterStates>(
      builder: (context, state) {
        return Container(
          color: AppColors.primaryBackground,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.primarySecondaryBackground,
              appBar: buildAppBar("Sign Up"),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                        child: reusableText(
                            "Enter your details below and free sign Up")),
                    Container(
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      margin: EdgeInsets.only(top: 50.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reusableText("User name"),
                          buildTextField("Enter your user name", "name", "user",
                              (value) {
                            context
                                .read<RegisterBloc>()
                                .add(UserNameEvent(value));
                          }),
                          reusableText("Email"),
                          buildTextField(
                              "Enter your email address", "email", "user",
                              (value) {
                            context.read<RegisterBloc>().add(EmailEvent(value));
                          }),
                          reusableText("Password"),
                          buildTextField(
                              "Enter your password", "password", "lock",
                              (value) {
                            context
                                .read<RegisterBloc>()
                                .add(PasswordEvent(value));
                          }),
                          reusableText("Confirm Password"),
                          buildTextField("Re-enter your password to confirm",
                              "confirmpassword", "lock", (value) {
                            context
                                .read<RegisterBloc>()
                                .add(RepasswordEvent(value));
                          }),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25.w),
                      child: reusableText(
                          "By creating an account you have agree with our terms and conditions"),
                    ),
                    buildLogInAndRegButton("Sign Up", "login", () {
                      // Navigator.of(context).pushNamed("register");
                      RegisterController(context).handleEmailRegister();
                    })
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
