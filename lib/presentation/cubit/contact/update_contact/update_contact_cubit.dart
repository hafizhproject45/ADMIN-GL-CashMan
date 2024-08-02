import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/contact/contact_update_entity.dart';
import '../../../../domain/usecases/contact/update_contact_usecase.dart';

part 'update_contact_state.dart';

class UpdateContactCubit extends Cubit<UpdateContactState> {
  final UpdateContactUsecase updateContactUsecase;

  UpdateContactCubit({
    required this.updateContactUsecase,
  }) : super(UpdateContactInitial());

  Future<void> payment(ContactUpdateEntity request) async {
    emit(UpdateContactLoading());

    final result = await updateContactUsecase.call(request);

    result.fold(
      (l) => emit(UpdateContactFailed(message: l.message!)),
      (r) => emit(UpdateContactSuccess()),
    );
  }
}
