import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../domain/entities/faq/faq_entity.dart';

class QuestionContainerWidget extends StatelessWidget {
  final FaqEntity entity;
  final String question;
  final String answer;

  const QuestionContainerWidget({
    required this.entity,
    required this.question,
    required this.answer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: InkWell(
          onTap: () =>
              Get.toNamed('/faq-detail/${entity.id}', arguments: entity),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRichTextFromJson(question),
                const Divider(),
              ],
            ),
            subtitle: _buildRichTextFromJson(answer),
            leading: const Icon(Icons.question_answer),
          ),
        ),
      ),
    );
  }

  Widget _buildRichTextFromJson(String jsonString) {
    List<dynamic> jsonList = jsonDecode(jsonString);
    List<Widget> widgets = [];

    bool isInOrderedList = false;

    for (var item in jsonList) {
      String text = item['insert'] ?? '';
      Map<String, dynamic>? attributes = item['attributes'];
      TextStyle textStyle = _getTextStyle(attributes);
      text.trim();

      // Remove trailing newline characters
      if (text.endsWith('\n')) {
        text = text.replaceFirst(RegExp(r'\n$'), '');
      }

      if (attributes != null) {
        if (attributes.containsKey('list') && attributes['list'] == 'ordered') {
          if (!isInOrderedList) {
            isInOrderedList = true;
          }
          widgets.add(Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              text,
              style: textStyle,
            ),
          ));
        } else {
          if (isInOrderedList) {
            isInOrderedList = false;
          }
          // Handle newlines within the text content
          widgets.addAll(_splitTextWithNewlines(text, textStyle));
        }
      } else {
        if (isInOrderedList) {
          isInOrderedList = false;
        }
        widgets.addAll(_splitTextWithNewlines(text, textStyle));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  List<Widget> _splitTextWithNewlines(String text, TextStyle textStyle) {
    // Split text by newlines and return a list of Text widgets
    return text.split('\n').map((line) {
      return Text(
        line,
        style: textStyle,
      );
    }).toList();
  }

  TextStyle _getTextStyle(Map<String, dynamic>? attributes) {
    TextStyle textStyle = const TextStyle();

    if (attributes != null) {
      if (attributes.containsKey('bold') && attributes['bold'] == true) {
        textStyle = textStyle.copyWith(fontWeight: FontWeight.bold);
      }
      if (attributes.containsKey('italic') && attributes['italic'] == true) {
        textStyle = textStyle.copyWith(fontStyle: FontStyle.italic);
      }
      if (attributes.containsKey('underline') &&
          attributes['underline'] == true) {
        textStyle = textStyle.copyWith(decoration: TextDecoration.underline);
      }
      if (attributes.containsKey('strike') && attributes['strike'] == true) {
        textStyle = textStyle.copyWith(decoration: TextDecoration.lineThrough);
      }
    }

    return textStyle;
  }
}
