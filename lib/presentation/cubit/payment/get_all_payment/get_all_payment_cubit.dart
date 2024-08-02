import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/params/payment/get_all_payment_params.dart';
import '../../../../domain/usecases/payment/get_all_payment_usecase.dart';
import '../../../../domain/entities/payment/payment_entity.dart';

part 'get_all_payment_state.dart';

class GetAllPaymentCubit extends Cubit<GetAllPaymentState> {
  final GetAllPaymentUsecase getAllPaymentUsecase;

  GetAllPaymentCubit({
    required this.getAllPaymentUsecase,
  }) : super(const GetAllPaymentInitial());

  Future<void> getData(GetAllPaymentParams params, {String? search}) async {
    emit(const GetAllPaymentLoading());

    final data = await getAllPaymentUsecase.call(params);

    data.fold(
      (l) => emit(GetAllPaymentNotLoaded(message: l.message!)),
      (r) {
        List<PaymentEntity> filteredPayments = r;
        if (search != null && search.isNotEmpty) {
          filteredPayments = r
              .where(
                (payment) =>
                    payment.paymentDate!
                        .toLowerCase()
                        .contains(search.toLowerCase()) ||
                    payment.imageName!
                        .toLowerCase()
                        .contains(search.toLowerCase()) ||
                    payment.imageUrl!
                        .toLowerCase()
                        .contains(search.toLowerCase()),
              )
              .toList();
        }
        emit(GetAllPaymentLoaded(data: filteredPayments));
      },
    );
  }
}
