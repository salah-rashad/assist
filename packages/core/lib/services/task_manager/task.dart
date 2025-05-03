part of 'task_manager.dart';

enum TaskStatus { idle, pending, running, completed, cancelled, failed }

abstract class Task<T> {
  /// The operation used to execute the task
  CancelableOperation<T>? _operation;

  /// unique task id (UUID v1 time based)
  final String id = Uuid().v1();
  TaskStatus status = TaskStatus.idle;

  bool get isIdle => status == TaskStatus.idle;
  bool get isPending => status == TaskStatus.pending;
  bool get isRunning => status == TaskStatus.running;
  bool get isCompleted => status == TaskStatus.completed;
  bool get isCancelled => status == TaskStatus.cancelled;
  bool get isFailed => status == TaskStatus.failed;

  String get name;

  /// The logic to execute the task
  ///
  /// Shouldn't be called directly but rather through [run]
  @protected
  Future<T> execute();

  /// Runs the task operation and returns the result
  Future<T?> run({OnTaskEvent? onEvent, void Function()? onComplete}) {
    _operation = CancelableOperation.fromFuture(execute())
      ..then((_) {
        status = TaskStatus.completed;
        onEvent?.call(TaskCompleted(this));
      }, onError: (error, stackTrace) {
        if (status != TaskStatus.cancelled) {
          status = TaskStatus.failed;
          onEvent?.call(TaskFailed(this, error, stackTrace));
        }
      }, onCancel: () {
        if (status != TaskStatus.cancelled) {
          status = TaskStatus.cancelled;
          onEvent?.call(TaskCancelled(this));
        }
      }).value.whenComplete(
        () {
          onComplete?.call();
        },
      );

    return _operation!.valueOrCancellation();
  }

  /// Manually cancel the task
  void cancel() {
    status = TaskStatus.cancelled;
    _operation?.cancel();
  }
}
