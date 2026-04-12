import 'package:currency_convertor_app/core/core.dart';
import 'package:dartz/dartz.dart';

import '../domian.dart';

abstract class CurrencyCodeRepo {
  Future<Either<Failure, List<CurrencyConvertorModel>>> getCurrency({
    required RatesInputs inputs,
  });
}
