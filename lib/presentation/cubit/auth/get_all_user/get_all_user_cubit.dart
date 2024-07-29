import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../domain/usecases/auth/get_all_user_usecase.dart';
import '../../../../domain/entities/auth/user_entity.dart';

part 'get_all_user_state.dart';

class GetAllUserCubit extends Cubit<GetAllUserState> {
  final GetAllUserUsecase getAllUserUsecase;

  GetAllUserCubit({
    required this.getAllUserUsecase,
  }) : super(const GetAllUserInitial());

  Future<void> getData() async {
    emit(const GetAllUserLoading());

    final data = await getAllUserUsecase.call(NoParams());

    data.fold(
      (l) => emit(GetAllUserNotLoaded(message: l.message!)),
      (r) => emit(GetAllUserLoaded(data: r)),
    );
  }
}
