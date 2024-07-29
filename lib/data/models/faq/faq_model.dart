import '../../../domain/entities/faq/faq_entity.dart';

class FaqModel extends FaqEntity {
  const FaqModel({
    super.id,
    super.question,
    super.answer,
    super.createdAt,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
      createdAt: json['created_at'],
    );
  }
}
