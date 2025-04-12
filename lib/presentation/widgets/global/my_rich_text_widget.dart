import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../core/utils/text_style.dart';

class MyRichTextWidget extends StatelessWidget {
  const MyRichTextWidget({
    super.key,
    required controller,
    required this.title,
    required this.hint,
  }) : _controller = controller;

  final String title;
  final String hint;
  final QuillController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: QuillSimpleToolbar(
            controller: _controller,
            configurations: const QuillSimpleToolbarConfigurations(
              showListCheck: false,
              showFontFamily: false,
              showColorButton: false,
              showBackgroundColorButton: false,
              showLink: false,
              showHeaderStyle: false,
              showFontSize: false,
              showCodeBlock: false,
              showInlineCode: false,
              showIndent: false,
              showDividers: false,
              showSearchButton: false,
              showListNumbers: false,
              showListBullets: false,
              showSubscript: false,
              showSuperscript: false,
              showQuote: false,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Text(
          title,
          style: AppTextStyle.bodyBold,
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade400),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: QuillEditor.basic(
            controller: _controller,
            configurations: QuillEditorConfigurations(
              placeholder: hint,
            ),
          ),
        )
      ],
    );
  }
}
