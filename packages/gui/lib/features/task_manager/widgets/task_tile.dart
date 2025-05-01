import 'package:assist_core/tasks/base/assist_task.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});

  final AssistTask task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.name),
      leading: task.isRunning
          ? SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                strokeCap: StrokeCap.round,
              ),
            )
          : Icon(LucideIcons.chevronRight, size: 18),
      trailing: ShadTooltip(
        builder: (context) => Text('Cancel'),
        child: ShadIconButton.destructive(
          icon: const Icon(LucideIcons.x, size: 12),
          onPressed: task.cancel,
          width: 18,
          height: 18,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
