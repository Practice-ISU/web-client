import 'dart:convert';
import 'dart:typed_data';

import 'package:image_hoster/features/_common/data/api/stock_rest_api.dart';
import 'package:image_hoster/features/_common/data/session_store.dart';
import 'package:image_hoster/features/image/data/request/delete_image_request.dart';
import 'package:image_hoster/features/image/data/request/get_images_request.dart';
import 'package:image_hoster/features/image/data/request/upload_image_request.dart';
import 'package:image_hoster/features/image/data/response/get_images_response.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class ImagesRepository {
  final StockRestApi _api;

  ImagesRepository(this._api);

 Future<GetImagesResponse> getImages(int folderId) async => _api
      .getImages(GetImagesRequest(await SessionStore.instance.accessToken, folderId));

  Future<void> upload(
      {required int folderId,
      required Uint8List file}) async {
    final token = await SessionStore.instance.accessToken;

    final base64 = base64Encode(file);

    await _api.uploadImage(UploadImageRequest(
      token: token,
      folderId: folderId,
      file: base64,
    ));
  }

  Future<void> deleteImage(int id) async => _api.deleteImage(
        DeleteImageRequest(await SessionStore.instance.accessToken, id),
      );
}
