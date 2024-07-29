import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/auth/user_entity.dart';
import '../../../../domain/usecases/auth/get_single_user_usecase.dart';

part 'get_single_user_state.dart';

class GetSingleUserCubit extends Cubit<GetSingleUserState> {
  final GetSingleUserUsecase getSingleUserUsecase;

  GetSingleUserCubit({
    required this.getSingleUserUsecase,
  }) : super(const GetSingleUserInitial());

  Future<void> getData(int userId) async {
    emit(const GetSingleUserLoading());

    final data = await getSingleUserUsecase.call(userId);

    data.fold(
      (l) => emit(GetSingleUserNotLoaded(message: l.message!)),
      (r) => emit(GetSingleUserLoaded(data: r)),
    );
  }
}
