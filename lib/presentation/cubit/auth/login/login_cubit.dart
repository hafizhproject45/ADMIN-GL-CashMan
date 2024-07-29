// ignore_for_file: unrelated_type_equality_checks

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../../../domain/entities/auth/login_request_entity.dart';
import '../../../../../domain/usecases/auth/check_login_usecase.dart';
import '../../../../../domain/usecases/auth/login_usecase.dart';
import '../../../../../domain/usecases/auth/logout_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final CheckLoginUsecase checkLoginUsecase;
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;

  LoginCubit({
    required this.checkLoginUsecase,
    required this.loginUsecase,
    required this.logoutUsecase,
  }) : super(LoginInitial());

  Future<void> checkLogin() async {
    emit(LoginInitial());

    final result = await checkLoginUsecase.call(NoParams());

    final check = result.fold(
      (l) => false,
      (r) => r == true,
    );

    await Future.delayed(const Duration(seconds: 3));

    if (check) {
      emit(LoginLoggedIn());
    } else {
      emit(LoginLoggedOut());
    }
  }

  void login(String email, String password) async {
    emit(LoginLoading());

    final loginData = LoginRequestEntity(
      email: email,
      password: password,
    );

    final result = await loginUsecase.call(loginData);

    result.fold(
      (l) => emit(LoginFailed(message: l.message!)),
      (r) => emit(LoginLoggedIn()),
    );
  }

  void logout() async {
    final result = await logoutUsecase.call(NoParams());

    result.fold(
      (l) => emit(LoginFailed(message: l.message!)),
      (r) => emit(LoginLoggedOut()),
    );
  }
}
