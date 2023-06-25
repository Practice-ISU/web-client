import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_hoster/features/_common/presentation/navigation.dart';
import 'package:image_hoster/features/_common/presentation/navigation_cubit.dart';
import 'package:image_hoster/features/_common/presentation/navigation_state.dart';
import 'package:image_hoster/features/auth/presentation/login/login_screen.dart';
import 'package:image_hoster/features/folder/presentation/list/folders_screen.dart';
import 'package:image_hoster/features/image/presentation/list/images_screen.dart';
import 'package:image_hoster/features/image/presentation/upload/upload_image_screen.dart';

class AppRouter {
  NavigationCubit navigationCubit;

  AppRouter(this.navigationCubit);

  GoRouter get router => _router;

  late final GoRouter _router = GoRouter(
      refreshListenable: navigationCubit,
      initialLocation: '/folders',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Container(),
        ),
        GoRoute(
          path: '/login',
          name: Routes.login,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/folders',
          name: Routes.folders,
          builder: (context, state) => const FoldersScreen(),
          routes: [
            GoRoute(
              path: 'images/:folderId',
              name: Routes.images,
              builder: (context, state) => ImagesScreen(
                folderId: int.parse(state.pathParameters['folderId']!),
              ),
            ),
            GoRoute(
              path: 'images/:folderId/upload',
              name: Routes.uploadImage,
              builder: (context, state) => UploadImageScreen(
                folderId: int.parse(state.pathParameters['folderId']!),
              ),
            )
          ],
        ),
      ],
      redirect: (context, state) {
        if (state.location == '/') {
          return '/folders';
        }
        if (state.location.startsWith('/login')) {
          if (navigationCubit.state is AuthorizedNavigationState) {
            return '/folders';
          }
        } else if (navigationCubit.state is UnauthorizedNavigationState) {
          return '/login';
        }
        return null;
      });
}
