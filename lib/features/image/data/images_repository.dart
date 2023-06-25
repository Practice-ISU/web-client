import 'dart:convert';
import 'dart:typed_data';

import 'package:image_hoster/features/_common/data/api/stock_rest_api.dart';
import 'package:image_hoster/features/_common/data/session_store.dart';
import 'package:image_hoster/features/folder/data/model/folder.dart';
import 'package:image_hoster/features/image/data/model/image_item.dart';
import 'package:image_hoster/features/image/data/request/delete_image_request.dart';
import 'package:image_hoster/features/image/data/request/upload_image_request.dart';
import 'package:image_hoster/features/image/data/response/get_images_response.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class ImagesRepository {
  final StockRestApi _api;

  ImagesRepository(this._api);

/*  Future<GetImagesResponse> getImages(int folderId) async => _api
      .getImages(GetImagesRequest(await SessionStore.instance.accessToken, folderId));*/

  Future<GetImagesResponse> getImages(int folderId) async {
    await Future.delayed(const Duration(seconds: 1));
    return GetImagesResponse(const Folder(0, 'Humans'), [
      ImageItem.fromOriginal(0,
          'https://images.unsplash.com/photo-1682695798256-28a674122872?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80'),
      ImageItem.fromOriginal(1,
          'https://images.unsplash.com/photo-1687441266692-de2df8197665?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60'),
      ImageItem.fromOriginal(2,
          'https://images.unsplash.com/photo-1687439961270-36b8a361ae32?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60'),
      ImageItem.fromOriginal(3,
          'https://images.unsplash.com/photo-1666919643134-d97687c1826c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60'),
      ImageItem.fromOriginal(4,
          'https://plus.unsplash.com/premium_photo-1677560520935-9806ea830531?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60'),
    ]);
  }

  Future<void> upload(
      {required int folderId,
      required Uint8List original,
      required Uint8List painted}) async {
    final token = await SessionStore.instance.accessToken;

    final originalBase64 = base64Encode(original);
    final paintedBase64 = base64Encode(painted);

    await _api.uploadImage(UploadImageRequest(
      token: token,
      folderId: folderId,
      original: originalBase64,
      painted: paintedBase64,
    ));
  }

  Future<void> deleteImage(int id) async => _api.deleteImage(
        DeleteImageRequest(await SessionStore.instance.accessToken, id),
      );
}
