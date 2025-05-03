import 'dart:io';

import 'package:assist_core/constants/enums.dart';

import '../services/task_manager/task_manager.dart';

class UnitTestsTask extends Task {
  final String projectPath;
  final ProjectType projectType;

  UnitTestsTask({required this.projectPath, required this.projectType});

  @override
  String get name => 'Unit Tests';

  @override
  Future<void> execute() async {
    final executable = projectType == ProjectType.flutter ? 'flutter' : 'dart';
    final result = await Process.run(
      executable,
      ['test'],
      workingDirectory: projectPath,
      runInShell: true,
    );

    if (result.exitCode != 0) {
      throw Exception(result.stderr);
    }
  }
}
