// ignore_for_file: annotate_overrides, overridden_fields

part of 'update_contact_cubit.dart';

abstract class UpdateContactState extends Equatable {
  final String? message;

  const UpdateContactState({this.message});

  @override
  List<Object?> get props => [message];
}

final class UpdateContactInitial extends UpdateContactState {}

final class UpdateContactLoading extends UpdateContactState {}

final class UpdateContactSuccess extends UpdateContactState {}

final class UpdateContactFailed extends UpdateContactState {
  final String message;

  const UpdateContactFailed({required this.message}) : super(message: message);

  @override
  List<Object> get props => [message];
}
