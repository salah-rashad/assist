import 'dart:io';

import '../services/task_manager/task_manager.dart';

class FormatTask extends Task {
  final String projectPath;

  FormatTask({required this.projectPath});

  @override
  String get name => 'Format';

  @override
  Future<void> execute() async {
    final result = await Process.run(
      'dart',
      ['format', projectPath],
      runInShell: true,
    );

    if (result.exitCode != 0) {
      print(result.stderr);
      throw Exception(result.stderr);
    }
  }
}
