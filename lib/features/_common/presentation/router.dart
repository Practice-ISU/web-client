import 'package:go_router/go_router.dart';
import 'package:image_hoster/features/_common/presentation/navigation.dart';

GoRouter createAppRouter() => GoRouter(
      initialLocation: Routes.login,
      routes: [
        GoRoute(
          path: Routes.login,
        ),
        GoRoute(
          path: Routes.register,
        ),
      ],
    );
