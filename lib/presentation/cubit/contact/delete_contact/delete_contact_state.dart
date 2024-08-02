// ignore_for_file: annotate_overrides, overridden_fields

part of 'delete_contact_cubit.dart';

abstract class DeleteContactState extends Equatable {
  final String? message;

  const DeleteContactState({this.message});

  @override
  List<Object?> get props => [message];
}

final class DeleteContactInitial extends DeleteContactState {}

final class DeleteContactLoading extends DeleteContactState {}

final class DeleteContactSuccess extends DeleteContactState {}

final class DeleteContactFailed extends DeleteContactState {
  final String message;

  const DeleteContactFailed({required this.message}) : super(message: message);

  @override
  List<Object> get props => [message];
}
