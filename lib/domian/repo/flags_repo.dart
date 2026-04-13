import 'package:currency_convertor_app/core/core.dart';
import 'package:dartz/dartz.dart';

abstract class FlagsRepo {
  Future<Either<Failure, String>> getFlags({required String code});
}
