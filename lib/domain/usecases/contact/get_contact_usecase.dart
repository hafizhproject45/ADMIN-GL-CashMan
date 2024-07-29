import 'package:dartz/dartz.dart';

import '../../entities/contact/contact_entity.dart';
import '../../repositories/contact/contact_repository.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';

class GetContactUsecase implements UseCase<List<ContactEntity>, NoParams> {
  final ContactRepository contactRepository;

  GetContactUsecase({
    required this.contactRepository,
  });

  @override
  Future<Either<Failure, List<ContactEntity>>> call(NoParams noParams) async {
    final result = await contactRepository.getContact();

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
