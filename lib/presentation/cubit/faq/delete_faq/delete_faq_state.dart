// ignore_for_file: annotate_overrides, overridden_fields

part of 'delete_faq_cubit.dart';

abstract class DeleteFaqState extends Equatable {
  final String? message;

  const DeleteFaqState({this.message});

  @override
  List<Object?> get props => [message];
}

final class DeleteFaqInitial extends DeleteFaqState {}

final class DeleteFaqLoading extends DeleteFaqState {}

final class DeleteFaqSuccess extends DeleteFaqState {}

final class DeleteFaqFailed extends DeleteFaqState {
  final String message;

  const DeleteFaqFailed({required this.message}) : super(message: message);

  @override
  List<Object> get props => [message];
}
