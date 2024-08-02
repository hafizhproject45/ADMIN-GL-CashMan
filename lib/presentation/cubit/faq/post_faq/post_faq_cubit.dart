import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/faq/faq_entity.dart';
import '../../../../domain/usecases/faq/post_faq_usecase.dart';

part 'post_faq_state.dart';

class PostFaqCubit extends Cubit<PostFaqState> {
  final PostFaqUsecase postFaqUsecase;

  PostFaqCubit({
    required this.postFaqUsecase,
  }) : super(PostFaqInitial());

  Future<void> payment(FaqEntity request) async {
    emit(PostFaqLoading());

    final result = await postFaqUsecase.call(request);

    result.fold(
      (l) => emit(PostFaqFailed(message: l.message!)),
      (r) => emit(PostFaqSuccess()),
    );
  }
}
