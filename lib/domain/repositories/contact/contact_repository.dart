import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/contact/contact_entity.dart';

abstract class ContactRepository {
  Future<Either<Failure, List<ContactEntity>>> getContact();
}
