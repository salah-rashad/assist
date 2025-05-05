import 'package:assist_core/services/task_manager/task_manager.dart';
import 'package:assist_gui/core/utils/extensions.dart';
import 'package:assist_gui/shared/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final isRunning = task.isRunning;
    final isCancelled = task.isCancelled;

    return ListTile(
      enabled: !isCancelled,
      title: Text(task.name),
      subtitle: Text(task.status.name),
      leading: isRunning
          ? LoadingIndicator()
          : Icon(LucideIcons.chevronRight, size: 18),
      trailing: ShadTooltip(
        builder: (context) => Text('Cancel'),
        child: ShadIconButton.destructive(
          enabled: !isCancelled,
          icon: const Icon(LucideIcons.x, size: 12),
          onPressed: () {
            context.taskManager.cancelTask(task.id);
          },
          width: 18,
          height: 18,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
