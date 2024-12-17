import 'package:flutter/material.dart';
import '/widgets/note_card.dart';

class SavedNotes extends StatelessWidget {
  final List<Map<String, dynamic>> notes;
  final Function(int) onDeleteNote;

  const SavedNotes({
    super.key,
    required this.notes,
    required this.onDeleteNote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 75, 177, 246),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: FractionallySizedBox(
        heightFactor: 0.8,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 91, 91, 91),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Saved Notes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              notes.isEmpty
                  ? const Center(
                      child: Text(
                        "No saved notes",
                        style: TextStyle(color: Colors.black54),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          return NoteCardWidget(
                            note: notes[index],
                            onDelete: () => onDeleteNote(index),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
