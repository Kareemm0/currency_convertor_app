import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppInterceptors extends Interceptor {
  AppInterceptors();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (kDebugMode) {
      log('REQUEST[${options.method}] => PATH: ${options.path}');
      log('Headers: ${options.headers}');
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (kDebugMode) {
      log(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
      );
    }
    if (response.statusCode == 401 || response.statusCode == 302) {}
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      log(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
      );
      if (err.response?.data != null) {
        log('Error data: ${err.response?.data}');
      }
    }
    super.onError(err, handler);
  }
}
