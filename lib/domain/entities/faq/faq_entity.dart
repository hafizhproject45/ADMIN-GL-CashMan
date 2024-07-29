// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FaqEntity extends Equatable {
  final int? id;
  final String? question;
  final String? answer;
  final String? createdAt;

  const FaqEntity({
    this.id,
    this.question,
    this.answer,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, question, answer, createdAt];
}
