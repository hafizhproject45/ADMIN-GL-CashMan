import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/contact/contact_entity.dart';
import '../../../../domain/usecases/contact/post_contact_usecase.dart';

part 'post_contact_state.dart';

class PostContactCubit extends Cubit<PostContactState> {
  final PostContactUsecase postContactUsecase;

  PostContactCubit({
    required this.postContactUsecase,
  }) : super(PostContactInitial());

  Future<void> post(ContactEntity request) async {
    emit(PostContactLoading());

    final result = await postContactUsecase.call(request);

    result.fold(
      (l) => emit(PostContactFailed(message: l.message!)),
      (r) => emit(PostContactSuccess()),
    );
  }
}
