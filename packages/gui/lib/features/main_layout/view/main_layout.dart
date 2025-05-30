import 'package:assist_gui/core/utils/extensions.dart';
import 'package:assist_gui/features/main_layout/widgets/app_nav_rail.dart';
import 'package:assist_gui/features/main_layout/widgets/app_top_bar.dart';
import 'package:assist_gui/features/task_manager/view/task_status_bar.dart';
import 'package:assist_gui/shared/widgets/breadcrumps.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static void goBranch(StatefulNavigationShell navigationShell, int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(
        context.colorScheme.primary.withValues(alpha: 0.05),
        context.colorScheme.background,
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                AppNavRail(
                  navigationShell: navigationShell,
                  onDestinationSelected: (index) =>
                      goBranch(navigationShell, index),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(children: [
                        Breadcrumbs(),
                        Expanded(child: AppTopBar())
                      ]),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                            end: 16,
                          ),
                          child: ShadCard(
                            padding: const EdgeInsets.all(16),
                            radius: BorderRadius.all(Radius.circular(16)),
                            child: navigationShell,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                const Spacer(),
                TaskStatusBar(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
