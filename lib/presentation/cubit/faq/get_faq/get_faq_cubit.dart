import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/faq/faq_entity.dart';
import '../../../../domain/usecases/faq/get_faq_usecase.dart';

part 'get_faq_state.dart';

class GetFaqCubit extends Cubit<GetFaqState> {
  final GetFaqUsecase getFaqUsecase;

  GetFaqCubit({
    required this.getFaqUsecase,
  }) : super(const GetFaqInitial());

  Future<void> getData({String? search}) async {
    emit(const GetFaqLoading());

    final data = await getFaqUsecase.call(NoParams());

    data.fold(
      (l) => emit(GetFaqNotLoaded(message: l.message!)),
      (r) {
        List<FaqEntity> filteredFaq = r;
        if (search != null && search.isNotEmpty) {
          filteredFaq = r
              .where(
                (faq) =>
                    faq.question!
                        .toLowerCase()
                        .contains(search.toLowerCase()) ||
                    faq.answer!.toLowerCase().contains(search.toLowerCase()),
              )
              .toList();
        }
        emit(GetFaqLoaded(data: filteredFaq));
      },
    );
  }
}
