// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UpdateContactEntity extends Equatable {
  final int? id;
  final String name;
  final String position;
  final String phone;
  final String createdAt;
  final String? updatedAt;

  const UpdateContactEntity({
    this.id,
    required this.name,
    required this.position,
    required this.phone,
    required this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'phone': phone,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      position,
      phone,
      createdAt,
      updatedAt,
    ];
  }
}
