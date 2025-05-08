import 'package:assist_core/services/task_manager/task_manager.dart';
import 'package:assist_gui/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TaskRerunButton extends StatelessWidget {
  const TaskRerunButton({super.key, required this.task}) : _isLink = false;
  const TaskRerunButton.link({super.key, required this.task}) : _isLink = true;

  final Task task;
  final bool _isLink;

  ShadButton link(BuildContext context) => ShadButton.link(
        enabled: !task.isRunning,
        size: ShadButtonSize.sm,
        leading: Icon(LucideIcons.refreshCw),
        onPressed: () => context.taskManager.submitTask(task),
        child: Text('Rerun'),
      );

  @override
  Widget build(BuildContext context) {
    if (_isLink) return link(context);
    return ShadButton(
      enabled: !task.isRunning,
      size: ShadButtonSize.sm,
      leading: Icon(LucideIcons.refreshCw),
      onPressed: () => context.taskManager.submitTask(task),
      child: Text('Rerun'),
    );
  }
}
