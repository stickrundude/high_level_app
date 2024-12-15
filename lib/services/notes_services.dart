import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotesService {
  Future<void> saveNote(Map<String, dynamic> note) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final notesRef = FirebaseFirestore.instance.collection('notes');
    final docRef = await notesRef.add({
      'city': note['city'],
      'document': note['document'],
      'uid': user.uid,
    });

    note['id'] = docRef.id;
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];

    final notesRef = FirebaseFirestore.instance.collection('notes');
    final snapshot = await notesRef.where('uid', isEqualTo: user.uid).get();

    return snapshot.docs.map((doc) {
      var noteData = {
        'id': doc.id,
        'city': doc['city'],
        'document': doc['document'],
      };
      return noteData;
    }).toList();
  }

  Future<void> deleteNote(String noteId) async {
    final notesRef = FirebaseFirestore.instance.collection('notes');
    try {
      await notesRef.doc(noteId).delete();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error deleting note from Firestore: $e');
    }
  }
}
