// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FaqEntity extends Equatable {
  final int? id;
  final String? question;
  final String? answer;
  final String? createdAt;
  final String? updatedAt;

  const FaqEntity({
    this.id,
    this.question,
    this.answer,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  List<Object?> get props => [id, question, answer, createdAt, updatedAt];
}
