import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/auth/delete_request_entity.dart';
import '../../../../domain/usecases/auth/delete_user_usecase.dart';

part 'delete_user_state.dart';

class DeleteUserCubit extends Cubit<DeleteUserState> {
  final DeleteUserUsecase deleteUserUsecase;

  DeleteUserCubit({
    required this.deleteUserUsecase,
  }) : super(DeleteUserInitial());

  Future<void> delete(int userId, String authId) async {
    emit(DeleteUserLoading());

    final deleteRequest = DeleteRequestEntity(userId: userId, authId: authId);

    final data = await deleteUserUsecase.call(deleteRequest);

    data.fold(
      (l) => emit(DeleteUserFailed(message: l.message!)),
      (r) => emit(DeleteUserSuccess()),
    );
  }
}
