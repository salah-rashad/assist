import 'dart:io';

import 'package:assist_core/services/task_manager/task_manager.dart';

abstract class ShellTask<T> extends Task<T, T> {
  final String executable;
  final List<String> arguments;
  final String? workingDirectory;

  ShellTask(this.executable, this.arguments, {this.workingDirectory});

  String get fullCommand => '$executable ${arguments.join(' ')}';

  @override
  Future<T> execute() async {
    final result = await Process.run(
      executable,
      arguments,
      workingDirectory: workingDirectory,
      runInShell: true,
    );

    return handleResult(result);
  }

  T handleResult(ProcessResult result) {
    final output = result.stdout;
    final error = result.stderr;

    if (result.exitCode != 0) {
      throw '$output\n$error';
    }

    return result.stdout;
  }

  @override
  bool isErrorOfType(Type type) {
    return super.isErrorOfType(type) || type == String;
  }
}
