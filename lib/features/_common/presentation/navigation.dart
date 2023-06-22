import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const login = '/login';
  static const folders = '/folders';
}

class Navigation {
  final BuildContext context;

  Navigation(this.context);

  back() {
    if (context.canPop()) {
      context.pop();
    }
  }

  login() => context.go(Routes.login);

  folders() => context.go(Routes.folders);
}

extension ContextNavigator on BuildContext {
  Navigation get navigation => Navigation(this);
}
