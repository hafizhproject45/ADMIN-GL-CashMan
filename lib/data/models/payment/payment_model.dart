import '../../../domain/entities/payment/payment_entity.dart';

class PaymentModel extends PaymentEntity {
  const PaymentModel({
    required super.id,
    required super.userId,
    required super.imageUrl,
    required super.imageName,
    required super.imageSize,
    required super.paymentDate,
    required super.createdAt,
    required super.updatedAt,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      userId: json['user_id'],
      imageUrl: json['image_url'],
      imageName: json['image_name'],
      imageSize: json['image_size'],
      paymentDate: json['payment_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
