import 'package:assist_core/models/project.dart';
import 'package:assist_core/services/task_manager/task_manager.dart';
import 'package:assist_core/tasks/task.analyze.dart';
import 'package:assist_core/tasks/task.format.dart';
import 'package:assist_core/tasks/task.pub_get.dart';
import 'package:assist_core/tasks/task.tests.dart';
import 'package:assist_gui/core/utils/extensions.dart';
import 'package:flutter/widgets.dart';

mixin StatusCheckTasks {
  // tasks
  late final PubGetTask pubGetTask;
  late final AnalyzeTask analyzeTask;
  late final FormatTask formatTask;
  late final UnitTestsTask unitTestsTask;

  late final List<Task> checkTasks = [
    pubGetTask,
    analyzeTask,
    formatTask,
    unitTestsTask
  ];

  void initializeCheckTasks(Project project) {
    pubGetTask =
        PubGetTask(projectPath: project.path, projectType: project.projectType);
    analyzeTask = AnalyzeTask(projectPath: project.path);
    formatTask = FormatTask(projectPath: project.path);
    unitTestsTask = UnitTestsTask(
        projectPath: project.path, projectType: project.projectType);
  }

  void runStatusCheck(BuildContext context) {
    for (var task in checkTasks) {
      context.taskManager.submitTask(task);
    }
  }

  bool isStatusCheckRunning(BuildContext context) {
    return checkTasks.any((task) => task.isRunning);
  }
}
