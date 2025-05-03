import 'package:assist_core/services/task_manager/task_event.dart';
import 'package:assist_gui/core/utils/extensions.dart';
import 'package:flutter/widgets.dart';

handleTaskEvent(BuildContext context, TaskEvent? event) {
  final task = event?.task;
  if (task == null) return;

  final name = task.name;

  final _ = switch (event) {
    TaskCompleted() => context.showSuccessSonner(name, "Task completed"),
    TaskCancelled() => context.showErrorSonner(name, "Task cancelled"),
    TaskFailed() => context.showTaskErrorSonner(task, event.error),
    _ => null,
  };
}
