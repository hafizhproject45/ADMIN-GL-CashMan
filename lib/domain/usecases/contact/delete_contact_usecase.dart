import 'package:dartz/dartz.dart';

import '../../repositories/contact/contact_repository.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';

class DeleteContactUsecase implements UseCase<void, int> {
  final ContactRepository contactRepository;

  DeleteContactUsecase({
    required this.contactRepository,
  });

  @override
  Future<Either<Failure, void>> call(int phoneId) async {
    final result = await contactRepository.deleteContact(phoneId);

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
