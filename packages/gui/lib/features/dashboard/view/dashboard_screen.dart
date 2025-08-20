import 'package:assist_core/constants/strings.dart';
import 'package:assist_core/services/service.dart.dart';
import 'package:assist_core/services/service.flutter.dart';
import 'package:assist_gui/core/utils/extensions.dart';
import 'package:assist_gui/features/dashboard/widgets/dashboard_quick_actions_grid.dart';
import 'package:assist_gui/features/dashboard/widgets/package_info_header.dart';
import 'package:assist_gui/features/dashboard/widgets/package_links_bar.dart';
import 'package:assist_gui/features/dashboard/widgets/project_status_check_card.dart';
import 'package:assist_gui/features/project/controller/project_cubit.dart';
import 'package:assist_gui/shared/widgets/status_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pubspec = context.pubspec;

    final sdkVersionItems = <Widget, Widget>{
      Text('Flutter'): FutureBuilder(
        future: FlutterService.version(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          return Text(data ?? '...');
        },
      ),
      Text('Dart'): Text(DartService.version()),
    };

    final flutterVersion = pubspec.environment['flutter']?.toString();
    final dartVersion = pubspec.environment['sdk']?.toString();

    final packageSdkVersionItems = <Widget, Widget>{
      if (flutterVersion != null) Text('Flutter'): Text(flutterVersion),
      if (dartVersion != null) Text('Dart'): Text(dartVersion),
    };

    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final pubspec = context.pubspec;
        return SingleChildScrollView(
          primary: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 32,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 350, minWidth: 300),
                child: Column(
                  spacing: 16.0,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(child: ProjectStatusCheckCard()),
                    ShadCard(child: StatusTable(items: sdkVersionItems)),
                    // ShadCard(
                    //     title: Text("Tasks"), child: RunningTasksListTiles()),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ShadButton buildReloadButton(BuildContext context) {
    return ShadButton.secondary(
      size: ShadButtonSize.sm,
      leading: Icon(LucideIcons.refreshCw),
      onPressed: () => context.read<ProjectCubit>().reload(context),
      child: Text('Reload'),
    );
  }
}
