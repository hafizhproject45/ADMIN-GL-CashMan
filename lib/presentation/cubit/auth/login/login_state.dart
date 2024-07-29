// ignore_for_file: overridden_fields, annotate_overrides

part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  final String? message;

  const LoginState({this.message});

  @override
  List<Object?> get props => [message];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginFailed extends LoginState {
  final String message;

  const LoginFailed({required this.message}) : super(message: message);
}

final class LoginLoggedIn extends LoginState {}

final class LoginLoggedOut extends LoginState {}
