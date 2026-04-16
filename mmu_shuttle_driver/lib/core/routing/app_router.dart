import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mmu_shuttle_driver/features/announcement/screens/announcement_screen.dart';
import 'package:mmu_shuttle_driver/features/announcement/screens/view_file_screen.dart';
import 'package:mmu_shuttle_driver/features/authentication/screens/sign_in_screen.dart';
import 'package:mmu_shuttle_driver/features/main_navigation/screens/main_scaffold.dart';
import 'package:mmu_shuttle_driver/features/main_navigation/screens/splash_screen.dart';
import 'package:mmu_shuttle_driver/features/profile/screens/profile_screen.dart';
import 'package:mmu_shuttle_driver/features/routes/screens/route_screen.dart';
import 'package:mmu_shuttle_driver/features/routes/screens/start_route_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/sign-in',
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: '/start-route',
      builder: (context, state) {
        final isOngoing = state.extra as bool? ?? false;
        return StartRouteScreen(isOngoing: isOngoing);
      },
    ),
    GoRoute(
      path: '/view-file',
      builder: (context, state) {
        final fileName = state.extra as String;
        return ViewFileScreen(fileName: fileName);
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainScaffold(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/routes',
              builder: (context, state) => const RouteScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/announcements',
              builder: (context, state) => const AnnouncementScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
