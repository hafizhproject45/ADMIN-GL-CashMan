import 'package:equatable/equatable.dart';

class UpdateUserRequestEntity extends Equatable {
  final int? id;
  final String fullname;
  final String block;
  final String phone;
  final String createdAt;
  final String? updatedAt;

  const UpdateUserRequestEntity({
    this.id,
    required this.fullname,
    required this.block,
    required this.phone,
    required this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'block': block,
      'phone': phone,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  List<Object?> get props {
    return [
      id,
      fullname,
      block,
      phone,
      createdAt,
      updatedAt,
    ];
  }
}
