import 'package:dio/dio.dart';
import 'package:image_hoster/generated/l10n.dart';

String createErrorMessage(e) {
  if (e is DioException) {
    return e.response?.data is Map<String, dynamic>
        ? e.response?.data['message'] ?? e.message
        : e.message ?? S.current.defaultErrorMessage;
  }
  return S.current.defaultErrorMessage;
}
