import 'package:currency_convertor_app/core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class FlagsRepo {
  Future<Either<Failure, SvgPicture>> getFlags({required String code});
}
