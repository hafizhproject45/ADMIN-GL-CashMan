// ignore_for_file: overridden_fields, annotate_overrides

part of 'delete_user_cubit.dart';

abstract class DeleteUserState extends Equatable {
  final String? message;

  const DeleteUserState({this.message});

  @override
  List<Object?> get props => [message];
}

final class DeleteUserInitial extends DeleteUserState {}

final class DeleteUserLoading extends DeleteUserState {}

final class DeleteUserSuccess extends DeleteUserState {}

final class DeleteUserFailed extends DeleteUserState {
  final String message;

  const DeleteUserFailed({required this.message}) : super(message: message);

  @override
  List<Object> get props => [message];
}
