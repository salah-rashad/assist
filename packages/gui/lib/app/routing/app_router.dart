import 'package:assist_gui/app/routing/route_names.dart';
import 'package:assist_gui/features/dashboard/view/dashboard_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../features/main_layout/view/main_layout.dart';

typedef NavKey = GlobalKey<NavigatorState>;

abstract class AppRouter {
  static String initialRoute = '/${RouteNames.dashboard}';

  static final rootNavKey = NavKey(debugLabel: 'rootNavKey');
  static final dashboardNavKey = NavKey(debugLabel: 'dashboardNavKey');
  static final settingsNavKey = NavKey(debugLabel: 'settingsNavKey');

  static GoRouter router = GoRouter(
    navigatorKey: rootNavKey,
    initialLocation: initialRoute,
    routes: [
      GoRoute(path: '/', redirect: (context, state) => initialRoute),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayout(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: dashboardNavKey,
            routes: [
              GoRoute(
                path: '/dashboard',
                name: RouteNames.dashboard,
                builder: (context, state) => const DashboardScreen(),
                routes: [
                  GoRoute(
                    path: RouteNames.createProject,
                    name: RouteNames.createProject,
                    builder: (context, state) {
                      return Center(child: const Text('Create Project'));
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: settingsNavKey,
            routes: [
              GoRoute(
                path: '/${RouteNames.settings}',
                name: RouteNames.settings,
                builder: (context, state) {
                  return Center(child: const Text('Settings'));
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
