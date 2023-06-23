import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_hoster/core/application.dart';
import 'package:image_hoster/di/injector.dart';
import 'package:image_hoster/features/_common/data/session_store.dart';
import 'package:image_hoster/features/_common/presentation/navigation_cubit.dart';
import 'package:image_hoster/features/_common/presentation/navigation_state.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SessionStore.ensureInitialized();

    await Injector.instance.configure();

    final isAuthorized = SessionStore.instance.isLoggedIn;

    final navigationState = await isAuthorized
        ? AuthorizedNavigationState()
        : UnauthorizedNavigationState();

    runApp(BlocProvider(
        create: (context) => NavigationCubit(navigationState),
        child: const Application()));
  }, (error, stack) {
    debugPrint(error.toString());
    debugPrint(stack.toString());
  });
}
