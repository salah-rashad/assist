import 'package:assist_core/core/constants/strings.dart';
import 'package:assist_core/services/service.dart.dart';
import 'package:assist_core/services/service.flutter.dart';
import 'package:assist_gui/core/utils/extensions.dart';
import 'package:assist_gui/shared/widgets/status_badge.dart';
import 'package:assist_gui/shared/widgets/status_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../project/controller/project_cubit.dart';
import '../widgets/dashboard_quick_actions_grid.dart';
import '../widgets/package_info_header.dart';
import '../widgets/package_links_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pubspec = context.pubspec;

    final healthItems = <String, StatusBadge>{
      "Analyzer": StatusBadge.success(Text("✔")),
      "Formatter": StatusBadge.success(Text("✔")),
      "Tests": StatusBadge.error(Text("✖")),
      "Git Status": StatusBadge.warning(Text("⚠")),
      "Changelog": StatusBadge.normal(Text("MISSING")),
    };

    final sdkVersionItems = <String, Widget>{
      "Flutter": FutureBuilder(
        future: FlutterService.version(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          return Text(data ?? "...");
        },
      ),
      "Dart": Text(DartService.version()),
    };

    final packageSdkVersionItems = <String, Widget>{
      "Flutter": Text(pubspec.environment["flutter"].toString()),
      "Dart": Text(pubspec.environment["sdk"].toString()),
    };

    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final pubspec = context.pubspec;
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 32,
          children: [
            Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PackageInfoHeader(),
                            SizedBox(height: 16),
                            PackageLinksBar(),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          buildReloadButton(context),
                          StatusTable(
                            items: packageSdkVersionItems,
                            padding: EdgeInsets.zero,
                            keyWidth: FixedColumnWidth(80),
                            valueWidth: MaxColumnWidth(
                              FixedColumnWidth(50),
                              FixedColumnWidth(150),
                            ),
                            valueAlignment: AlignmentDirectional.centerEnd,
                          ),
                        ],
                      ),
                    ],
                  ),
                  ShadSeparator.horizontal(),
                  DashboardQuickActionsGrid(
                    canPublish: pubspec.publishTo == null,
                    isGitHub: pubspec.repository?.host == Strings.githubHost,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                spacing: 16.0,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(child: buildStatusCard(context, healthItems)),
                  ShadCard(child: StatusTable(items: sdkVersionItems)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildStatusCard(
    BuildContext context,
    Map<String, StatusBadge> healthItems,
  ) {
    return Stack(
      children: [
        ShadCard(
          title: Text("Status"),
          description: Text("Last check: 2 hours ago"),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: StatusTable(
              items: healthItems,
              valueAlignment: AlignmentDirectional.centerEnd,
            ),
          ),
        ),
        PositionedDirectional(
          top: 16,
          end: 16,
          child: ShadIconButton.ghost(
            icon: Icon(LucideIcons.refreshCw),
            foregroundColor: context.colorScheme.mutedForeground,
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  ShadButton buildReloadButton(BuildContext context) {
    return ShadButton.secondary(
      size: ShadButtonSize.sm,
      leading: Icon(LucideIcons.refreshCw),
      onPressed: () => context.read<ProjectCubit>().reload(),
      child: Text('Reload'),
    );
  }
}
