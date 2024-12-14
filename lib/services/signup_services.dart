import 'package:fluttertoast/fluttertoast.dart';
import '/services/firebase_service.dart';
import '../models/user.dart';

class SignUpService {
  final FirebaseServices _firebaseServices = FirebaseServices();

  Future<bool> signUpUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final AppUser? appUser = await _firebaseServices.signUpWithEmailPassword(
        email, password, firstName, lastName);

    if (appUser != null) {
      Fluttertoast.showToast(msg: "Sign-up successful!");
      return true;
    } else {
      Fluttertoast.showToast(msg: "Sign-up failed. Please try again.");
      return false;
    }
  }
}
