import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/auth/login_request_entity.dart';
import '../../repositories/auth/auth_repository.dart';

class LoginUsecase implements UseCase<void, LoginRequestEntity> {
  final AuthRepository authRepository;

  LoginUsecase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, void>> call(LoginRequestEntity params) async {
    final result = await authRepository.login(params);

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
