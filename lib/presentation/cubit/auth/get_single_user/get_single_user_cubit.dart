import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/params/user/get_single_user_params.dart';
import '../../../../domain/entities/auth/user_entity.dart';
import '../../../../domain/usecases/auth/get_single_user_usecase.dart';

part 'get_single_user_state.dart';

class GetSingleUserCubit extends Cubit<GetSingleUserState> {
  final GetSingleUserUsecase getSingleUserUsecase;

  GetSingleUserCubit({
    required this.getSingleUserUsecase,
  }) : super(const GetSingleUserInitial());

  Future<void> getData(GetSingleUserParams params) async {
    emit(const GetSingleUserLoading());

    final data = await getSingleUserUsecase.call(params);

    data.fold(
      (l) => emit(GetSingleUserNotLoaded(message: l.message!)),
      (r) => emit(GetSingleUserLoaded(data: r)),
    );
  }
}
