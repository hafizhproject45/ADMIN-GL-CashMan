import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../core/utils/text_style.dart';

class QuestionContainerWidget extends StatelessWidget {
  final String question;
  final String answer;
  final int id;

  const QuestionContainerWidget({
    required this.question,
    required this.answer,
    required this.id,
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
          onTap: () => Get.toNamed('/faq-detail/$id', arguments: id),
          child: ListTile(
            leading: const Icon(Icons.question_answer),
            subtitle: Text(
              answer,
              style: AppTextStyle.medium,
              textAlign: TextAlign.start,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question,
                  style: AppTextStyle.body,
                  textAlign: TextAlign.start,
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
