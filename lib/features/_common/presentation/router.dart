import 'package:go_router/go_router.dart';
import 'package:image_hoster/features/_common/presentation/navigation.dart';
import 'package:image_hoster/features/auth/presentation/login/login_screen.dart';
import 'package:image_hoster/features/folder/presentation/list/folders_screen.dart';

GoRouter createAppRouter() => GoRouter(
      initialLocation: Routes.folders,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const FoldersScreen(),
        ),
        GoRoute(
          path: Routes.login,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: Routes.folders,
          builder: (context, state) => const FoldersScreen(),
        ),
      ],
    );
