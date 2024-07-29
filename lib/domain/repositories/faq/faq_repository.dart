import 'package:dartz/dartz.dart';
import '../../entities/faq/faq_entity.dart';

import '../../../core/errors/failures.dart';

abstract class FaqRepository {
  Future<Either<Failure, List<FaqEntity>>> getFaq();
}
