import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/contact/contact_entity.dart';
import '../../../../domain/usecases/contact/get_contact_usecase.dart';

part 'get_contact_state.dart';

class GetContactCubit extends Cubit<GetContactState> {
  final GetContactUsecase getContactUsecase;

  GetContactCubit({
    required this.getContactUsecase,
  }) : super(const GetContactInitial());

  Future<void> getData({String? search}) async {
    emit(const GetContactLoading());

    final data = await getContactUsecase.call(NoParams());

    data.fold(
      (l) => emit(GetContactNotLoaded(message: l.message!)),
      (r) {
        List<ContactEntity> filteredContacts = r;
        if (search != null && search.isNotEmpty) {
          filteredContacts = r
              .where(
                (contact) =>
                    contact.name!
                        .toLowerCase()
                        .contains(search.toLowerCase()) ||
                    contact.phone!.toLowerCase().contains(search.toLowerCase()),
              )
              .toList();
        }
        emit(GetContactLoaded(data: filteredContacts));
      },
    );
  }
}
