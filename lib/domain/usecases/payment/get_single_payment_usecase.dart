import 'package:dartz/dartz.dart';
import '../../entities/payment/payment_entity.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/payment/payment_repository.dart';

class GetSinglePaymentUsecase implements UseCase<PaymentEntity, int> {
  final PaymentRepository paymentRepository;

  GetSinglePaymentUsecase({
    required this.paymentRepository,
  });

  @override
  Future<Either<Failure, PaymentEntity>> call(int params) async {
    final result = await paymentRepository.getSinglePayment(params);

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
