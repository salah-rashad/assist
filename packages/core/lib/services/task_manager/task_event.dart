import 'package:assist_core/services/task_manager/task_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class TaskEvent extends Equatable {
  final Task task;
  final DateTime time = DateTime.now();

  TaskEvent(this.task);

  @override
  List<Object?> get props => [task, time];
}

class TaskAdded extends TaskEvent {
  TaskAdded(super.task);
}

class TaskStarted extends TaskEvent {
  TaskStarted(super.task);
}

class TaskCancelled extends TaskEvent {
  TaskCancelled(super.task);
}

class TaskCompleted extends TaskEvent {
  TaskCompleted(super.task);
}

class TaskFailed extends TaskEvent {
  final Object? error;
  final StackTrace? stackTrace;

  TaskFailed(super.task, this.error, [this.stackTrace]);

  @override
  List<Object?> get props => [...super.props, error, stackTrace];
}
