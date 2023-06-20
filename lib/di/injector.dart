import 'package:get_it/get_it.dart';
import 'package:image_hoster/di/injector.config.dart';
import 'package:injectable/injectable.dart';

class Injector {
  static final Injector instance = Injector._();

  Injector._();

  Future<void> configure() async {
    await _initInjectable();
  }

  T resolve<T extends Object>([String? instanceName]) =>
      GetIt.instance.get<T>(instanceName: instanceName);
}

@injectableInit
Future<void> _initInjectable() async => GetIt.instance.init();
