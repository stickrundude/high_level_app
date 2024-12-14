import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '/models/user.dart';

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
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
        });

        return AppUser(
          uid: user.uid,
          firstName: firstName,
          lastName: lastName,
          email: email,
        );
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
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        return AppUser.fromMap(userData.data() as Map<String, dynamic>);
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
