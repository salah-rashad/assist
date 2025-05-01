import 'dart:async';
import 'dart:collection';

import 'assist_task.dart';
import 'task_event.dart';

final taskManager = AssistTaskManager.instance;

class AssistTaskManager {
  static final AssistTaskManager instance = AssistTaskManager._internal();
  AssistTaskManager._internal();

  final Queue<AssistTask> _queue = Queue();
  AssistTask? _currentTask;

  final _currentTaskController = StreamController<AssistTask?>.broadcast();
  final _eventController = StreamController<TaskEvent>.broadcast();

  Stream<AssistTask?> get currentTaskStream => _currentTaskController.stream;

  Stream<TaskEvent> get taskEventStream => _eventController.stream;

  /// Returns a read-only view of pending tasks (not yet running)
  List<AssistTask> get pendingTasks => List.unmodifiable(_queue.toList());

  void enqueue(AssistTask task) {
    _queue.add(task);
    _runNext();
    _eventController.add(TaskAdded(task));
  }

  void _runNext() {
    if (_currentTask != null || _queue.isEmpty) return;

    final next = _queue.first;

    if (next.isCancelled) {
      _eventController.add(TaskCancelled(next));
      _runNext();
      return;
    }

    _currentTask = next;
    _currentTaskController.add(_currentTask);

    next.run().then((event) {
      _eventController.add(event);
    }).onError(
      (error, stackTrace) {
        final errorEvent = TaskFailed(_currentTask!, error.toString());
        _eventController.add(errorEvent);
      },
    ).whenComplete(() {
      _queue.removeFirst();
      _currentTask = null;
      _currentTaskController.add(null);
      _runNext();
    });
  }

  void cancelCurrentTask() {
    if (_currentTask != null) {
      _currentTask?.cancel();
      _eventController.add(TaskCancelled(_currentTask!));
    }
  }

  void cancelQueuedTask(String taskId) {
    _queue.removeWhere((t) {
      if (t.id == taskId) {
        t.cancel();
        _eventController.add(TaskCancelled(t));
        return true;
      }
      return false;
    });
  }

  void cancelAll() {
    if (_currentTask != null) {
      _eventController.add(TaskCancelled(_currentTask!));
      _currentTask?.cancel();
    }
    for (final task in _queue) {
      task.cancel();
      _eventController.add(TaskCancelled(task));
    }
    _queue.clear();
  }

  bool isTaskRunning(AssistTask assistTask) {
    return _currentTask?.id == assistTask.id;
  }
}
