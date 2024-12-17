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
      selection: const TextSelection.collapsed(offset: 0),
    );

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(
          color: Color.fromARGB(255, 91, 91, 91),
          width: 2.0,
        ),
      ),
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
              child: quill.QuillEditor.basic(
                controller: quillController,
                configurations: const quill.QuillEditorConfigurations(
                  scrollable: true,
                  autoFocus: false,
                  showCursor: false,
                  expands: false,
                  padding: EdgeInsets.zero,
                  sharedConfigurations: quill.QuillSharedConfigurations(
                    locale: Locale('en'),
                  ),
                ),
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
