class PaymentModel {
  final String? id;
  final String? paymentFrom;
  final String? email;
  final String? month;
  final String? year;
  final String? imageUrl;
  final String? createdAt;

  PaymentModel({
    this.id,
    this.paymentFrom,
    this.email,
    this.month,
    this.year,
    this.imageUrl,
    this.createdAt,
  });

  static PaymentModel fromSnapshot(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      paymentFrom: json['paymentFrom'],
      email: json['email'],
      month: json['month'],
      year: json['year'],
      imageUrl: json['imageUrl'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "paymentFrom": paymentFrom,
      "email": email,
      "month": month,
      "year": year,
      "imageUrl": imageUrl,
      "createdAt": createdAt,
    };
  }
}
