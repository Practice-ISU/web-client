import 'package:image_hoster/features/_common/data/api/stock_rest_api.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class AuthRepository {
  final StockRestApi _api;

  AuthRepository(this._api);


}