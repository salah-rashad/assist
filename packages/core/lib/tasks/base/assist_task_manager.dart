import 'dart:async';
import 'dart:collection';

import 'assist_task.dart';

class AssistTaskManager {
  static final AssistTaskManager _instance = AssistTaskManager._internal();

  factory AssistTaskManager() => _instance;

  AssistTaskManager._internal();

  final Queue<AssistTask> _queue = Queue();
  AssistTask? _currentTask;

  final _currentTaskController = StreamController<AssistTask?>.broadcast();

  Stream<AssistTask?> get currentTaskStream => _currentTaskController.stream;

  void enqueue(AssistTask task) {
    _queue.add(task);
    _runNext();
  }

  void _runNext() {
    if (_currentTask != null || _queue.isEmpty) return;

    final next = _queue.removeFirst();

    // If task is canceled before starting, skip it
    if (next.isCancelled) {
      _runNext();
      return;
    }

    _currentTask = next;
    _currentTaskController.add(_currentTask);

    next.run().then((result) {
      // Handle result as needed (emit event, etc)
    }).whenComplete(() {
      _currentTask = null;
      _currentTaskController.add(null);
      _runNext();
    });
  }

  void cancelCurrentTask() {
    _currentTask?.cancel();
  }

  void cancelQueuedTask(String taskId) {
    _queue.removeWhere((t) {
      if (t.id == taskId) {
        t.cancel();
        return true;
      }
      return false;
    });
  }

  void cancelAll() {
    _currentTask?.cancel();
    for (final task in _queue) {
      task.cancel();
    }
    _queue.clear();
  }
}
