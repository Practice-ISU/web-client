import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_hoster/features/_common/data/session_store.dart';
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

    dio.interceptors.add(QueuedInterceptorsWrapper(
        onResponse: (response, handler) async {
          if (response.data['isSuccess'] == false && response.data['message'] == 'Invalid token') {
            await SessionStore.instance.deleteAccessToken();
            return handler.resolve(response);
          }
          return handler.next(response);
        },
        onError: (e, handler) async {
          if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
            await SessionStore.instance.deleteAccessToken();
            return handler.reject(e);
          }
          return handler.next(e);
        },
      ),
    );

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
