import 'dart:io';

import 'package:path/path.dart' as p;

import '../utils/platform_utils.dart';

class LaunchService {
  const LaunchService(this.projectDir);

  final String projectDir;

  Future<int> launch() async {
    final data = getPlatformExecutable();
    final platform = data.platform;
    final guiExec = data.exec;

    final scriptDir = File(Platform.script.toFilePath()).parent.path;

    final sourcePath = p.join(
      p.dirname(scriptDir),
      'bin',
      'build',
      platform,
      guiExec,
    );

    print(sourcePath);

    final process = await Process.start(
      sourcePath,
      [],
      environment: {"assist_pwd": projectDir},
      runInShell: true,
    );

    if (true) {
      await stdout.addStream(process.stdout);
      await stderr.addStream(process.stderr);
    }

    return process.exitCode;
  }
}
