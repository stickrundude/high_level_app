import 'package:cloud_firestore/cloud_firestore.dart';
import '/services/user_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotesService {
  final CollectionReference _notesCollection =
      FirebaseFirestore.instance.collection('notes');

  Future<void> saveNote(Map<String, dynamic> note) async {
    try {
      final userUid = await UserService().getCurrentUserUid();
      if (userUid == null) {
        throw Exception('User not logged in');
      }

      if (!note.containsKey('city') || !note.containsKey('document')) {
        throw Exception('Invalid note data. Missing city or document fields.');
      }

      if (note['id'] == null) {
        final docRef = await _notesCollection.add({
          'city': note['city'],
          'document': note['document'],
          'uid': userUid,
        });
        note['id'] = docRef.id;
      } else {
        await _notesCollection.doc(note['id']).update({
          'city': note['city'],
          'document': note['document'],
          'uid': userUid,
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error saving note: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    try {
      final userUid = await UserService().getCurrentUserUid();
      if (userUid == null) {
        throw Exception('User not logged in');
      }

      final snapshot =
          await _notesCollection.where('uid', isEqualTo: userUid).get();

      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'city': doc['city'],
          'document': doc['document'],
        };
      }).toList();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error fetching notes: $e');
      return [];
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await _notesCollection.doc(noteId).delete();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error deleting note: $e');
    }
  }
}
