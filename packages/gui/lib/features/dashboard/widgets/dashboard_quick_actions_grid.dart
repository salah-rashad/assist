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
          mainAxisExtent: 58.0,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0),
      children: [
        QuickActionButton(
          icon: Icon(LucideIcons.circleFadingArrowUp),
          label: 'actions.bump_version'.tr(),
          onPressed: () => context.goNamed(RouteNames.bumpVersion),
        ),
        if (canPublish)
          QuickActionButton(
            icon: Icon(LucideIcons.rocket),
            label: 'actions.publish_package'.tr(),
            onPressed: () => context.goNamed(RouteNames.publishPackage),
          ),
        QuickActionButton(
          icon: Icon(LucideIcons.notebookPen),
          label: 'actions.edit_changelog'.tr(),
          onPressed: () => context.goNamed(RouteNames.editChangelog),
        ),
        QuickActionButton(
          icon: Icon(LucideIcons.filePen),
          label: 'actions.edit_pubspec'.tr(),
          onPressed: () => context.goNamed(RouteNames.editPubspec),
        ),
        if (isGitHub)
          QuickActionButton(
            icon: Icon(LucideIcons.workflow),
            label: 'actions.github_workflows'.tr(),
            onPressed: () => context.goNamed(RouteNames.githubWorkflows),
          ),
        if (isGitHub)
          QuickActionButton(
            icon: Icon(LucideIcons.github),
            label: 'actions.github_services'.tr(),
            onPressed: () => context.goNamed(RouteNames.githubServices),
          ),
      ],
    );
  }
}
