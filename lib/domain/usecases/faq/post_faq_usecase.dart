import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/faq/faq_entity.dart';
import '../../repositories/faq/faq_repository.dart';

class PostFaqUsecase implements UseCase<void, FaqEntity> {
  final FaqRepository faqRepository;

  PostFaqUsecase({
    required this.faqRepository,
  });

  @override
  Future<Either<Failure, void>> call(FaqEntity request) async {
    final requestFaq = FaqEntity(
      question: request.question,
      answer: request.answer,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    final result = await faqRepository.postFaq(requestFaq);

    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
