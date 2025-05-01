part of 'task_manager_cubit.dart';

@immutable
sealed class TaskManagerState {}

final class TaskManagerIdle extends TaskManagerState {}

final class TaskManagerRunning extends TaskManagerState {}

final class TaskManagerEvent extends TaskManagerState {
  final TaskEvent event;

  TaskManagerEvent(this.event);
}
