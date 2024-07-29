import 'package:dartz/dartz.dart';

import '../../entities/auth/update_request_entity.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/auth/auth_repository.dart';

class UpdateUserUsecase implements UseCase<void, UpdateRequestEntity> {
  final AuthRepository authRepository;

  UpdateUserUsecase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, void>> call(UpdateRequestEntity params) async {
    final loginDataRequest = await authRepository.getUserID();

    late int userID;

    loginDataRequest.fold(
      (l) => Left(l),
      (r) => Right(userID = r),
    );

    final updateRequest = UpdateRequestEntity(
      id: userID,
      fullname: params.fullname,
      block: params.block,
      phone: params.phone,
      updatedAt: DateTime.now().toIso8601String(),
    );

    final result = await authRepository.updateUser(updateRequest);

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
