import 'dart:io';

import 'package:assist_core/models/config/config.dart_project.dart';
import 'package:assist_core/services/service.dart.dart';
import 'package:promptly/promptly.dart';

import '../components/command_task.dart';

class CreateDartProjectTask extends CommandTask<Process> {
  CreateDartProjectTask(this.config);

  final DartProjectConfig config;

  @override
  String get prompt => '⚙️  Run Dart Create Command';

  @override
  String? get successHint => config.toCommandLineString().italic();

  @override
  String get successTag => '';

  @override
  Future<Process> execute(LoaderState state) async {
    return await DartService.create(config);
  }
}
