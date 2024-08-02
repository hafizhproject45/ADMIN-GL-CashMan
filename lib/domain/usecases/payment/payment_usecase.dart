// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../core/params/payment/payment_params.dart';
import '../../entities/payment/payment_entity.dart';
import '../../repositories/auth/auth_repository.dart';
import '../../repositories/payment/payment_repository.dart';

class PaymentUsecase implements UseCase<void, PaymentParams> {
  final PaymentRepository paymentRepository;
  final AuthRepository authRepository;

  PaymentUsecase({
    required this.paymentRepository,
    required this.authRepository,
  });

  @override
  Future<Either<Failure, void>> call(PaymentParams params) async {
    final getId = await authRepository.getUserID();

    late int userID;

    getId.fold(
      (l) => l,
      (r) => userID = r,
    );

    final newPayment = PaymentEntity(
      userId: userID,
      paymentDate: params.paymentEntity.paymentDate,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    final result = await paymentRepository.payment(
      newPayment,
      '${params.payerName}-${params.block}',
    );

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
