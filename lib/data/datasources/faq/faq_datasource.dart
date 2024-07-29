import 'package:supabase/supabase.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../core/utils/constants.dart';
import '../../../domain/entities/faq/faq_entity.dart';
import '../../models/faq/faq_model.dart';

abstract class FaqDatasource {
  Future<List<FaqEntity>> getFaq();
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

  List<FaqEntity> _handleException(Object e) {
    if (e is ServerException) {
      throw ServerFailure(message: e.message);
    } else {
      throw const UnknownFailure(message: FAILURE_UNKNOWN);
    }
  }
}
