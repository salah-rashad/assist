import 'dart:io';

import '../models/config.dart_project.dart';

/// Service for all Dart related tasks
abstract class DartService {
  /// Create a new Dart project
  static Future<Process> create(DartProjectConfig config) {
    return Process.start(
      config.executableName,
      config.fullArgs,
      workingDirectory: config.projectParentDir,
      runInShell: true,
    );
  }

  /// Get the current installed Dart version on the system
  static String version() {
    final version = Platform.version;
    final match = RegExp(r'^([\w\.-]+ \(\w+\))').firstMatch(version);
    return match?.group(1) ?? version.split(' ')[0];
  }
}
