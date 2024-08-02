import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/usecases/faq/delete_faq_usecase.dart';

part 'delete_faq_state.dart';

class DeleteFaqCubit extends Cubit<DeleteFaqState> {
  final DeleteFaqUsecase deleteFaqUsecase;

  DeleteFaqCubit({
    required this.deleteFaqUsecase,
  }) : super(DeleteFaqInitial());

  Future<void> payment(int faqId) async {
    emit(DeleteFaqLoading());

    final result = await deleteFaqUsecase.call(faqId);

    result.fold(
      (l) => emit(DeleteFaqFailed(message: l.message!)),
      (r) => emit(DeleteFaqSuccess()),
    );
  }
}
