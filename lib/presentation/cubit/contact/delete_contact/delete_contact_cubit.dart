import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/usecases/contact/delete_contact_usecase.dart';

part 'delete_contact_state.dart';

class DeleteContactCubit extends Cubit<DeleteContactState> {
  final DeleteContactUsecase deleteContactUsecase;

  DeleteContactCubit({
    required this.deleteContactUsecase,
  }) : super(DeleteContactInitial());

  Future<void> delete(int phoneId) async {
    emit(DeleteContactLoading());

    final result = await deleteContactUsecase.call(phoneId);

    result.fold(
      (l) => emit(DeleteContactFailed(message: l.message!)),
      (r) => emit(DeleteContactSuccess()),
    );
  }
}
