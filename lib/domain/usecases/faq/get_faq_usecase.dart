import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/faq/faq_entity.dart';
import '../../repositories/faq/faq_repository.dart';

class GetFaqUsecase implements UseCase<List<FaqEntity>, NoParams> {
  final FaqRepository faqRepository;

  GetFaqUsecase({
    required this.faqRepository,
  });

  @override
  Future<Either<Failure, List<FaqEntity>>> call(NoParams noParams) async {
    final result = await faqRepository.getFaq();

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
