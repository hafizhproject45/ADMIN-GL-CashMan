import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/payment/payment_entity.dart';
import '../../../../domain/usecases/payment/get_payment_today_usecase.dart';

part 'get_payment_today_state.dart';

class GetPaymentTodayCubit extends Cubit<GetPaymentTodayState> {
  final GetPaymentTodayUsecase getPaymentTodayUsecase;

  GetPaymentTodayCubit({
    required this.getPaymentTodayUsecase,
  }) : super(const GetPaymentTodayInitial());

  Future<void> getData() async {
    emit(const GetPaymentTodayLoading());

    final data = await getPaymentTodayUsecase.call(NoParams());

    data.fold(
      (l) => emit(GetPaymentTodayNotLoaded(message: l.message!)),
      (r) => emit(GetPaymentTodayLoaded(data: r)),
    );
  }
}
