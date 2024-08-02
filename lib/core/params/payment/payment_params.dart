import 'package:equatable/equatable.dart';

import '../../../domain/entities/payment/payment_entity.dart';

class PaymentParams extends Equatable {
  final PaymentEntity paymentEntity;
  final String payerName;
  final String block;

  const PaymentParams({
    required this.paymentEntity,
    required this.payerName,
    required this.block,
  });

  @override
  List<Object> get props => [paymentEntity, payerName, block];
}
