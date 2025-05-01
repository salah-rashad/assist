import 'dart:io';

import 'package:promptly/promptly.dart';

import '../components/command_task.dart';

class LaunchAppTask extends CommandTask<Process> {
  LaunchAppTask(this.projectDir, this.platform);

  final String projectDir;
  final String platform;

  @override
  String get prompt => 'Launch App 🚀';

  @override
  Future<Process> execute(LoaderState state) async {
    return Future.delayed(Duration(seconds: 3));
    // final process = await Process.start(
    //   'flutter',
    //   ['run', '-d', platform],
    //   workingDirectory: projectDir,
    //   runInShell: true,
    // );
    //
    // return process;
  }
}
