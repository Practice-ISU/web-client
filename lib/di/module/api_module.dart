import 'package:image_hoster/constants.dart';
import 'package:image_hoster/features/_common/data/api/stock_rest_api.dart';
import 'package:image_hoster/features/_common/data/dio_factory.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ApiModule {
  @Singleton()
  StockRestApi getStockApiClient(DioFactory factory) {
    return StockRestApi(dio: factory.create(), baseUrl: Constants.baseUrl);
  }
}
