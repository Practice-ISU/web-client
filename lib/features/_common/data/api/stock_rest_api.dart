import 'package:dio/dio.dart';
import 'package:image_hoster/features/auth/data/dto/auth_request.dart';
import 'package:image_hoster/features/auth/data/dto/auth_response.dart';
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
}
