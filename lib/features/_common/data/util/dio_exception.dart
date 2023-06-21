import 'package:dio/dio.dart';
import 'package:image_hoster/generated/l10n.dart';

String createErrorMessage(e) {
  if (e is DioException) {
    return e.message ?? S.current.defaultErrorMessage;
  }
  return S.current.defaultErrorMessage;
}