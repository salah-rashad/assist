import 'dart:io';

import '../services/task_manager/task_manager.dart';

class AnalyzeTask extends Task {
  final String projectPath;

  AnalyzeTask({required this.projectPath});

  @override
  String get name => 'Analyze';

  @override
  Future<void> execute() async {
    final result = await Process.run(
      'dart',
      ['analyze', projectPath],
      runInShell: true,
    );

    if (result.exitCode != 0) {
      throw Exception(result.stderr);
    }
  }
}
