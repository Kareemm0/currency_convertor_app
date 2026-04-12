import 'package:dartz/dartz.dart';

import '../errors.dart' show ServerFailure;

abstract interface class ApiConsumer {
  Future<Either<ServerFailure, T>> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
}
