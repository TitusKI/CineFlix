import 'package:cineflix/global.dart';
import 'package:cineflix/src/common/values/constant.dart';
import 'package:cineflix/src/common/widgets/flutter_toast.dart';
import 'package:cineflix/src/pages/sign_in/blocs/sign_in_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexpattern/regexpattern.dart';

class SignInController {
  final BuildContext context;
  SignInController({required this.context});

  void handleSignIn(String type) async {
    try {
      if (type == "email") {
        // Read and access Sign In Bloc here to get the state
        final state = context.read<SignInBloc>().state;
        String emailAddress = state.email;
        String userPassword = state.password;
        print(emailAddress);
        if (emailAddress.isEmpty) {
          toastInfo(msg: "You need to fill email address");
          return;
        }
        if (emailAddress.isEmail()) {
          toastInfo(msg: "Please put valid Email address");
          return;
        }
        if (userPassword.isEmpty) {
          toastInfo(msg: "You need to fill password");
          return;
        }
        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailAddress, password: userPassword);

          if (credential.user == null) {
            toastInfo(msg: "User doesn't exist");
            return;
          }
          if (!credential.user!.emailVerified) {
            toastInfo(msg: "You need to verify your email account");
            return;
          }

          final user = credential.user;
          if (user != null) {
            Global.storageService
                .setString(AppConstant.STORAGE_USER_TOKEN_KEY, "12345678");
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/movie_list", ((route) => false));
            toastInfo(msg: "User exist");
            return;
          } else {
            toastInfo(msg: "You aren't registered Please Sign Up first");
            return;
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == "user-not-found") {
            toastInfo(msg: "No User found for that email");
            return;
          } else if (e.code == 'wrong-password') {
            toastInfo(msg: "Wrong password provided by You");
            return;
          } else if (e.code == 'invalid-email') {
            toastInfo(msg: "Invalid email provided");
            return;
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
