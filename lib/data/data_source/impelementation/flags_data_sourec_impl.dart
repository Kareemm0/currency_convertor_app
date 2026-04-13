import 'package:currency_convertor_app/core/core.dart';
import 'package:currency_convertor_app/data/data_source/abstraction/flags_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_svg/svg.dart';

class FlagsDataSourecImpl implements FlagsDataSource {
  FlagsDataSourecImpl({required ApiConsumer dio}) : _dio = dio;
  final ApiConsumer _dio;
  @override
  Future<Either<Failure, SvgPicture>> getFlags({
    required String countryCode,
  }) async {
    try {
      final response = await _dio.get(path: Endpoints.flags(countryCode));

      return response.fold(
        (failure) {
          return Left(ServerFailure(msg: failure.msg));
        },
        (success) {
          return Right(success);
        },
      );
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }
}
