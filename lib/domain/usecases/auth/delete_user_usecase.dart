import '../../entities/auth/delete_request_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/auth/auth_repository.dart';

class DeleteUserUsecase implements UseCase<void, DeleteRequestEntity> {
  final AuthRepository authRepository;

  DeleteUserUsecase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, void>> call(DeleteRequestEntity params) async {
    final result = await authRepository.deleteUser(params);

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
