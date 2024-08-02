// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ContactUpdateEntity extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final String? updatedAt;

  const ContactUpdateEntity({
    this.id,
    this.name,
    this.phone,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'updated_at': updatedAt,
    };
  }

  @override
  List<Object?> get props => [id, name, phone, updatedAt];
}
