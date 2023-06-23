import 'package:dio/dio.dart';
import 'package:image_hoster/features/_common/data/request/access_token_request.dart';
import 'package:image_hoster/features/auth/data/request/auth_request.dart';
import 'package:image_hoster/features/auth/data/response/auth_response.dart';
import 'package:image_hoster/features/folder/data/model/folder.dart';
import 'package:image_hoster/features/folder/data/request/add_folder_request.dart';
import 'package:image_hoster/features/image/data/request/get_images_request.dart';
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

  @POST('$authPath/register')
  Future<AuthResponse> register(
    @Body() AuthRequest request,
  );

  @GET('/folders')
  Future<List<Folder>> getFolders(@Body() AccessTokenRequest request);

  @POST('/create-folder')
  Future<void> addFolder(@Body() AddFolderRequest request);

  @POST('/folders/get')
  Future<GetImagesResponse> getImages(@Body() GetImagesRequest request);
}
