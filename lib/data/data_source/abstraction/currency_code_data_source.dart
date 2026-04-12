import 'package:currency_convertor_app/core/core.dart';
import 'package:dartz/dartz.dart';

abstract class CurrencyCodeDataSource {
  Future<Either<Failure, List<dynamic>>> getRates({
    required RatesInputs inputs,
  });
}
