part of 'task_manager.dart';

enum TaskStatus { idle, pending, running, completed, cancelled, failed }

abstract class Task<T, E> {
  /// unique task id (UUID v1 time based)
  final String id = Uuid().v1();

  /// The operation used to execute the task
  CancelableOperation<T>? _operation;

  /// The result of the task if completed
  /// Contains the value, error and stack trace
  TaskResult<T, E>? result;

  TaskStatus _status = TaskStatus.idle;

  /// The current status of the task
  TaskStatus get status => _status;

  bool get isIdle => _status == TaskStatus.idle;
  bool get isPending => _status == TaskStatus.pending;
  bool get isRunning => _status == TaskStatus.running;
  bool get isCompleted => _status == TaskStatus.completed;
  bool get isCancelled => _status == TaskStatus.cancelled;
  bool get isFailed => _status == TaskStatus.failed;

  /// The result of the task as a future
  Future<T?> get resultAsync => Future.value(_operation?.valueOrCancellation());

  String get name;

  /// The logic to execute the task.
  /// Shouldn't be called directly but rather through [run]
  @protected
  Future<T> execute();

  /// Runs the task operation and returns the result
  CancelableOperation<T> run({OnTaskEvent? onEvent}) {
    if (_operation != null) {
      _operation?.cancel();
      _operation = null;
    }

    void onValue(T value) {
      result = TaskResult(value: value);
      _status = TaskStatus.completed;
      onEvent?.call(TaskCompleted(this));
    }

    void onError(error, StackTrace stackTrace) {
      if (status != TaskStatus.cancelled) {
        if (error is E) {
          result = TaskResult(error: error, stackTrace: stackTrace);
        }

        _status = TaskStatus.failed;
        onEvent?.call(TaskFailed(this, error, stackTrace));
      }
    }

    void onCancel() {
      result = null;
      if (status != TaskStatus.cancelled) {
        _status = TaskStatus.cancelled;
        onEvent?.call(TaskCancelled(this));
      }
    }

    result = null;
    _operation = CancelableOperation.fromFuture(execute())
      ..then(
        onValue,
        onError: onError,
        onCancel: onCancel,
      );

    return _operation!;
  }

  /// Manually cancel the task
  void cancel() {
    _status = TaskStatus.cancelled;
    _operation?.cancel();
  }

  bool isErrorOfType(Type type) {
    return type == E;
  }
}
