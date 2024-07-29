// ignore_for_file: overridden_fields, annotate_overrides

part of 'get_single_user_cubit.dart';

abstract class GetSingleUserState extends Equatable {
  final String? message;

  const GetSingleUserState(this.message);

  @override
  List<Object?> get props => [message];
}

class GetSingleUserInitial extends GetSingleUserState {
  const GetSingleUserInitial() : super(null);
}

class GetSingleUserLoading extends GetSingleUserState {
  const GetSingleUserLoading() : super(null);
}

class GetSingleUserLoaded extends GetSingleUserState {
  final UserEntity? data;

  const GetSingleUserLoaded({
    required this.data,
  }) : super(null);

  @override
  List<Object?> get props => [data, message];
}

class GetSingleUserNotLoaded extends GetSingleUserState {
  final String message;

  const GetSingleUserNotLoaded({
    required this.message,
  }) : super(message);

  @override
  List<Object?> get props => [message];
}
