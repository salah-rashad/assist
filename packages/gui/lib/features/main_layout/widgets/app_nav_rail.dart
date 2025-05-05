import 'package:assist_gui/core/utils/extensions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AppNavRail extends StatelessWidget {
  const AppNavRail({
    super.key,
    required this.navigationShell,
    required this.onDestinationSelected,
    this.isExtended = true,
  });

  final StatefulNavigationShell navigationShell;
  final Function(int index) onDestinationSelected;
  final bool isExtended;

  static const double minExtendedWidth = 200;

  @override
  Widget build(BuildContext context) {
    const destinations = [
      NavigationRailDestination(
        icon: Icon(LucideIcons.house),
        label: Text('Dashboard'),
      ),
      NavigationRailDestination(
        // disabled: true,
        icon: Icon(LucideIcons.settings),
        label: Text('Settings'),
      ),
    ];

    return NavigationRail(
      extended: isExtended,
      minExtendedWidth: minExtendedWidth,
      backgroundColor: Colors.transparent,
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: onDestinationSelected,
      labelType: NavigationRailLabelType.none,
      leading: buildLeading(context),
      trailing: buildTrailing(context),
      indicatorColor: context.colorScheme.primary.withValues(alpha: 0.1),
      selectedIconTheme: IconThemeData(color: context.colorScheme.primary),
      unselectedIconTheme: IconThemeData(
        color: context.colorScheme.mutedForeground,
      ),
      destinations: destinations,
    );
  }

  Widget buildLeading(BuildContext context) {
    // final project = context.project;
    return SizedBox(
      width: minExtendedWidth,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 32.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          spacing: 8,
          children: [
            ShadCard(
              height: 48,
              width: 48,
              padding: EdgeInsets.zero,
              child: Center(child: Icon(LucideIcons.box)),
            ),
            AutoSizeText(
              'Assist',
              style: context.textTheme.large,
              minFontSize: 14,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTrailing(BuildContext context) {
    return Container();
  }
}
