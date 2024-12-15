import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class NoteCardWidget extends StatelessWidget {
  final Map<String, dynamic> note;
  final VoidCallback onDelete;

  const NoteCardWidget({
    Key? key,
    required this.note,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final documentJson = note['document'];

    final quillController = quill.QuillController(
      document: documentJson is quill.Document
          ? documentJson
          : quill.Document.fromJson(documentJson),
      selection: TextSelection.collapsed(offset: 0),
    );

    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'City: ${note['city']}',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 80,
              child: quill.QuillEditor.basic(
                controller: quillController,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
