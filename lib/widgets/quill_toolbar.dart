import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/flutter_quill.dart';

class QuillToolbarWidget extends StatelessWidget {
  final quill.QuillController controller;

  const QuillToolbarWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const config = QuillSimpleToolbarConfigurations(
      multiRowsDisplay: false,
      showDividers: false,
      showFontFamily: false,
      showUnderLineButton: false,
      showFontSize: false,
      showBoldButton: true,
      showItalicButton: true,
      showLineHeightButton: false,
      showStrikeThrough: false,
      showInlineCode: false,
      showColorButton: false,
      showBackgroundColorButton: false,
      showClearFormat: false,
      showAlignmentButtons: false,
      showHeaderStyle: false,
      showListNumbers: true,
      showListBullets: true,
      showListCheck: true,
      showCodeBlock: false,
      showQuote: false,
      showIndent: false,
      showLink: false,
      showUndo: true,
      showRedo: true,
      showDirection: false,
      showSearchButton: false,
      showSubscript: false,
      showSuperscript: false,
      showClipboardCut: false,
      showClipboardCopy: false,
      showClipboardPaste: false,
    );

    return quill.QuillToolbar.simple(
      controller: controller,
      configurations: config,
    );
  }
}
