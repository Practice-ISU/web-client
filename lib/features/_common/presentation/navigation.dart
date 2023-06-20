import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const login = '/login';
  static const register = '/register';
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

  register() => context.go(Routes.register);
}

extension ContextNavigator on BuildContext {
  Navigation get navigation => Navigation(this);
}
