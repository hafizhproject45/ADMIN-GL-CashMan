import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/payment/payment_entity.dart';
import '../../../../domain/usecases/payment/get_single_payment_usecase.dart';

part 'get_single_payment_state.dart';

class GetSinglePaymentCubit extends Cubit<GetSinglePaymentState> {
  final GetSinglePaymentUsecase getSinglePaymentUsecase;

  GetSinglePaymentCubit({
    required this.getSinglePaymentUsecase,
  }) : super(const GetSinglePaymentInitial());

  Future<void> getData(GetSinglePaymentParams params) async {
    emit(const GetSinglePaymentLoading());

    final data = await getSinglePaymentUsecase.call(params);

    data.fold(
      (l) => emit(GetSinglePaymentNotLoaded(message: l.message!)),
      (r) => emit(GetSinglePaymentLoaded(data: r)),
    );
  }
}
