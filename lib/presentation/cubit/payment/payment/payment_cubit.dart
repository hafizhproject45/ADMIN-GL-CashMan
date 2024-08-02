import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/params/payment/payment_params.dart';
import '../../../../domain/usecases/payment/payment_usecase.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentUsecase paymentUsecase;

  PaymentCubit({
    required this.paymentUsecase,
  }) : super(PaymentInitial());

  Future<void> payment(PaymentParams request) async {
    emit(PaymentLoading());

    final result = await paymentUsecase.call(request);

    result.fold(
      (l) => emit(PaymentFailed(message: l.message!)),
      (r) => emit(PaymentSuccess()),
    );
  }
}
