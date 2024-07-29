// ignore_for_file: overridden_fields, annotate_overrides

part of 'get_payment_today_cubit.dart';

abstract class GetPaymentTodayState extends Equatable {
  final String? message;

  const GetPaymentTodayState(this.message);

  @override
  List<Object?> get props => [message];
}

class GetPaymentTodayInitial extends GetPaymentTodayState {
  const GetPaymentTodayInitial() : super(null);
}

class GetPaymentTodayLoading extends GetPaymentTodayState {
  const GetPaymentTodayLoading() : super(null);
}

class GetPaymentTodayLoaded extends GetPaymentTodayState {
  final List<PaymentEntity>? data;

  const GetPaymentTodayLoaded({
    required this.data,
  }) : super(null);

  @override
  List<Object?> get props => [data, message];
}

class GetPaymentTodayNotLoaded extends GetPaymentTodayState {
  final String message;

  const GetPaymentTodayNotLoaded({
    required this.message,
  }) : super(message);

  @override
  List<Object?> get props => [message];
}
