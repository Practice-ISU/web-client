import 'package:image_hoster/features/_common/data/api/stock_rest_api.dart';
import 'package:image_hoster/features/_common/data/session_store.dart';
import 'package:image_hoster/features/folder/data/model/folder.dart';
import 'package:image_hoster/features/image/data/model/image_item.dart';
import 'package:image_hoster/features/image/data/request/get_images_request.dart';
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
      ImageItem(0, 'https://i.ytimg.com/vi/6D55tzWSM9E/maxresdefault.jpg'),
      ImageItem(1,
          'https://res.cloudinary.com/dvhxdwwld/image/upload/v1660028418/cover-sleep_upqdhc.png'),
      ImageItem(2, 'https://i.ytimg.com/vi/HaV8k1m0n28/maxresdefault.jpg'),
      ImageItem(3, 'https://i.ytimg.com/vi/HaV8k1m0n28/maxresdefault.jpg'),
      ImageItem(4, 'https://i.ytimg.com/vi/HaV8k1m0n28/maxresdefault.jpg'),
      ImageItem(5, 'https://i.ytimg.com/vi/HaV8k1m0n28/maxresdefault.jpg'),
    ]);
  }
}
