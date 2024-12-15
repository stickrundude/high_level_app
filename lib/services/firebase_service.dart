import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import '/models/user.dart';
import '/services/user_services.dart';

class FirebaseServices {
  static Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      print("Firebase initialized successfully.");
    } catch (e) {
      print("Error initializing Firebase: $e");
      Fluttertoast.showToast(msg: "Error initializing Firebase: $e");
    }
  }

  Future<AppUser?> signUpWithEmailPassword(
      String email, String password, String firstName, String lastName) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        AppUser newUser = AppUser(
          uid: user.uid,
          firstName: firstName,
          lastName: lastName,
          email: email,
        );
        await UserService().saveUserData(newUser);
        return newUser;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error during sign-up: $e");
      return null;
    }
    return null;
  }

  Future<AppUser?> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if (user != null) {
        Map<String, dynamic>? userData =
            await UserService().getUserData(user.uid);
        if (userData != null) {
          return AppUser.fromMap(userData);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error during sign-in: $e");
      return null;
    }
    return null;
  }
}
