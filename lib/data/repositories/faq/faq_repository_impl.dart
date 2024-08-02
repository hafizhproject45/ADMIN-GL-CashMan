import 'package:dartz/dartz.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../core/utils/constants.dart';
import '../../../domain/entities/faq/faq_entity.dart';
import '../../../domain/entities/faq/faq_update_entity.dart';
import '../../../domain/repositories/faq/faq_repository.dart';
import '../../datasources/faq/faq_datasource.dart';

class FaqRepositoryImpl extends FaqRepository {
  final FaqDatasource faqDatasource;

  FaqRepositoryImpl({
    required this.faqDatasource,
  });

  @override
  Future<Either<Failure, List<FaqEntity>>> getFaq() async {
    try {
      final res = await faqDatasource.getFaq();
      return Right(res);
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<Either<Failure, void>> postFaq(FaqEntity request) async {
    try {
      final res = await faqDatasource.postFaq(request);
      return Right(res);
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<Either<Failure, void>> updateFaq(FaqUpdateEntity request) async {
    try {
      final res = await faqDatasource.updateFaq(request);
      return Right(res);
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<Either<Failure, void>> deleteFaq(int faqId) async {
    try {
      final res = await faqDatasource.deleteFaq(faqId);
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
