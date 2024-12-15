import '/services/firebase_service.dart';
import '/utils/validators.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginService {
  final FirebaseServices firebaseServices;

  LoginService({required this.firebaseServices});

  Future<bool> loginUser(String? email, String? password) async {
    if (email == null ||
        password == null ||
        email.isEmpty ||
        password.isEmpty) {
      Fluttertoast.showToast(msg: "Email or password cannot be empty");
      return false;
    }

    if (!Validators.isValidEmail(email)) {
      Fluttertoast.showToast(msg: "Invalid email format");
      return false;
    }

    try {
      final appUser =
          await firebaseServices.signInWithEmailPassword(email, password);
      if (appUser != null) {
        return true;
      } else {
        Fluttertoast.showToast(
            msg: "Login failed. Please check your credentials.");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "An error occurred during login: $e");
      return false;
    }
  }
}
