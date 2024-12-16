import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:high_level_application/services/location_services.dart';
import '../widgets/quill_toolbar.dart';
import '../widgets/note_card.dart';
import '/services/notes_services.dart';
import '/widgets/background.dart';
import 'payment_page.dart';

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
  final int maxFreeNotes = 5;

  @override
  void initState() {
    super.initState();
    _getCurrentCity();
    _loadUserNotes();
  }

  Future<void> _getCurrentCity() async {
    String? city = await getCurrentCity();
    if (mounted) {
      setState(() {
        _cityName = city ?? 'Unknown Location';
      });
    }
  }

  Future<void> _loadUserNotes() async {
    var userNotes = await _notesService.getNotes();
    if (mounted) {
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
  }

  Future<void> _saveNote() async {
    if (_controller.document.isEmpty()) {
      Fluttertoast.showToast(msg: 'Note is empty. Please write something.');
      return;
    }

    if (notes.length >= maxFreeNotes) {
      _showUpgradeDialog();
      return;
    }

    var timestamp = DateTime.now();
    final newNote = {
      'city': _cityName ?? 'Unknown Location',
      'document': _controller.document.toDelta().toJson(),
      'createdAt': timestamp,
    };

    setState(() {
      notes = [...notes, newNote];
    });

    await _notesService.saveNote(newNote);
    _controller.clear();
    Fluttertoast.showToast(msg: 'Note saved successfully!');
  }

  void _showUpgradeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Upgrade Required"),
          content: const Text(
            "You have reached the free limit of 5 notes. To save more, please upgrade.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentPage(),
                  ),
                );
              },
              child: const Text("Pay"),
            ),
          ],
        );
      },
    );
  }

  void _showSavedNotes() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          color: Colors.blue.withOpacity(0.1),
          child: FractionallySizedBox(
            heightFactor: 0.8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Saved Notes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  notes.isEmpty
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 250),
                              Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    "No saved notes",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: notes.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                padding: const EdgeInsets.all(12.0),
                                child: NoteCardWidget(
                                  note: notes[index],
                                  onDelete: () => _confirmDeleteNote(index),
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
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

      Navigator.pop(context);

      _showSavedNotes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white.withOpacity(0.7),
                  ),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "Notes are being stored in: ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: _cityName ?? "Fetching your city...",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.5),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white.withOpacity(0.7),
                ),
                child: QuillToolbarWidget(controller: _controller),
              ),
              const SizedBox(height: 8),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white.withOpacity(0.7),
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
              Center(
                child: ElevatedButton(
                  onPressed: _showSavedNotes,
                  child: const Text('View Saved Notes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
