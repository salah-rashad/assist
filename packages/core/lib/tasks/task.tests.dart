import 'dart:io';

import 'package:assist_core/constants/enums.dart';
import 'package:assist_core/services/task_manager/shell_task.dart';

class UnitTestsTask extends ShellTask {
  final String projectPath;
  final ProjectType projectType;

  UnitTestsTask({required this.projectPath, required this.projectType})
      : super(
          projectType == ProjectType.flutter ? 'flutter' : 'dart',
          ['test', '--reporter=failures-only'],
          workingDirectory: projectPath,
        );

  @override
  String get name => 'Unit Tests';

  @override
  String handleResult(ProcessResult result) {
    final output = result.stdout;
    if (result.exitCode != 0) {
      throw output;
    }

    return output.toString();
  }
}
