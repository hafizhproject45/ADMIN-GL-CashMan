import 'package:supabase/supabase.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../core/utils/constants.dart';
import '../../../domain/entities/contact/contact_entity.dart';
import '../../models/contact/contact_model.dart';

abstract class ContactDatasource {
  Future<List<ContactEntity>> getContact();
}

class ContactDatasourceImpl extends ContactDatasource {
  final SupabaseClient supabase;

  ContactDatasourceImpl({
    required this.supabase,
  });

  @override
  Future<List<ContactEntity>> getContact() async {
    try {
      final res =
          await supabase.from('contact').select().order('id', ascending: true);

      return res.map((x) => ContactModel.fromJson(x)).toList();
    } catch (e) {
      return _handleException(e);
    }
  }

  _handleException(Object e) {
    if (e is ServerException) {
      throw ServerFailure(message: e.message);
    } else {
      throw const UnknownFailure(message: FAILURE_UNKNOWN);
    }
  }
}
