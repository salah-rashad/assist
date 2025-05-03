part of 'task_manager.dart';

enum TaskStatus { idle, pending, running, completed, cancelled, failed }

abstract class Task<T> {
  /// The operation used to execute the task
  CancelableOperation<T>? _operation;

  /// The result of the task
  Future<T?> get result => Future.value(_operation?.valueOrCancellation());

  /// The error thrown by the task
  Object? error;

  /// unique task id (UUID v1 time based)
  final String id = Uuid().v1();

  /// The current status of the task
  TaskStatus _status = TaskStatus.idle;

  TaskStatus get status => _status;

  bool get isIdle => _status == TaskStatus.idle;
  bool get isPending => _status == TaskStatus.pending;
  bool get isRunning => _status == TaskStatus.running;
  bool get isCompleted => _status == TaskStatus.completed;
  bool get isCancelled => _status == TaskStatus.cancelled;
  bool get isFailed => _status == TaskStatus.failed;

  String get name;

  /// The logic to execute the task.
  /// Shouldn't be called directly but rather through [run]
  @protected
  Future<T> execute();

  /// Runs the task operation and returns the result
  Future<T?> run({OnTaskEvent? onEvent, void Function()? onComplete}) {
    _operation = CancelableOperation.fromFuture(execute())
      ..then((value) {
        error = null;
        _status = TaskStatus.completed;
        onEvent?.call(TaskCompleted(this));
      }, onError: (error, stackTrace) {
        this.error = error;
        if (status != TaskStatus.cancelled) {
          _status = TaskStatus.failed;
          onEvent?.call(TaskFailed(this, error, stackTrace));
        }
      }, onCancel: () {
        error = null;
        if (status != TaskStatus.cancelled) {
          _status = TaskStatus.cancelled;
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
    _status = TaskStatus.cancelled;
    _operation?.cancel();
  }
}
