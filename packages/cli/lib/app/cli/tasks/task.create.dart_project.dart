import 'dart:io';

import 'package:promptly/promptly.dart';

import '../../models/config.dart_project.dart';
import '../../services/service.dart.dart';
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
