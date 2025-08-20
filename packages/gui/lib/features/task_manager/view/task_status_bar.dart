import 'package:assist_core/services/task_manager/task_event.dart';
import 'package:assist_gui/core/utils/extensions.dart';
import 'package:assist_gui/features/task_manager/controller/task_manager_cubit.dart';
import 'package:assist_gui/features/task_manager/widgets/running_tasks_list_tiles.dart';
import 'package:assist_gui/shared/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TaskStatusBar extends StatelessWidget {
  const TaskStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskManagerCubit, TaskEvent?>(
      listener: _handleTaskEvent,
      builder: (context, state) {
        final cubit = context.read<TaskManagerCubit>();
        final tasks = cubit.pendingTasks;
        final currentTask = tasks.firstOrNull;

        return ShadPopover(
          controller: cubit.popoverController,
          anchor: ShadAnchor(
            overlayAlignment: Alignment.topRight,
            childAlignment: Alignment.bottomRight,
            // offset: const Offset(-8, -8),
          ),
          popover: (context) => RunningTasksListTiles(),
          child: tasks.isEmpty
              ? ShadTooltip(
                  builder: (_) => Text('No tasks running'),
                  child: ShadIconButton.ghost(
                    icon: Icon(LucideIcons.circleCheckBig),
                    foregroundColor: context.colorScheme.mutedForeground,
                    width: 18,
                    height: 18,
                  ),
                )
              : ShadButton.outline(
                  onPressed: cubit.toggleTasksPopover,
                  height: 18,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    spacing: 8,
                    children: [
                      Text('${currentTask?.name}'),
                      LoadingIndicator(size: 8, strokeWidth: 2)
                    ],
                  ),
                ),
        );
      },
    );
  }

  dynamic _handleTaskEvent(BuildContext context, TaskEvent? event) {
    final task = event?.task;
    if (task == null) return;

    final name = task.name;

    return switch (event) {
      TaskCompleted() => context.showSuccessSonner(name, 'Task completed'),
      TaskCancelled() => context.showErrorSonner(name, 'Task cancelled'),
      TaskFailed() => context.showErrorSonner(name, 'Task failed'),
      _ => null,
    };
  }
}
