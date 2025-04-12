import 'package:supabase/supabase.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../core/utils/constants.dart';
import '../../../domain/entities/contact/contact_entity.dart';
import '../../../domain/entities/contact/contact_update_entity.dart';
import '../../models/contact/contact_model.dart';

abstract class ContactDatasource {
  Future<List<ContactEntity>> getContact();
  Future<void> postContact(ContactEntity request);
  Future<void> updateContact(UpdateContactEntity request);
  Future<void> deleteContact(int phoneId);
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
          await supabase.from('contacts').select().order('id', ascending: true);

      return res.map((x) => ContactModel.fromJson(x)).toList();
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<void> postContact(ContactEntity request) async {
    try {
      await supabase.from('contacts').insert(request.toJson());
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<void> updateContact(UpdateContactEntity request) async {
    try {
      await supabase
          .from('contacts')
          .update(request.toJson())
          .eq('id', request.id!);
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<void> deleteContact(int phoneId) async {
    try {
      await supabase.from('contacts').delete().eq('id', phoneId);
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
