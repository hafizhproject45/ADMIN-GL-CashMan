import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/usecases/auth/get_all_user_usecase.dart';
import '../../../../domain/entities/auth/user_entity.dart';

part 'get_all_user_state.dart';

class GetAllUserCubit extends Cubit<GetAllUserState> {
  final GetAllUserUsecase getAllUserUsecase;

  GetAllUserCubit({
    required this.getAllUserUsecase,
  }) : super(const GetAllUserInitial());

  Future<void> getData({String? select, String? search}) async {
    emit(const GetAllUserLoading());

    final data = await getAllUserUsecase.call(select ?? '*');

    data.fold(
      (l) => emit(GetAllUserNotLoaded(message: l.message!)),
      (r) {
        List<UserEntity> filteredUsers = r;
        if (search != null && search.isNotEmpty) {
          filteredUsers = r
              .where(
                (user) =>
                    user.fullname
                        .toLowerCase()
                        .contains(search.toLowerCase()) ||
                    user.block.toLowerCase().contains(search.toLowerCase()) ||
                    user.phone.toLowerCase().contains(search.toLowerCase()) ||
                    user.email.toLowerCase().contains(search.toLowerCase()),
              )
              .toList();
        }
        emit(GetAllUserLoaded(data: filteredUsers));
      },
    );
  }
}
