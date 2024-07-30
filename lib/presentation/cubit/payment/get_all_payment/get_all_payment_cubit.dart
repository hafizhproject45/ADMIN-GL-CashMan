import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/usecases/payment/get_all_payment_usecase.dart';
import '../../../../domain/entities/payment/payment_entity.dart';

part 'get_all_payment_state.dart';

class GetAllPaymentCubit extends Cubit<GetAllPaymentState> {
  final GetAllPaymentUsecase getAllPaymentUsecase;

  GetAllPaymentCubit({
    required this.getAllPaymentUsecase,
  }) : super(const GetAllPaymentInitial());

  Future<void> getData(GetAllPaymentParams params) async {
    emit(const GetAllPaymentLoading());

    final data = await getAllPaymentUsecase.call(params);

    data.fold(
      (l) => emit(GetAllPaymentNotLoaded(message: l.message!)),
      (r) => emit(GetAllPaymentLoaded(data: r)),
    );
  }
}
