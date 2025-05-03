// part of 'task_manager_cubit.dart';
//
// @immutable
// sealed class TaskManagerState extends Equatable {
//   final Task? task;
//
//   const TaskManagerState(this.task);
//
//   @override
//   List<Object?> get props => [task];
// }
//
// class TaskManagerInitial extends TaskManagerState {
//   const TaskManagerInitial() : super(null);
// }
//
// class TaskAdded extends TaskManagerState {
//   const TaskAdded(super.task);
// }
//
// class TaskRunning extends TaskManagerState {
//   const TaskRunning(super.task);
// }
//
// class TaskCompleted extends TaskManagerState {
//   const TaskCompleted(super.task);
// }
//
// class TaskCancelled extends TaskManagerState {
//   const TaskCancelled(super.task);
// }
//
// class TaskFailed extends TaskManagerState {
//   final Object error;
//
//   const TaskFailed(super.task, this.error);
//
//   @override
//   List<Object?> get props => [task, error];
// }
