// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/auth/user_entity.dart';
import '../../repositories/auth/auth_repository.dart';

class GetSingleUserUsecase implements UseCase<UserEntity, GetSingleUserParams> {
  final AuthRepository authRepository;

  GetSingleUserUsecase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, UserEntity>> call(GetSingleUserParams params) async {
    final result = await authRepository.getSingleUser(
      params.userId,
      select: params.select,
    );

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}

class GetSingleUserParams {
  final int userId;
  final String? select;

  GetSingleUserParams({
    required this.userId,
    this.select = '*',
  });
}
