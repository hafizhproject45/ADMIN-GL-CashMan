// ignore_for_file: annotate_overrides, overridden_fields

part of 'update_user_cubit.dart';

abstract class UpdateUserState extends Equatable {
  final String? message;

  const UpdateUserState({this.message});

  @override
  List<Object?> get props => [message];
}

final class UpdateUserInitial extends UpdateUserState {}

final class UpdateUserLoading extends UpdateUserState {}

final class UpdateUserSuccess extends UpdateUserState {}

final class UpdateUserFailed extends UpdateUserState {
  final String message;

  const UpdateUserFailed({required this.message}) : super(message: message);

  @override
  List<Object> get props => [message];
}
