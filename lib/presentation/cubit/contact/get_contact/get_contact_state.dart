// ignore_for_file: overridden_fields, annotate_overrides

part of 'get_contact_cubit.dart';

abstract class GetContactState extends Equatable {
  final String? message;

  const GetContactState(this.message);

  @override
  List<Object?> get props => [message];
}

class GetContactInitial extends GetContactState {
  const GetContactInitial() : super(null);
}

class GetContactLoading extends GetContactState {
  const GetContactLoading() : super(null);
}

class GetContactLoaded extends GetContactState {
  final List<ContactEntity>? data;

  const GetContactLoaded({
    required this.data,
  }) : super(null);

  @override
  List<Object?> get props => [data, message];
}

class GetContactNotLoaded extends GetContactState {
  final String message;

  const GetContactNotLoaded({
    required this.message,
  }) : super(message);

  @override
  List<Object?> get props => [message];
}
