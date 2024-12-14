import '/services/firebase_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginService {
  final FirebaseServices firebaseServices = FirebaseServices();

  bool isValidEmail(String email) {
    final RegExp emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }

  Future<bool> loginUser(String? email, String? password) async {
    print("Email: $email, Password: $password");

    if (email == null ||
        password == null ||
        email.isEmpty ||
        password.isEmpty) {
      Fluttertoast.showToast(msg: "Email or password cannot be empty");
      return false;
    }

    if (!isValidEmail(email)) {
      Fluttertoast.showToast(msg: "Invalid email format");
      return false;
    }

    final appUser =
        await firebaseServices.signInWithEmailPassword(email, password);

    if (appUser != null) {
      return true;
    } else {
      Fluttertoast.showToast(
          msg: "Login failed. Please check your credentials.");
      return false;
    }
  }
}
