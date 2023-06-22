import 'package:image_hoster/features/_common/data/api/stock_rest_api.dart';
import 'package:image_hoster/features/_common/data/request/access_token_request.dart';
import 'package:image_hoster/features/_common/data/session_store.dart';
import 'package:image_hoster/features/folder/data/model/folder.dart';
import 'package:image_hoster/features/folder/data/request/add_folder_request.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class FolderRepository {
  final StockRestApi _api;

  FolderRepository(this._api);

/*
  Future<List<Folder>> getFolders() =>
      _api.getFolders(AccessTokenRequest(SessionStore.tokenKey));*/

  Future<List<Folder>> getFolders() async => [
        const Folder(0, 'Humans'),
        const Folder(1, 'Cats'),
        const Folder(2, 'Dogs'),
        const Folder(3, 'Dicks'),
        const Folder(4, 'Vaginas'),
        const Folder(5, 'Guitars'),
        const Folder(6, 'Books'),
        const Folder(7, 'Beaches'),
        const Folder(8, 'Stars'),
        const Folder(9, 'Rainbows'),
        const Folder(10, 'Cookies'),
        const Folder(11, 'Bicycles'),
        const Folder(12, 'Sunglasses'),
        const Folder(13, 'Mountains'),
        const Folder(14, 'Coffee'),
        const Folder(15, 'Paintings'),
        const Folder(16, 'Islands'),
        const Folder(17, 'Sunsets'),
        const Folder(18, 'Waterfalls'),
        const Folder(19, 'Cameras'),
        const Folder(20, 'Butterflies'),
        const Folder(21, 'Museums'),
        const Folder(22, 'Microphones'),
        const Folder(23, 'Hiking'),
        const Folder(24, 'Soccer'),
      ];

  Future<void> addFolder(String name) =>
      _api.addFolder(AddFolderRequest(SessionStore.tokenKey, name));
}
