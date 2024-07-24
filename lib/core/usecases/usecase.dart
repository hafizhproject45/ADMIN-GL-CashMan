import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

/// [Type] adalah tipe [kembalian] dari fungsi [call]
/// [Params] adalah [parameter] yang akan dimasukan ke dalam fungsi [call]
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// [NoParams] ini tidak ada [Paramater] dan [Return] di dalam class
class NoParams {}
