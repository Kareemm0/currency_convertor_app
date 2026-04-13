import 'package:currency_convertor_app/core/core.dart';
import 'package:dartz/dartz.dart';

abstract class FlagsDataSource {
  Future<Either<Failure, String>> getFlags({required String countryCode});
}
