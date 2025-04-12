import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/contact/contact_update_entity.dart';
import '../../repositories/contact/contact_repository.dart';

class UpdateContactUsecase implements UseCase<void, UpdateContactEntity> {
  final ContactRepository contactRepository;

  UpdateContactUsecase({
    required this.contactRepository,
  });

  @override
  Future<Either<Failure, void>> call(UpdateContactEntity request) async {
    final updateRequest = UpdateContactEntity(
      name: request.name,
      position: request.position,
      phone: request.phone,
      createdAt: request.createdAt,
      updatedAt: DateTime.now().toIso8601String(),
    );

    final result = await contactRepository.updateContact(updateRequest);

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
