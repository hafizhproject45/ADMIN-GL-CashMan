import 'package:dartz/dartz.dart';

import '../../entities/contact/contact_entity.dart';
import '../../repositories/contact/contact_repository.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';

class PostContactUsecase implements UseCase<void, ContactEntity> {
  final ContactRepository contactRepository;

  PostContactUsecase({
    required this.contactRepository,
  });

  @override
  Future<Either<Failure, void>> call(ContactEntity request) async {
    final newContact = ContactEntity(
      name: request.name,
      phone: request.phone,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    final result = await contactRepository.postContact(newContact);

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
