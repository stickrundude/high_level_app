import 'package:fluttertoast/fluttertoast.dart';
import '/services/firebase_service.dart';
import '/services/user_services.dart';
import '../models/user.dart';

class SignUpService {
  final FirebaseServices _firebaseServices = FirebaseServices();
  final UserService _userService = UserService();

  Future<bool> signUpUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final AppUser? appUser = await _firebaseServices.signUpWithEmailPassword(
      email,
      password,
      firstName,
      lastName,
    );

    if (appUser != null) {
      try {
        await _userService.saveUserData(appUser);
        Fluttertoast.showToast(msg: "Sign-up successful!");
        return true;
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Sign-up partially successful, but failed to save user data: $e",
        );
        return false;
      }
    } else {
      Fluttertoast.showToast(msg: "Sign-up failed. Please try again.");
      return false;
    }
  }
}
