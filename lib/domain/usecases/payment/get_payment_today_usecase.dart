import 'package:dartz/dartz.dart';
import '../../entities/payment/payment_entity.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/payment/payment_repository.dart';

class GetPaymentTodayUsecase implements UseCase<List<PaymentEntity>, NoParams> {
  final PaymentRepository paymentRepository;

  GetPaymentTodayUsecase({
    required this.paymentRepository,
  });

  @override
  Future<Either<Failure, List<PaymentEntity>>> call(NoParams params) async {
    final result = await paymentRepository.getPaymentToday();

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
