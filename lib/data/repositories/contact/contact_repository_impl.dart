import 'package:dartz/dartz.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../core/utils/constants.dart';
import '../../../domain/entities/contact/contact_entity.dart';
import '../../../domain/entities/contact/contact_update_entity.dart';
import '../../../domain/repositories/contact/contact_repository.dart';
import '../../datasources/contact/contact_datasource.dart';

class ContactRepositoryImpl extends ContactRepository {
  final ContactDatasource contactDatasource;

  ContactRepositoryImpl({
    required this.contactDatasource,
  });

  @override
  Future<Either<Failure, List<ContactEntity>>> getContact() async {
    try {
      final res = await contactDatasource.getContact();
      return Right(res);
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<Either<Failure, void>> postContact(ContactEntity request) async {
    try {
      final res = await contactDatasource.postContact(request);
      return Right(res);
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<Either<Failure, void>> updateContact(
      ContactUpdateEntity request) async {
    try {
      final res = await contactDatasource.updateContact(request);
      return Right(res);
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<Either<Failure, void>> deleteContact(int phoneId) async {
    try {
      final res = await contactDatasource.deleteContact(phoneId);
      return Right(res);
    } catch (e) {
      return _handleException(e);
    }
  }

  _handleException(Object e) {
    if (e is ServerException) {
      return Left(ServerFailure(message: e.message));
    } else {
      return const Left(UnknownFailure(message: FAILURE_UNKNOWN));
    }
  }
}
