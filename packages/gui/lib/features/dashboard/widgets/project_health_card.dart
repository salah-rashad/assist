import 'package:assist_gui/core/utils/extensions.dart';
import 'package:assist_gui/features/project/controller/project_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../shared/widgets/status_badge.dart';
import '../../../shared/widgets/status_table.dart';

class ProjectHealthCard extends StatelessWidget {
  const ProjectHealthCard({
    super.key,
    required this.items,
  });

  final List<StatusItem> items;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShadCard(
          title: Text("Status"),
          description: Text("Last check: 2 hours ago"),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: StatusTable(
              items: Map.fromEntries(
                items.map(
                  (item) {
                    final statusWithTooltip = ShadTooltip(
                      builder: (_) => Text(item.description ?? ''),
                      child: item.status,
                    );
                    return MapEntry(
                      item.title,
                      item.description == null
                          ? item.status
                          : statusWithTooltip,
                    );
                  },
                ),
              ),
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
            onPressed: () {
              context.read<ProjectCubit>().runCheckTasks(context);
            },
          ),
        ),
      ],
    );
  }
}

class StatusItem {
  final String title;
  final StatusBadge status;
  final String? description;

  const StatusItem({
    required this.title,
    required this.status,
    this.description,
  });
}
