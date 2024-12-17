import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import '/screens/payment_page.dart';
import '/services/location_services.dart';
import '/utils/constants.dart';
import '/widgets/quill_toolbar.dart';
import '/services/notes_services.dart';
import '/widgets/background.dart';
import '/widgets/city_info_widget.dart';
import '/models/saved_notes.dart';
import '/utils/dialogs.dart';
import '/services/user_services.dart';

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
  final UserService _userService = UserService();
  bool isSubscriptionActive = false;

  @override
  void initState() {
    super.initState();
    _getCurrentCity();
    _loadUserNotes();
    _checkSubscriptionStatus();
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

  Future<void> _checkSubscriptionStatus() async {
    final userId = await _userService.getCurrentUserUid();
    if (userId != null) {
      final userData = await _userService.getUserData(userId);
      if (userData != null) {
        setState(() {
          isSubscriptionActive = userData['subscriptionStatus'] ?? false;
        });
      }
    }
  }

  Future<void> _saveNote() async {
    if (_controller.document.isEmpty()) {
      showToast('Note is empty. Please write something.');
      return;
    }

    int maxNotesAllowed = isSubscriptionActive ? 999999 : maxFreeNotes;

    if (notes.length >= maxNotesAllowed && !isSubscriptionActive) {
      final shouldUpgrade = await showUpgradeDialog(
        context,
        onPayPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PaymentPage()),
          );

          if (result == true) {
            await _checkSubscriptionStatus();
            await _saveNoteAfterPayment();
          }
        },
      );

      if (shouldUpgrade == false) {
        return;
      }
    } else {
      await _saveNoteAfterPayment();
    }
  }

  Future<void> _saveNoteAfterPayment() async {
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
    showToast('Note saved successfully!');
  }

  Future<void> _confirmDeleteNote(
      int index, BuildContext bottomSheetContext) async {
    final noteId = notes[index]['id'];
    if (noteId == null) {
      showToast('Error: Note ID is null');
      return;
    }

    bool? confirmDelete = await confirmDeleteNoteDialog(bottomSheetContext);

    if (confirmDelete == true) {
      setState(() {
        notes.removeAt(index);
      });

      try {
        await _notesService.deleteNote(noteId);
        showToast('Note deleted!');
        Navigator.pop(bottomSheetContext);
        _showSavedNotes();
      } catch (e) {
        showToast('Error deleting note from Firestore: $e');
      }
    }
  }

  void _showSavedNotes() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (bottomSheetContext) {
        return SavedNotes(
          notes: notes,
          onDeleteNote: (index) {
            _confirmDeleteNote(index, bottomSheetContext);
          },
        );
      },
    );
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
              CityInfoWidget(cityName: _cityName),
              const SizedBox(height: 16),
              Container(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 91, 91, 91), width: 1.5),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: QuillToolbarWidget(controller: _controller),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 91, 91, 91),
                        width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
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
