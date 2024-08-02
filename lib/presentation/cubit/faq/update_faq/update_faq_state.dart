// ignore_for_file: annotate_overrides, overridden_fields

part of 'update_faq_cubit.dart';

abstract class UpdateFaqState extends Equatable {
  final String? message;

  const UpdateFaqState({this.message});

  @override
  List<Object?> get props => [message];
}

final class UpdateFaqInitial extends UpdateFaqState {}

final class UpdateFaqLoading extends UpdateFaqState {}

final class UpdateFaqSuccess extends UpdateFaqState {}

final class UpdateFaqFailed extends UpdateFaqState {
  final String message;

  const UpdateFaqFailed({required this.message}) : super(message: message);

  @override
  List<Object> get props => [message];
}
