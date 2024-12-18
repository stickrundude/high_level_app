import 'package:flutter/material.dart';
import '/services/firebase_service.dart';
import '/utils/validators.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/generated/l10n.dart';

class LoginService {
  final FirebaseServices firebaseServices;

  LoginService({required this.firebaseServices});

  Future<bool> loginUser(
      BuildContext context, String? email, String? password) async {
    if (email == null ||
        password == null ||
        email.isEmpty ||
        password.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).fillEmailPassword);
      return false;
    }

    if (!Validators.isValidEmail(email)) {
      Fluttertoast.showToast(msg: S.of(context).invalidEmail);
      return false;
    }

    try {
      final appUser =
          await firebaseServices.signInWithEmailPassword(email, password);
      if (appUser != null) {
        return true;
      } else {
        Fluttertoast.showToast(msg: S.of(context).loginFailed);
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: S.of(context).loginError(e.toString()));
      return false;
    }
  }
}
