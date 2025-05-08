import 'dart:async';

import 'package:assist_core/services/task_manager/task_event.dart';
import 'package:assist_core/services/task_manager/task_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TaskManagerCubit extends Cubit<TaskEvent?> {
  TaskManagerCubit() : super(null) {
    _taskManager = TaskManager(onEvent: emit);
  }

  late final TaskManager _taskManager;
  final popoverController = ShadPopoverController();

  List<Task> get pendingTasks => _taskManager.pendingTasks;

  void submitTask(Task task) {
    _taskManager.enqueue(task);
  }

  void cancelTask(String id) {
    _taskManager.cancelTaskById(id);
  }

  void cancelAll() {
    _taskManager.cancelAll();
  }

  void toggleTasksPopover() {
    popoverController.toggle();
  }

  @override
  Future<void> close() {
    _taskManager.cancelAll();
    popoverController.dispose();
    return super.close();
  }
}
