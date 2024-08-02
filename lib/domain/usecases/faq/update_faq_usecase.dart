import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/faq/faq_update_entity.dart';
import '../../repositories/faq/faq_repository.dart';

class UpdateFaqUsecase implements UseCase<void, FaqUpdateEntity> {
  final FaqRepository faqRepository;

  UpdateFaqUsecase({
    required this.faqRepository,
  });

  @override
  Future<Either<Failure, void>> call(FaqUpdateEntity request) async {
    final result = await faqRepository.updateFaq(request);

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
