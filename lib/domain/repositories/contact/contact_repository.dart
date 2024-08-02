import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/contact/contact_entity.dart';
import '../../entities/contact/contact_update_entity.dart';

abstract class ContactRepository {
  Future<Either<Failure, List<ContactEntity>>> getContact();
  Future<Either<Failure, void>> postContact(ContactEntity request);
  Future<Either<Failure, void>> updateContact(ContactUpdateEntity request);
  Future<Either<Failure, void>> deleteContact(int phoneId);
}
