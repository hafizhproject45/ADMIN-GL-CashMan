import 'package:dartz/dartz.dart';

import '../../entities/contact/contact_update_entity.dart';
import '../../repositories/contact/contact_repository.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';

class UpdateContactUsecase implements UseCase<void, ContactUpdateEntity> {
  final ContactRepository contactRepository;

  UpdateContactUsecase({
    required this.contactRepository,
  });

  @override
  Future<Either<Failure, void>> call(ContactUpdateEntity request) async {
    final result = await contactRepository.updateContact(request);

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
