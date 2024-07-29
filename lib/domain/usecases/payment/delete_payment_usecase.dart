import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/payment/payment_repository.dart';

class DeletePaymentUsecase implements UseCase<void, int> {
  final PaymentRepository paymentRepository;

  DeletePaymentUsecase({
    required this.paymentRepository,
  });

  @override
  Future<Either<Failure, void>> call(int params) async {
    final getimageName = await paymentRepository.getSinglePayment(params);

    late String imageName;

    getimageName.fold(
      (l) => Left(l),
      (r) => Right(imageName = r.imageName!),
    );

    final result = await paymentRepository.deletePayment(params, imageName);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
