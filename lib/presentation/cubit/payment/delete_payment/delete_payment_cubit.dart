import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/usecases/payment/delete_payment_usecase.dart';

part 'delete_payment_state.dart';

class DeletePaymentCubit extends Cubit<DeletePaymentState> {
  final DeletePaymentUsecase deletePaymentUsecase;

  DeletePaymentCubit({
    required this.deletePaymentUsecase,
  }) : super(DeletePaymentInitial());

  Future<void> delete(int paymentId) async {
    emit(DeletePaymentLoading());

    final result = await deletePaymentUsecase.call(paymentId);

    result.fold(
      (l) => emit(DeletePaymentFailed(message: l.message!)),
      (r) => emit(DeletePaymentSuccess()),
    );
  }
}
