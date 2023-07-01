import 'package:dio/dio.dart';
import 'package:image_hoster/features/_common/data/request/access_token_request.dart';
import 'package:image_hoster/features/auth/data/request/auth_request.dart';
import 'package:image_hoster/features/auth/data/response/auth_response.dart';
import 'package:image_hoster/features/folder/data/request/add_folder_request.dart';
import 'package:image_hoster/features/folder/data/request/delete_folder_request.dart';
import 'package:image_hoster/features/folder/data/response/get_folders_response.dart';
import 'package:image_hoster/features/image/data/request/delete_image_request.dart';
import 'package:image_hoster/features/image/data/request/get_images_request.dart';
import 'package:image_hoster/features/image/data/request/upload_image_request.dart';
import 'package:image_hoster/features/image/data/response/download_images_response.dart';
import 'package:image_hoster/features/image/data/response/get_images_response.dart';
import 'package:retrofit/retrofit.dart';

part 'stock_rest_api.g.dart';

@RestApi()
abstract class StockRestApi {
  factory StockRestApi({
    required Dio dio,
    required String baseUrl,
  }) =>
      _StockRestApi(dio, baseUrl: baseUrl);

  static const String authPath = '/auth';

  @POST('$authPath/login')
  Future<AuthResponse> login(
    @Body() AuthRequest request,
  );

  @POST('$authPath/registration')
  Future<AuthResponse> register(
    @Body() AuthRequest request,
  );

  @POST('/folder/getAll')
  Future<GetFoldersResponse> getFolders(@Body() AccessTokenRequest request);

  @POST('/folder/add')
  Future<void> addFolder(@Body() AddFolderRequest request);

  @POST('/file/getAll')
  Future<GetImagesResponse> getImages(@Body() GetImagesRequest request);

  @POST('/file/add')
  Future<dynamic> uploadImage(@Body() UploadImageRequest request);

  @POST('/file/delete')
  Future<dynamic> deleteImage(@Body() DeleteImageRequest request);

  @POST('/file/getAllZip')
  Future<DownloadImagesResponse> downloadImages(@Body() GetImagesRequest request);

  @POST('/folder/delete')
  Future<dynamic> deleteFolder(@Body() DeleteFolderRequest request);
}
