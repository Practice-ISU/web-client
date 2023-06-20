import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_hoster/core/application.dart';
import 'package:image_hoster/di/injector.dart';
import 'package:image_hoster/features/_common/data/session_store.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SessionStore.ensureInitialized();

    await Injector.instance.configure();

    runApp(const Application());
  }, (error, stack) {
    debugPrint(error.toString());
    debugPrint(stack.toString());
  });
}
