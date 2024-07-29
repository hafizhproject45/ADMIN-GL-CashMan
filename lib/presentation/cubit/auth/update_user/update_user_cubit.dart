import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/auth/update_request_entity.dart';
import '../../../../domain/usecases/auth/update_user_usecase.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  final UpdateUserUsecase updateUserUsecase;

  UpdateUserCubit({
    required this.updateUserUsecase,
  }) : super(UpdateUserInitial());

  Future<void> update(UpdateRequestEntity request) async {
    emit(UpdateUserLoading());

    final data = await updateUserUsecase.call(request);

    data.fold(
      (l) => emit(UpdateUserFailed(message: l.message!)),
      (r) => emit(UpdateUserSuccess()),
    );
  }
}
