// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class DeleteRequestEntity extends Equatable {
  final int userId;
  final String authId;

  const DeleteRequestEntity({
    required this.userId,
    required this.authId,
  });

  @override
  List<Object> get props => [userId, authId];
}
