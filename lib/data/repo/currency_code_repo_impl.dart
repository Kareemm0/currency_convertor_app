import 'package:currency_convertor_app/core/inputs/rates_inputs.dart';

import 'package:currency_convertor_app/core/network/errors/failure.dart';
import 'package:currency_convertor_app/data/data.dart';

import 'package:dartz/dartz.dart';

import '../../domian/domian.dart';

class CurrencyCodeRepoImpl implements CurrencyCodeRepo {
  CurrencyCodeRepoImpl({required CurrencyCodeDataSource data}) : _data = data;

  final CurrencyCodeDataSource _data;
  @override
  Future<Either<Failure, List<CurrencyConvertorModel>>> getCurrency({
    required RatesInputs inputs,
  }) async {
    try {
      final response = await _data.getRates(inputs: inputs);
      return response.fold(
        (failure) {
          return Left(ServerFailure(msg: failure.msg));
        },
        (right) {
          final list = right;

          return Right(
            list.map((e) => CurrencyConvertorModel.fromJson(e)).toList(),
          );
        },
      );
    } catch (e) {
      return Left(DataMappingFailure(msg: e.toString()));
    }
  }
}
