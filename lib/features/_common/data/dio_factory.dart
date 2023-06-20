import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class DioFactory {
  static const _timeout = Duration(seconds: 30);

  Dio create() {
    final options = BaseOptions(
      contentType: "application/json",
      connectTimeout: _timeout,
      sendTimeout: _timeout,
      receiveTimeout: _timeout,
    );
    final dio = Dio(options);

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (obj) => debugPrint("$obj"),
        ),
      );
    }

    return dio;
  }
}
