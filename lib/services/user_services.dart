import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/models/user.dart';

class UserService {
  Future<String?> getCurrentUserUid() async {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      return userData.data() as Map<String, dynamic>?;
    } catch (e) {
      Fluttertoast.showToast(msg: "Error fetching user data: $e");
      return null;
    }
  }

  Future<void> saveUserData(AppUser user) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'firstName': user.firstName,
        'lastName': user.lastName,
        'email': user.email,
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Error saving user data: $e");
    }
  }

  Future<void> updateUserData(String uid, Map<String, dynamic> updates) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update(updates);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error updating user data: $e");
    }
  }

  Future<void> deleteUser(String uid) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).delete();
    } catch (e) {
      Fluttertoast.showToast(msg: "Error deleting user document: $e");
    }
  }

  bool isUserLoggedIn() {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }
}
