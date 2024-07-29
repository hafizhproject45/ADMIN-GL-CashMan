import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/auth/user_entity.dart';
import '../../repositories/auth/auth_repository.dart';

class GetSingleUserUsecase implements UseCase<UserEntity, int> {
  final AuthRepository authRepository;

  GetSingleUserUsecase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, UserEntity>> call(int userId) async {
    final result = await authRepository.getSingleUser(userId);

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
