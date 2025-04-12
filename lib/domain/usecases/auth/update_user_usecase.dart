import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/auth/update_user_request_entity.dart';
import '../../repositories/auth/auth_repository.dart';

class UpdateUserUsecase implements UseCase<void, UpdateUserRequestEntity> {
  final AuthRepository authRepository;

  UpdateUserUsecase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, void>> call(UpdateUserRequestEntity params) async {
    final updateRequest = UpdateUserRequestEntity(
      id: params.id,
      fullname: params.fullname,
      block: params.block,
      phone: params.phone,
      createdAt: params.createdAt,
      updatedAt: DateTime.now().toIso8601String(),
    );

    final result = await authRepository.updateUser(updateRequest);

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
