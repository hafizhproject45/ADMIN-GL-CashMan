class UserModel {
  final String? id;
  final String? fullname;
  final String? block;
  final String? contact;
  final String? email;
  final String? createdAt;
  final String? updateAt;

  UserModel({
    this.id,
    this.fullname,
    this.block,
    this.contact,
    this.email,
    this.createdAt,
    this.updateAt,
  });

  static UserModel fromSnapshot(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullname: json['fullname'],
      block: json['block'],
      contact: json['contact'],
      email: json['email'],
      createdAt: json['createdAt'],
      updateAt: json['updateAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fullname": fullname,
      "block": block,
      "contact": contact,
      "email": email,
      "createdAt": createdAt,
      "updateAt": updateAt,
    };
  }
}
