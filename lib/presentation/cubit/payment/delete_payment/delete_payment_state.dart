// ignore_for_file: overridden_fields, annotate_overrides

part of 'delete_payment_cubit.dart';

abstract class DeletePaymentState extends Equatable {
  final String? message;

  const DeletePaymentState({this.message});

  @override
  List<Object?> get props => [message];
}

final class DeletePaymentInitial extends DeletePaymentState {}

final class DeletePaymentLoading extends DeletePaymentState {}

final class DeletePaymentSuccess extends DeletePaymentState {}

final class DeletePaymentFailed extends DeletePaymentState {
  final String message;

  const DeletePaymentFailed({required this.message}) : super(message: message);

  @override
  List<Object> get props => [message];
}
