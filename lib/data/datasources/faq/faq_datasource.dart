import 'package:supabase/supabase.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../core/utils/constants.dart';
import '../../../domain/entities/faq/faq_entity.dart';
import '../../../domain/entities/faq/faq_update_entity.dart';
import '../../models/faq/faq_model.dart';

abstract class FaqDatasource {
  Future<List<FaqEntity>> getFaq();
  Future<void> postFaq(FaqEntity request);
  Future<void> updateFaq(FaqUpdateEntity request);
  Future<void> deleteFaq(int faqId);
}

class FaqDatasourceImpl extends FaqDatasource {
  final SupabaseClient supabase;

  FaqDatasourceImpl({
    required this.supabase,
  });

  @override
  Future<List<FaqEntity>> getFaq() async {
    try {
      final res = await supabase
          .from('faq')
          .select()
          .order('created_at', ascending: true);

      return res.map((x) => FaqModel.fromJson(x)).toList();
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<void> postFaq(FaqEntity request) async {
    try {
      await supabase.from('faq').insert(request.toJson());
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<void> updateFaq(FaqUpdateEntity request) async {
    try {
      await supabase.from('faq').update(request.toJson()).eq('id', request.id!);
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<void> deleteFaq(int faqId) async {
    try {
      await supabase.from('faq').delete().eq('id', faqId);
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
