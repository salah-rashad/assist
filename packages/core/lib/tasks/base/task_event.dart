import 'package:assist_core/tasks/base/assist_task.dart';

abstract class TaskEvent {
  final String taskId;
  final DateTime timestamp = DateTime.now();
  final String name;
  final String? message;

  TaskEvent(AssistTask task, {this.message})
      : taskId = task.id,
        name = task.name;
}

class TaskAdded extends TaskEvent {
  TaskAdded(super.task);
}

class TaskSuccess extends TaskEvent {
  TaskSuccess(super.task) : super(message: task.successMessage);
}

class TaskFailed extends TaskEvent {
  final Object? error;

  TaskFailed(super.task, this.error) : super(message: error?.toString() ?? '');
}

class TaskCancelled extends TaskEvent {
  TaskCancelled(super.task) : super(message: 'Cancelled by user.');
}

// class TaskProgress extends TaskEvent {
//   final String message;
//   const TaskProgress(super.taskId, this.message);
// }
