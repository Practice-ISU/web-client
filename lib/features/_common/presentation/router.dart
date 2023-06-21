import 'package:go_router/go_router.dart';
import 'package:image_hoster/features/_common/presentation/navigation.dart';
import 'package:image_hoster/features/auth/presentation/login/login_screen.dart';

GoRouter createAppRouter() => GoRouter(
      initialLocation: Routes.login,
      routes: [
        GoRoute(
          path: Routes.login,
          builder: (context, state) => const LoginScreen()
        ),
      ],
    );
