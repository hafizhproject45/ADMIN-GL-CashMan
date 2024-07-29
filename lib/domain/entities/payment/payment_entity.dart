// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PaymentEntity extends Equatable {
  final int? id;
  final int? userId;
  final String? imageUrl;
  final String? imageName;
  final String? paymentDate;
  final String? createdAt;
  final String? updatedAt;

  const PaymentEntity({
    this.id,
    this.userId,
    this.imageUrl,
    this.imageName,
    this.paymentDate,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'image_url': imageUrl,
      'image_name': imageName,
      'payment_date': paymentDate,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      imageUrl,
      imageName,
      paymentDate,
      createdAt,
      updatedAt,
    ];
  }
}
