import '../../../domain/entities/contact/contact_entity.dart';

class ContactModel extends ContactEntity {
  const ContactModel({
    super.id,
    super.name,
    super.phone,
    super.createdAt,
    super.updatedAt,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
