import 'package:equatable/equatable.dart';

class UpdateRequestEntity extends Equatable {
  final int? id;
  final String fullname;
  final String block;
  final String phone;
  final String? updatedAt;

  const UpdateRequestEntity({
    this.id,
    required this.fullname,
    required this.block,
    required this.phone,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'block': block,
      'phone': phone,
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
      updatedAt,
    ];
  }
}
