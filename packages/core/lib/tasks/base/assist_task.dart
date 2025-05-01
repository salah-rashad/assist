import 'dart:async';

import 'package:assist_core/tasks/base/assist_task_manager.dart';
import 'package:assist_core/tasks/base/task_event.dart';
import 'package:uuid/uuid.dart';

abstract class AssistTask {
  String get name;

  final String id = Uuid().v1(); // unique id (time-based)

  bool _isCancelled = false;
  bool get isCancelled => _isCancelled;

  String get successMessage => 'Task completed successfully';

  bool get isRunning => taskManager.isTaskRunning(this);

  void cancel() {
    _isCancelled = true;
    onCancelled(); // optional per-task override
  }

  /// Optionally override this in subclasses
  void onCancelled() {}

  Future<TaskEvent> run();

  /// Use in tasks to safely stop:
  bool get shouldStop => _isCancelled;
}

abstract class CancellableTask extends AssistTask {
  final Completer<TaskEvent> _completer = Completer<TaskEvent>();

  CancellableTask();

  /// Exposes result externally for UI/logs/etc
  Future<TaskEvent> get result => _completer.future;

  /// You override this with your actual logic
  Future<void> runSteps();

  @override
  Future<TaskEvent> run() async {
    if (shouldStop) {
      _completer.complete(TaskCancelled(this));
      return _completer.future;
    }

    try {
      await runSteps();
      final result = TaskSuccess(this);
      if (!_completer.isCompleted) {
        _completer.complete(result);
      }
      return result;
    } on TaskCancelled {
      final error = TaskCancelled(this);
      if (!_completer.isCompleted) {
        _completer.complete(error);
      }
      return error;
    } catch (e) {
      final error = TaskFailed(this, e.toString());
      if (!_completer.isCompleted) {
        _completer.complete(error);
      }
      return error;
    }
  }

  @override
  void cancel() {
    _isCancelled = true;
    onCancelled();
    if (!_completer.isCompleted) {
      _completer.complete(TaskCancelled(this));
    }
  }

  /// Cancel-aware delay
  Future<void> wait(Duration d) async {
    final interval = Duration(milliseconds: 100);
    final steps = d.inMilliseconds ~/ interval.inMilliseconds;
    for (int i = 0; i < steps; i++) {
      if (shouldStop) throw TaskCancelled(this);
      await Future.delayed(interval);
    }
  }

  /// Cancel-safe wrapper for each async step
  Future<T> step<T>(Future<T> Function() action) async {
    if (shouldStop) throw TaskCancelled(this);
    return await action();
  }
}
