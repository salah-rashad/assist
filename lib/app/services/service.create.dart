import 'dart:io';

import '../models/create_dart_project_model.dart';

class DartCreateProjectService {
  DartCreateProjectService({required this.model});

  final CreateDartProjectModel model;

  Future<Process> create() {
    return Process.start(
      'dart',
      model.args,
      workingDirectory: model.projectDir,
      runInShell: true,
    );
  }
}

class FlutterCreateProjectService {
  FlutterCreateProjectService();

  Future<int> create() async {
    throw UnimplementedError(
      "Flutter project creation is not implemented yet.",
    );
  }
}
