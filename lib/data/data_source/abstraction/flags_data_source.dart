import 'package:currency_convertor_app/core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_svg/svg.dart';

abstract class FlagsDataSource {
  Future<Either<Failure, SvgPicture>> getFlags({required String countryCode});
}
