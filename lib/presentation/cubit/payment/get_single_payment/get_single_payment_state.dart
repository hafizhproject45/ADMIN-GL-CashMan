// ignore_for_file: overridden_fields, annotate_overrides

part of 'get_single_payment_cubit.dart';

abstract class GetSinglePaymentState extends Equatable {
  final String? message;

  const GetSinglePaymentState(this.message);

  @override
  List<Object?> get props => [message];
}

class GetSinglePaymentInitial extends GetSinglePaymentState {
  const GetSinglePaymentInitial() : super(null);
}

class GetSinglePaymentLoading extends GetSinglePaymentState {
  const GetSinglePaymentLoading() : super(null);
}

class GetSinglePaymentLoaded extends GetSinglePaymentState {
  final PaymentEntity? data;

  const GetSinglePaymentLoaded({
    required this.data,
  }) : super(null);

  @override
  List<Object?> get props => [data, message];
}

class GetSinglePaymentNotLoaded extends GetSinglePaymentState {
  final String message;

  const GetSinglePaymentNotLoaded({
    required this.message,
  }) : super(message);

  @override
  List<Object?> get props => [message];
}
