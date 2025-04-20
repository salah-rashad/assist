import 'dart:io';

import 'package:promptly/promptly.dart';

import '../../models/create_dart_project_model.dart';
import '../../services/service.create.dart';
import 'command_task.dart';

class CreateDartProjectTask extends CommandTask<Process> {
  CreateDartProjectTask({required this.model});

  final CreateDartProjectModel model;

  @override
  String get prompt => '📦 Run Dart Create Project';

  @override
  String? get successHint => model.toCommandLine().italic();

  @override
  Future<Process> execute(LoaderState state) async {
    return await DartCreateProjectService(model: model).create();
  }
}
