import 'dart:async';
import 'dart:collection';
import 'dart:developer';

import 'package:assist_core/services/task_manager/task_event.dart';
import 'package:assist_core/services/task_manager/task_result.dart';
import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'task.dart';

typedef OnTaskEvent = void Function(TaskEvent event);

class TaskManager {
  TaskManager({this.onEvent});

  bool _isProcessing = false;
  final _taskQueue = Queue<Task>();
  final OnTaskEvent? onEvent;

  List<Task> get pendingTasks => List.unmodifiable(_taskQueue);

  Task? getTask(String id) => _taskQueue.firstWhereOrNull((t) => t.id == id);
  TaskStatus getStatus(String id) => getTask(id)?.status ?? TaskStatus.idle;
  bool isRunning(String id) => getStatus(id) == TaskStatus.running;
  bool isCancelled(String id) => getStatus(id) == TaskStatus.cancelled;
  bool isCompleted(String id) => getStatus(id) == TaskStatus.completed;

  void enqueue(Task task) {
    if (_taskQueue.contains(task)) return;
    _taskQueue.add(task);
    task._status = TaskStatus.pending;
    onEvent?.call(TaskAdded(task));
    _processNext();
  }

  void _processNext() {
    if (_isProcessing || _taskQueue.isEmpty) return;

    _isProcessing = true;
    final task = _taskQueue.first;

    if (task.isCompleted || task.isCancelled) {
      _completeTask(task);
      return;
    }

    task._status = TaskStatus.running;
    onEvent?.call(TaskStarted(task));

    task
        .run(onEvent: onEvent)
        .value
        .whenComplete(() => _completeTask(task))
        .onError((e, s) => _handleError(e, s, task));
  }

  _handleError(e, s, Task task) {
    if (!task.isErrorOfType(e.runtimeType)) {
      log(
        'Error',
        name: 'TaskManager',
        error: e,
        stackTrace: s,
      );
    }
  }

  void _completeTask(Task task) {
    _taskQueue.remove(task);
    _isProcessing = false;
    _processNext(); // Trigger next task
  }

  void _cancel(Task task) {
    task.cancel();
    onEvent?.call(TaskCancelled(task));
  }

  void cancelTaskById(String id) {
    final task = getTask(id);
    if (task != null) {
      _cancel(task);
    }
  }

  void cancelAll() {
    for (final task in _taskQueue.toList()) {
      _cancel(task);
    }
    _taskQueue.clear();
  }
}
