import 'dart:io';

import 'package:assist_core/models/config/config.flutter_project.dart';

/// Service for all Flutter related tasks
abstract class FlutterService {
  /// Create a new Flutter project
  static Future<Process> create(FlutterProjectConfig config) async {
    return Process.start(
      config.executableName,
      config.fullArgs,
      workingDirectory: config.projectParentDir,
      runInShell: true,
    );
  }

  /// Get the current installed Flutter version on the system
  static Future<String> version() async {
    try {
      final version = await Process.run('flutter', ['--version']);
      if (version.exitCode != 0) {
        return '';
      }
      final versionString = version.stdout.toString().split('\n')[0].trim();
      final match = RegExp(r'Flutter (.*?) • https').firstMatch(versionString);
      return match?.group(1) ?? '';
    } on Exception catch (_) {
      return '';
    }
  }
}
