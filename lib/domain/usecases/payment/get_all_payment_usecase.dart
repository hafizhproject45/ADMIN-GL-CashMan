// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/payment/payment_entity.dart';
import '../../repositories/payment/payment_repository.dart';

class GetAllPaymentUsecase
    implements UseCase<List<PaymentEntity>, GetAllPaymentParams> {
  final PaymentRepository paymentRepository;

  GetAllPaymentUsecase({
    required this.paymentRepository,
  });

  @override
  Future<Either<Failure, List<PaymentEntity>>> call(
      GetAllPaymentParams params) async {
    final result = await paymentRepository.getAllPayment(
      userId: params.userId,
      select: params.select,
    );

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}

class GetAllPaymentParams {
  final int? userId;
  final String? select;

  GetAllPaymentParams({
    this.userId,
    this.select = '*',
  });
}
