import 'dart:io';

import 'package:assist_core/services/task_manager/task_manager.dart';

abstract class ShellTask extends Task<String> {
  final String executable;
  final List<String> arguments;
  final String? workingDirectory;

  ShellTask(this.executable, this.arguments, {this.workingDirectory});

  String get fullCommand => '$executable ${arguments.join(' ')}';

  @override
  Future<String> execute() async {
    final result = await Process.run(
      executable,
      arguments,
      workingDirectory: workingDirectory,
      runInShell: true,
    );

    print(result.stdout);

    return handleResult(result);
  }

  String handleResult(ProcessResult result) {
    if (result.exitCode != 0) {
      throw Exception(result.stderr);
    }

    return result.stdout.toString();
  }
}
