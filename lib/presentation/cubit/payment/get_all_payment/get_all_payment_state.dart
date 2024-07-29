// ignore_for_file: annotate_overrides, overridden_fields

part of 'get_all_payment_cubit.dart';

abstract class GetAllPaymentState extends Equatable {
  final String? message;

  const GetAllPaymentState(this.message);

  @override
  List<Object?> get props => [message];
}

class GetAllPaymentInitial extends GetAllPaymentState {
  const GetAllPaymentInitial() : super(null);
}

class GetAllPaymentLoading extends GetAllPaymentState {
  const GetAllPaymentLoading() : super(null);
}

class GetAllPaymentLoaded extends GetAllPaymentState {
  final List<PaymentEntity>? data;

  const GetAllPaymentLoaded({
    required this.data,
  }) : super(null);

  @override
  List<Object?> get props => [data, message];
}

class GetAllPaymentNotLoaded extends GetAllPaymentState {
  final String message;

  const GetAllPaymentNotLoaded({
    required this.message,
  }) : super(message);

  @override
  List<Object?> get props => [message];
}
