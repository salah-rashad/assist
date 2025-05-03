import 'dart:io';

import '../constants/enums.dart';
import '../services/task_manager/task_manager.dart';

class PubGetTask extends Task {
  final String projectPath;
  final ProjectType? projectType;

  PubGetTask({required this.projectPath, required this.projectType});

  @override
  String get name => 'Pub Get';

  @override
  Future<void> execute() async {
    final executable = projectType == ProjectType.flutter ? 'flutter' : 'dart';

    final result = await Process.run(
      executable,
      ['pub', 'get'],
      workingDirectory: projectPath,
      runInShell: true,
    );

    if (result.exitCode != 0) {
      throw Exception(result.stderr);
    }
  }
}
