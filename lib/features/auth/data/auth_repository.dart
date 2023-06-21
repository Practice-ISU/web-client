import 'package:image_hoster/features/_common/data/api/stock_rest_api.dart';
import 'package:image_hoster/features/auth/data/dto/auth_request.dart';
import 'package:image_hoster/features/auth/data/dto/auth_response.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class AuthRepository {
  final StockRestApi _api;

  AuthRepository(this._api);

  Future<AuthResponse> login(String name, String password) => _api.login(AuthRequest(name, password));

  Future<AuthResponse> register(String name, String password) => _api.register(AuthRequest(name, password));
}