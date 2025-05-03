import 'package:assist_core/services/task_manager/task_event.dart';
import 'package:assist_core/services/task_manager/task_manager.dart';
import 'package:assist_gui/core/utils/extensions.dart';
import 'package:assist_gui/core/utils/extensions/task.ext.dart';
import 'package:assist_gui/features/project/controller/project_cubit.dart';
import 'package:assist_gui/features/task_manager/controller/task_manager_cubit.dart';
import 'package:assist_gui/shared/widgets/status_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../shared/dialogs/task_result/task_result_details_dialog.dart';

class ProjectStatusCheckCard extends StatelessWidget {
  const ProjectStatusCheckCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProjectCubit>();

    return BlocBuilder<TaskManagerCubit, TaskEvent?>(
      builder: (context, event) {
        return Stack(
          children: [
            ShadCard(
              title: Text("Status"),
              description: Text("Last check: 2 hours ago"),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: StatusTable(
                  items: Map.fromEntries(
                    cubit.checkTasks.map(
                      (item) {
                        final hasDetails = item.isCompleted || item.isFailed;
                        return MapEntry(
                          Text(
                            item.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.small.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ShadGestureDetector(
                            cursor: hasDetails
                                ? SystemMouseCursors.click
                                : MouseCursor.defer,
                            onTap: () {
                              if (hasDetails) {
                                _showTaskResultDetailsDialog(context, item);
                              }
                            },
                            child: item.statusAsWidget(context),
                          ),
                        );
                      },
                    ),
                  ),
                  valueAlignment: AlignmentDirectional.centerEnd,
                ),
              ),
            ),
            if (!cubit.isStatusCheckRunning(context))
              PositionedDirectional(
                top: 16,
                end: 16,
                child: ShadIconButton.ghost(
                  icon: Icon(LucideIcons.refreshCw),
                  foregroundColor: context.colorScheme.mutedForeground,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    cubit.runStatusCheck(context);
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}

_showTaskResultDetailsDialog(BuildContext context, Task task) {
  showShadDialog(
    context: context,
    builder: (context) {
      return TaskResultDetailsDialog(task: task);
    },
  );
}
