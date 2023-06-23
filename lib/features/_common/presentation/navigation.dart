import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const login = 'login';
  static const folders = 'folders';
  static const images = 'images';
}

class Navigation {
  final BuildContext context;

  Navigation(this.context);

  back() {
    if (context.canPop()) {
      context.pop();
    }
  }

  login() => context.goNamed(Routes.login);

  folders() => context.goNamed(Routes.folders);

  images(int folderId) => context.goNamed(Routes.images,
      pathParameters: {'folderId': folderId.toString()});
}

extension ContextNavigator on BuildContext {
  Navigation get navigation => Navigation(this);
}
