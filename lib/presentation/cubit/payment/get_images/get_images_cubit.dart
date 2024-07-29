import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/payment/payment_entity.dart';
import '../../../../domain/usecases/payment/get_images_usecase.dart';

part 'get_images_state.dart';

class GetImagesCubit extends Cubit<GetImagesState> {
  final GetImagesUsecase getImagesUsecase;

  GetImagesCubit({
    required this.getImagesUsecase,
  }) : super(const GetImagesInitial());

  Future<void> getData() async {
    emit(const GetImagesLoading());

    final data = await getImagesUsecase.call(NoParams());

    data.fold(
      (l) => emit(GetImagesNotLoaded(message: l.message!)),
      (r) => emit(GetImagesLoaded(data: r)),
    );
  }
}
