import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import '../../../core/core.dart'
    show
        ServerFailure,
        StatusCodes,
        ServerException,
        FetchDataException,
        UnauthorizedException,
        NotFoundException,
        ConflictException,
        InternalServerErrorException,
        NoInternetConnectionException;
import '../../../core/network/api/api_consumer.dart';

class DioConsumer implements ApiConsumer {
  final Dio _client;
  final String _baseUrl;
  final List<Interceptor> _interceptors;

  DioConsumer({
    required Dio client,
    required String baseUrl,
    required List<Interceptor> interceptors,
  }) : _baseUrl = baseUrl,
       _interceptors = interceptors,
       _client = client {
    (_client.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    _client.options = BaseOptions(
      baseUrl: _baseUrl,
      followRedirects: false,
      validateStatus: (status) {
        return status! < StatusCodes.internalServerError;
      },
    );

    _client.interceptors.addAll(_interceptors);
  }

  @override
  Future<Either<ServerFailure, T>> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _client.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return Right(response.data);
    } on DioException catch (error) {
      return Left(_handleDioError(error));
    }
  }

  ServerFailure _handleDioError(DioException error) {
    late ServerException exception;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        exception = const FetchDataException();
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case StatusCodes.unauthorized:
          case StatusCodes.forbidden:
            exception = const UnauthorizedException();
          case StatusCodes.notFound:
            exception = const NotFoundException();
          case StatusCodes.conflict:
            exception = const ConflictException();
          case StatusCodes.internalServerError:
            exception = const InternalServerErrorException();
        }
        break;
      // TODO: Handle these cases.
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        exception = const NoInternetConnectionException();
    }

    return ServerFailure(msg: exception.msg);
  }
}
