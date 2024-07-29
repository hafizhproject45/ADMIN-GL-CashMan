// ignore_for_file: unrelated_type_equality_checks

import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/auth/auth_repository.dart';

class CheckLoginUsecase implements UseCase<bool, NoParams> {
  final AuthRepository authRepository;

  CheckLoginUsecase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, bool>> call(NoParams noParams) async {
    final result = await authRepository.checkLogin();

    final check =
        result == const Right(true) ? const Right(true) : const Right(false);

    return check.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
