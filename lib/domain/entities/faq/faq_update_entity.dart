// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FaqUpdateEntity extends Equatable {
  final int? id;
  final String? question;
  final String? answer;
  final String? updatedAt;

  const FaqUpdateEntity({
    this.id,
    this.question,
    this.answer,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
      'updated_at': updatedAt,
    };
  }

  @override
  List<Object?> get props => [id, question, answer, updatedAt];
}
