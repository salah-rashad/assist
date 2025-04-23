import 'dart:io';

import 'package:assist/app/models/config.flutter_project.dart';

import '../models/config.dart_project.dart';

/// Service to create a new Dart project
class DartCreateProjectService {
  DartCreateProjectService(this.config);

  final DartProjectConfig config;

  Future<Process> create() {
    return Process.start(
      config.executableName,
      config.fullArgs,
      workingDirectory: config.projectParentDir,
      runInShell: true,
    );
  }
}

/// Service to create a new Flutter project
class FlutterCreateProjectService {
  FlutterCreateProjectService(this.config);

  final FlutterProjectConfig config;

  Future<Process> create() async {
    return Process.start(
      config.executableName,
      config.fullArgs,
      workingDirectory: config.projectParentDir,
      runInShell: true,
    );
  }
}
