import 'package:assist_gui/app/routing/route_names.dart';
import 'package:assist_gui/shared/widgets/quick_action_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DashboardQuickActionsGrid extends StatelessWidget {
  const DashboardQuickActionsGrid({
    super.key,
    required this.canPublish,
    required this.isGitHub,
  });

  final bool canPublish;
  final bool isGitHub;

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 58,
      ),
      children: [
        QuickActionButton(
          icon: Icon(LucideIcons.circleFadingArrowUp),
          label: 'Bump Version'.tr(),
          onPressed: () => context.goNamed(RouteNames.createProject),
        ),
        if (canPublish)
          QuickActionButton(
            icon: Icon(LucideIcons.rocket),
            label: 'actions.publish_package'.tr(),
            onPressed: () => context.goNamed(RouteNames.publishPackage),
          ),
        if (isGitHub)
          QuickActionButton(
            icon: Icon(LucideIcons.workflow),
            label: 'GitHub Workflows'.tr(),
            onPressed: () => context.goNamed(RouteNames.createProject),
          ),
        QuickActionButton(
          icon: Icon(LucideIcons.notebookPen),
          label: 'Edit Changelog'.tr(),
          onPressed: () => context.goNamed(RouteNames.settings),
        ),
        QuickActionButton(
          icon: Icon(LucideIcons.filePen),
          label: 'Edit Pubspec'.tr(),
          onPressed: () => context.goNamed(RouteNames.publishPackage),
        ),
        if (isGitHub)
          QuickActionButton(
            icon: Icon(LucideIcons.github),
            label: 'Github Services'.tr(),
            onPressed: () => context.goNamed(RouteNames.settings),
          ),
      ],
    );
  }
}
