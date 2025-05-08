import 'dart:io';

import 'package:assist/app/utils/cli.extensions.dart';
import 'package:assist/main.dart';
import 'package:assist_core/constants/exceptions.cli.dart';
import 'package:assist_core/constants/strings.dart';
import 'package:assist_core/constants/supported_platform.dart';

/// Service for launching the GUI
class LaunchService {
  const LaunchService(this.projectDir);

  final String projectDir;

  /// Launches the GUI
  Future<Process> launch() async {
    final platform = SupportedPlatform.current;
    final guiExecPath = platform.getGuiExecutablePath();

    if (!await File(guiExecPath).exists()) {
      throw LaunchAppFailedException(suggestions: [
        'Make sure you have installed the GUI',
        'Run `${app.executableName} install` to install the GUI.',
      ]);
    }

    return await Process.start(
      guiExecPath,
      [projectDir],
      environment: {EnvVarKeys.pwd: projectDir},
      runInShell: true,
    );
  }
}
