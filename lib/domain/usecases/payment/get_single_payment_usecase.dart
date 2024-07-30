// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/payment/payment_entity.dart';
import '../../repositories/payment/payment_repository.dart';

class GetSinglePaymentUsecase
    implements UseCase<PaymentEntity, GetSinglePaymentParams> {
  final PaymentRepository paymentRepository;

  GetSinglePaymentUsecase({
    required this.paymentRepository,
  });

  @override
  Future<Either<Failure, PaymentEntity>> call(
      GetSinglePaymentParams params) async {
    final result = await paymentRepository.getSinglePayment(
      params.userId,
      select: params.select,
    );

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}

class GetSinglePaymentParams {
  final int userId;
  final String? select;

  GetSinglePaymentParams({
    required this.userId,
    this.select = '*',
  });
}
