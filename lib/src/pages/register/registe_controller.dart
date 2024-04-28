import 'package:cineflix/src/common/widgets/flutter_toast.dart';
import 'package:cineflix/src/pages/register/bloc/register_bloc.dart';
import 'package:cineflix/src/pages/register/bloc/register_event.dart';
import 'package:cineflix/src/pages/register/bloc/register_state.dart';
import 'package:cineflix/src/pages/register/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexpattern/regexpattern.dart';

class RegisterController {
  final BuildContext context;
  const RegisterController(this.context);

  void handleEmailRegister() async {
    final state = context.read<RegisterBloc>().state;
    String userName = state.userName;
    String email = state.email;
    String password = state.password;
    String repassword = state.repassword;

    if (userName.isEmpty) {
      toastInfo(msg: "User name can not be empty");
      return;
    }
    if (email.isEmpty) {
      toastInfo(msg: "Email can not be empty");
      return;
    }
    if (!email.isEmail()) {
      toastInfo(msg: "Please Enter a Valid Email Address");
    }
    if (password.isEmpty) {
      toastInfo(msg: "Password can not be empty");
      return;
    }

    if (repassword.isEmpty) {
      toastInfo(msg: "Your password confirmation is wrong");
      return;
    }
    if (repassword != password) {
      toastInfo(msg: "The Password doesn't match the previous password");
      return;
    }

    try {
      context.read<RegisterBloc>().add(RegistereLoadingEvent());
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        await credential.user?.sendEmailVerification();
        await credential.user?.updateDisplayName(userName);
        toastInfo(
            msg:
                "An email has been sent to your email. To activate it please check your email box and click on the link");
        context.read<RegisterBloc>().add(RegistereSuccessEvent());
        Navigator.of(context).pop();
      }
      String userID = credential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(userID).set({
        "email": email,
        "username": userName,
      });
    } on FirebaseAuthException catch (e) {
      context.read<RegisterBloc>().add(RegistereFailureEvent(error: e.code));
      if (e.code == "weak-password") {
        toastInfo(msg: "The password provided is too weak");
      }
      if (e.code == "email-already-in-in-use") {
        toastInfo(msg: "The email is already in use");
      }
      if (e.code == "invalid-email") {
        toastInfo(msg: "Your email is invalidT");
      }
    }
  }

  getUserInfo(String uid) async {
    try {
      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      return userData.data();
    } catch (e) {
      print("Error getting user Info ${e.toString()}");
    }
  }
}
