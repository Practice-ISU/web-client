import 'package:image_hoster/features/_common/data/api/stock_rest_api.dart';
import 'package:image_hoster/features/_common/data/request/access_token_request.dart';
import 'package:image_hoster/features/_common/data/session_store.dart';
import 'package:image_hoster/features/folder/data/model/folder.dart';
import 'package:image_hoster/features/folder/data/request/add_folder_request.dart';
import 'package:image_hoster/features/folder/data/request/delete_folder_request.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class FolderRepository {
  final StockRestApi _api;

  FolderRepository(this._api);

  Future<List<Folder>> getFolders() async => (await _api.getFolders(
          AccessTokenRequest(await SessionStore.instance.accessToken)))
      .folders;

  Future<void> addFolder(String name) async => _api.addFolder(
      AddFolderRequest(await SessionStore.instance.accessToken, name));

  Future<dynamic> deleteFolder(int folderId) async => _api.deleteFolder(
        DeleteFolderRequest(await SessionStore.instance.accessToken, folderId),
      );
}
