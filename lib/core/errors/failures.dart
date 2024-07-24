// ignore_for_file: annotate_overrides, overridden_fields

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  final String? message;

  const Failure({
    this.properties = const <dynamic>[],
    this.message,
  });

  @override
  List<Object?> get props => [properties, message];
}

// General failures
class ServerFailure extends Failure {
  final String? message;

  const ServerFailure({this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  final String? message;

  const CacheFailure({this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class ProcessFailure extends Failure {
  final String? message;

  const ProcessFailure({this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class UnknownFailure extends Failure {
  final String? message;

  const UnknownFailure({this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class NotFoundFailure extends Failure {
  final String? message;

  const NotFoundFailure({this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class LoginFailure extends Failure {
  final String? message;

  const LoginFailure({this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class RegisterFailure extends Failure {
  final String? message;

  const RegisterFailure({this.message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}
