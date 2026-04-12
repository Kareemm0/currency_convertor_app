import 'package:currency_convertor_app/core/core.dart';
import 'package:currency_convertor_app/data/data.dart';
import 'package:dartz/dartz.dart';

class CurrencyCodeDataSourceImpl implements CurrencyCodeDataSource {
  final ApiConsumer _dio;

  CurrencyCodeDataSourceImpl({required ApiConsumer dio}) : _dio = dio;
  @override
  Future<Either<Failure, List<dynamic>>> getRates({RatesInputs? inputs}) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        path: Endpoints.currency,
        queryParameters: inputs?.toJson(),
      );
      return response.fold(
        (failur) {
          return Left(ServerFailure(msg: failur.msg));
        },
        (right) {
          return Right(right.map((e) => e as Map<String, dynamic>).toList());
        },
      );
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }
}
