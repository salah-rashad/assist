import 'dart:async';

import 'package:assist_core/tasks/base/assist_task.dart';
import 'package:assist_core/tasks/base/assist_task_manager.dart';
import 'package:assist_core/tasks/base/task_event.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'task_manager_state.dart';

class TaskManagerCubit extends Cubit<TaskManagerState> {
  StreamSubscription? _currentTaskStreamSub;
  StreamSubscription? _taskEventStreamSub;

  TaskManagerCubit() : super(TaskManagerIdle()) {
    _currentTaskStreamSub = taskManager.currentTaskStream.listen((task) {
      if (task == null) {
        emit(TaskManagerIdle());
      } else {
        emit(TaskManagerRunning());
      }
    });

    _taskEventStreamSub = taskManager.taskEventStream.listen((event) {
      emit(TaskManagerEvent(event));
    });
  }

  List<AssistTask> get pending => taskManager.pendingTasks;

  void submitTask(AssistTask task) {
    taskManager.enqueue(task);
  }

  void cancelCurrent() {
    taskManager.cancelCurrentTask();
  }

  void cancelById(String id) {
    taskManager.cancelQueuedTask(id);
  }

  @override
  Future<void> close() {
    _currentTaskStreamSub?.cancel();
    _taskEventStreamSub?.cancel();
    return super.close();
  }
}
