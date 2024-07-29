import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/auth/user_entity.dart';
import '../../repositories/auth/auth_repository.dart';

class GetAllUserUsecase implements UseCase<List<UserEntity>, NoParams> {
  final AuthRepository authRepository;

  GetAllUserUsecase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams params) async {
    final result = await authRepository.getAllUser();

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
