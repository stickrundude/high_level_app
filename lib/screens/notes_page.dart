import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:fluttertoast/fluttertoast.dart';
import '/widgets/quill_toolbar.dart';
import '/widgets/note_card.dart';
import '/services/location_services.dart';
import '/services/notes_services.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final quill.QuillController _controller = quill.QuillController.basic();
  List<Map<String, dynamic>> notes = [];
  String? _cityName;
  final NotesService _notesService = NotesService();

  @override
  void initState() {
    super.initState();
    _getCurrentCity();
    _loadUserNotes();
  }

  Future<void> _getCurrentCity() async {
    String? city = await getCurrentCity();
    setState(() {
      _cityName = city ?? 'Unknown Location';
    });
  }

  Future<void> _loadUserNotes() async {
    var userNotes = await _notesService.getNotes();
    setState(() {
      notes = userNotes.map((noteData) {
        noteData['document'] = quill.Document.fromJson(noteData['document']);
        return noteData;
      }).toList();

      notes.sort((a, b) {
        var aTimestamp = a['createdAt'] ?? DateTime(0);
        var bTimestamp = b['createdAt'] ?? DateTime(0);
        return aTimestamp.compareTo(bTimestamp);
      });
    });
  }

  void _saveNote() async {
    if (_controller.document.isEmpty()) return;

    var timestamp = DateTime.now();

    setState(() {
      notes.add({
        'city': _cityName ?? 'Unknown Location',
        'document': _controller.document.toDelta().toJson(),
        'createdAt': timestamp,
      });

      _controller.clear();
    });

    await _notesService.saveNote(notes.last);
  }

  Future<void> _confirmDeleteNote(int index) async {
    final noteId = notes[index]['id'];
    if (noteId == null) {
      Fluttertoast.showToast(msg: 'Error: Note ID is null');
      return;
    }

    bool? confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    if (confirmDelete == true) {
      setState(() {
        notes.removeAt(index);
      });

      try {
        await _notesService.deleteNote(noteId);
        Fluttertoast.showToast(msg: 'Note deleted!');
      } catch (e) {
        Fluttertoast.showToast(msg: 'Error deleting note from Firestore: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                _cityName != null
                    ? "Notes are being stored in: $_cityName"
                    : "Fetching your city...",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            QuillToolbarWidget(controller: _controller),
            const SizedBox(height: 8),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: quill.QuillEditor.basic(
                  controller: _controller,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: ElevatedButton(
                onPressed: _saveNote,
                child: const Text('Save Note'),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Saved Notes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              flex: 4,
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return NoteCardWidget(
                    note: notes[index],
                    onDelete: () => _confirmDeleteNote(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
