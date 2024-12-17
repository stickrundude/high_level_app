import 'package:fluttertoast/fluttertoast.dart';
import '/services/firebase_service.dart';
import '/services/user_services.dart';
import '/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpService {
  final FirebaseServices _firebaseServices = FirebaseServices();
  final UserService _userService = UserService();

  Future<bool> signUpUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      await _clearCache();

      final AppUser? appUser = await _firebaseServices.signUpWithEmailPassword(
        email,
        password,
        firstName,
        lastName,
      );

      if (appUser != null) {
        try {
          final newUser = AppUser(
            uid: appUser.uid,
            firstName: appUser.firstName,
            lastName: appUser.lastName,
            email: appUser.email,
            subscriptionStatus: false,
          );

          await _userService.saveUserData(newUser);
          return true;
        } catch (e) {
          Fluttertoast.showToast(
            msg:
                "Sign-up partially successful, but failed to save user data: $e",
          );
          return false;
        }
      } else {
        Fluttertoast.showToast(msg: "Sign-up failed. Please try again.");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error during sign-up: $e");
      return false;
    }
  }

  Future<void> _clearCache() async {
    try {
      await FirebaseAuth.instance.signOut();
      print("Firebase Authentication cache cleared.");

      await FirebaseFirestore.instance.clearPersistence();
      print("Firestore cache cleared.");
    } catch (e) {
      print("Error clearing cache: $e");
    }
  }
}
