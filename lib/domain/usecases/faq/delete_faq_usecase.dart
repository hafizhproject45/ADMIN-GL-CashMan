import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/faq/faq_repository.dart';

class DeleteFaqUsecase implements UseCase<void, int> {
  final FaqRepository faqRepository;

  DeleteFaqUsecase({
    required this.faqRepository,
  });

  @override
  Future<Either<Failure, void>> call(int faqId) async {
    final result = await faqRepository.deleteFaq(faqId);

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
