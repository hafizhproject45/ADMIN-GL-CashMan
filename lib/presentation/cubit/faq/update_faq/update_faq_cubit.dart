import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/faq/faq_update_entity.dart';
import '../../../../domain/usecases/faq/update_faq_usecase.dart';

part 'update_faq_state.dart';

class UpdateFaqCubit extends Cubit<UpdateFaqState> {
  final UpdateFaqUsecase updateFaqUsecase;

  UpdateFaqCubit({
    required this.updateFaqUsecase,
  }) : super(UpdateFaqInitial());

  Future<void> payment(FaqUpdateEntity request) async {
    emit(UpdateFaqLoading());

    final result = await updateFaqUsecase.call(request);

    result.fold(
      (l) => emit(UpdateFaqFailed(message: l.message!)),
      (r) => emit(UpdateFaqSuccess()),
    );
  }
}
