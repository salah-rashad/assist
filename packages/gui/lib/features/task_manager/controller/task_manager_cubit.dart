import 'dart:async';

import 'package:assist_core/services/task_manager/task_event.dart';
import 'package:assist_core/services/task_manager/task_manager.dart';
import 'package:bloc/bloc.dart';

class TaskManagerCubit extends Cubit<TaskEvent?> {
  late final TaskManager _taskManager;

  TaskManagerCubit() : super(null) {
    _taskManager = TaskManager(onEvent: emit);
  }

  List<Task> get pendingTasks => _taskManager.pendingTasks;

  void submitTask(Task task) {
    _taskManager.enqueue(task);
  }

  void cancelTask(String id) {
    _taskManager.cancelTaskById(id);
  }

  @override
  Future<void> close() {
    _taskManager.cancelAll();
    return super.close();
  }
}
