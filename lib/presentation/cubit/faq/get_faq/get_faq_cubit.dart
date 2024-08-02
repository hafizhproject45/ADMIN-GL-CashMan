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

  Future<void> getData() async {
    emit(const GetFaqLoading());

    final data = await getFaqUsecase.call(NoParams());

    data.fold(
      (l) => emit(GetFaqNotLoaded(message: l.message!)),
      (r) => emit(GetFaqLoaded(data: r)),
    );
  }
}
