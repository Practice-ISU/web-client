import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:image_hoster/features/_common/data/api/stock_rest_api.dart';
import 'package:image_hoster/features/_common/data/session_store.dart';
import 'package:image_hoster/features/image/data/request/delete_image_request.dart';
import 'package:image_hoster/features/image/data/request/get_images_request.dart';
import 'package:image_hoster/features/image/data/request/upload_image_request.dart';
import 'package:image_hoster/features/image/data/response/download_images_response.dart';
import 'package:image_hoster/features/image/data/response/get_images_response.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@Singleton()
class ImagesRepository {
  final StockRestApi _api;

  ImagesRepository(this._api);

  Future<GetImagesResponse> getImages(int folderId) async =>
      _api.getImages(GetImagesRequest(await SessionStore.instance.accessToken, folderId));

  Future<dynamic> upload({required int folderId, required Uint8List file, required String format}) async {
    final token = await SessionStore.instance.accessToken;

    final base64 = base64Encode(file);

    await _api.uploadImage(
      UploadImageRequest(
        token: token,
        folderId: folderId,
        file: base64,
        format: format,
        fileName: _generateFileName(folderId),
      ),
    );
  }

  String _generateFileName(int folderId) =>
      '$folderId-${DateFormat(DateFormat.YEAR_NUM_MONTH_DAY + DateFormat.HOUR24_MINUTE_SECOND).format(DateTime.now())}-${Random().nextInt(1000000)}';

  Future<dynamic> deleteImage(int id) async => _api.deleteImage(
        DeleteImageRequest(await SessionStore.instance.accessToken, id),
      );

  Future<DownloadImagesResponse> downloadImages(int folderId) async => _api.downloadImages(
    GetImagesRequest(await SessionStore.instance.accessToken, folderId),
  );
}
