import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/models/user.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getCurrentUserUid() async {
    final user = _auth.currentUser;
    return user?.uid;
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      DocumentSnapshot userData =
          await _firestore.collection('users').doc(uid).get();
      return userData.data() as Map<String, dynamic>?;
    } catch (e) {
      Fluttertoast.showToast(msg: "Error fetching user data: $e");
      return null;
    }
  }

  Future<void> saveUserData(AppUser user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
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
      await _firestore.collection('users').doc(uid).update(updates);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error updating user data: $e");
    }
  }

  Future<void> deleteUser(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).delete();
    } catch (e) {
      Fluttertoast.showToast(msg: "Error deleting user document: $e");
    }
  }

  bool isUserLoggedIn() {
    return _auth.currentUser != null;
  }

  Future<int> getNoteCount() async {
    try {
      final userId = await getCurrentUserUid();
      if (userId == null) {
        throw Exception("User not logged in");
      }

      final notesSnapshot = await _firestore
          .collection('notes')
          .where('uid', isEqualTo: userId)
          .get();

      return notesSnapshot.docs.length;
    } catch (e) {
      Fluttertoast.showToast(msg: "Error getting note count: $e");
      return 0;
    }
  }
}
