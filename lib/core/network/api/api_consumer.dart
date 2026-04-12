import 'package:dartz/dartz.dart';

import '../errors.dart' show ServerFailure;

abstract interface class ApiConsumer {
  Future<Either<ServerFailure, Map<String, dynamic>>> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
}
