// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ContactEntity extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final String? createdAt;
  final String? updatedAt;

  const ContactEntity({
    this.id,
    this.name,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      phone,
      createdAt,
      updatedAt,
    ];
  }
}
