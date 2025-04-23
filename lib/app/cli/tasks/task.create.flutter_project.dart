import 'dart:io';

import 'package:promptly/promptly.dart';

import '../../models/config.flutter_project.dart';
import '../../services/service.create.dart';
import '../components/command_task.dart';

class CreateFlutterProjectTask extends CommandTask<Process> {
  CreateFlutterProjectTask(this.config);

  final FlutterProjectConfig config;

  @override
  String get prompt => '⚙️  Run Flutter Create Command';

  @override
  String? get successHint => config.toCommandLineString().italic();

  @override
  String get successTag => '';

  @override
  Future<Process> execute(LoaderState state) async {
    return await FlutterCreateProjectService(config).create();
  }
}
