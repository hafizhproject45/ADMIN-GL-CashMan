import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/payment/payment_entity.dart';

abstract class PaymentRepository {
  Future<Either<Failure, void>> payment(PaymentEntity request, String name);
  Future<Either<Failure, List<PaymentEntity>>> getAllPayment(
      {int? userId, String? select});
  Future<Either<Failure, PaymentEntity>> getSinglePayment(int paymentId,
      {String? select});
  Future<Either<Failure, List<PaymentEntity>>> getPaymentToday(
      {String? select});
  Future<Either<Failure, void>> deletePayment(int paymentId, String imageName);
}
