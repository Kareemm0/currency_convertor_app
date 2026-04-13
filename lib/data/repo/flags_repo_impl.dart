import 'package:currency_convertor_app/core/network/errors/failure.dart';
import 'package:currency_convertor_app/data/data_source.dart';
import 'package:currency_convertor_app/domian/domian.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_svg/svg.dart';

class FlagsRepoImpl implements FlagsRepo {
  FlagsRepoImpl({required FlagsDataSource data}) : _data = data;

  final FlagsDataSource _data;
  @override
  Future<Either<Failure, SvgPicture>> getFlags({required String code}) async {
    try {
      final response = await _data.getFlags(countryCode: code);

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
