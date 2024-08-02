import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/faq/faq_entity.dart';
import '../../entities/faq/faq_update_entity.dart';

abstract class FaqRepository {
  Future<Either<Failure, List<FaqEntity>>> getFaq();
  Future<Either<Failure, void>> postFaq(FaqEntity request);
  Future<Either<Failure, void>> updateFaq(FaqUpdateEntity request);
  Future<Either<Failure, void>> deleteFaq(int faqId);
}
