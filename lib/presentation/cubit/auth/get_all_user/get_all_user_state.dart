// ignore_for_file: annotate_overrides, overridden_fields

part of 'get_all_user_cubit.dart';

abstract class GetAllUserState extends Equatable {
  final String? message;

  const GetAllUserState(this.message);

  @override
  List<Object?> get props => [message];
}

class GetAllUserInitial extends GetAllUserState {
  const GetAllUserInitial() : super(null);
}

class GetAllUserLoading extends GetAllUserState {
  const GetAllUserLoading() : super(null);
}

class GetAllUserLoaded extends GetAllUserState {
  final List<UserEntity>? data;

  const GetAllUserLoaded({
    required this.data,
  }) : super(null);

  @override
  List<Object?> get props => [data, message];
}

class GetAllUserNotLoaded extends GetAllUserState {
  final String message;

  const GetAllUserNotLoaded({
    required this.message,
  }) : super(message);

  @override
  List<Object?> get props => [message];
}
