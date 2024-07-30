import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/auth/user_entity.dart';
import '../../repositories/auth/auth_repository.dart';

class GetAllUserUsecase implements UseCase<List<UserEntity>, String> {
  final AuthRepository authRepository;

  GetAllUserUsecase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, List<UserEntity>>> call(String select) async {
    final result = await authRepository.getAllUser(select: select);

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
