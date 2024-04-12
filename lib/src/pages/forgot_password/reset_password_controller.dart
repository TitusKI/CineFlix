import 'package:cineflix/src/common/widgets/flutter_toast.dart';
import 'package:cineflix/src/pages/forgot_password/bloc/reset_password_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexpattern/regexpattern.dart';

class ResetPasswordController {
  BuildContext context;
  ResetPasswordController(this.context);

  void handleEmailReset() async {
    try {
      final state = context.read<ResetPasswordBloc>().state;
      String? email = state.email;
      print("The email state is: $email");

      if (email.isEmpty) {
        toastInfo(msg: "Email cannot be empty");
        return;
      } else if (!email.isEmail()) {
        toastInfo(msg: "The email format is invalid. Please enter a valid one");
        return;
      } else {
        try {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'auth/user-not-found') {
            toastInfo(msg: "No user found with the email $email");
          }
        }
        toastInfo(msg: "Password reset email sent to $email");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
