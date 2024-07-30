import '../../../domain/entities/auth/login_request_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase/supabase.dart' as sb;

import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../core/utils/constants.dart';
import '../../../domain/entities/auth/delete_request_entity.dart';
import '../../../domain/entities/auth/update_request_entity.dart';
import '../../../domain/entities/auth/user_entity.dart';
import '../../../domain/repositories/auth/auth_repository.dart';
import '../../datasources/user/auth_datasource.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({
    required this.authDataSource,
  });

  @override
  Future<Either<Failure, String>> getUserIDAuth() async {
    try {
      final data = await authDataSource.getUserIDAuth();

      return Right(data);
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<Either<Failure, int>> getUserID() async {
    try {
      final data = await authDataSource.getUserID();

      return Right(data);
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<Either<Failure, bool>> checkLogin() async {
    try {
      final data = await authDataSource.checkLogin();

      if (data) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<Either<Failure, void>> login(LoginRequestEntity request) async {
    try {
      final data = await authDataSource.login(request);
      return Right(data);
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final data = await authDataSource.logout();

      return Right(data);
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUser({String? select}) async {
    try {
      final data = await authDataSource.getAllUser(select: select);

      return Right(data);
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getSingleUser(int userId,
      {String? select}) async {
    try {
      final data = await authDataSource.getSingleUser(userId, select: select);

      return Right(data);
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(UpdateRequestEntity request) async {
    try {
      final data = await authDataSource.updateUser(request);

      return Right(data);
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(
    DeleteRequestEntity request,
  ) async {
    try {
      final data = await authDataSource.deleteUser(request);

      return Right(data);
    } catch (e) {
      return _handleException(e);
    }
  }

  _handleException(Object e) {
    if (e is sb.AuthException) {
      return Left(
        ServerFailure(
          message: e.message == 'Invalid login credentials'
              ? 'Account not found'
              : e.message,
        ),
      );
    } else if (e is ServerException) {
      return Left(ServerFailure(message: e.message));
    } else {
      return const Left(UnknownFailure(message: FAILURE_UNKNOWN));
    }
  }
}
