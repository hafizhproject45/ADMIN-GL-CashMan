// ignore_for_file: overridden_fields, annotate_overrides

part of 'payment_cubit.dart';

abstract class PaymentState extends Equatable {
  final String? message;

  const PaymentState({this.message});

  @override
  List<Object?> get props => [message];
}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class PaymentSuccess extends PaymentState {}

final class PaymentFailed extends PaymentState {
  final String message;

  const PaymentFailed({required this.message}) : super(message: message);

  @override
  List<Object> get props => [message];
}
