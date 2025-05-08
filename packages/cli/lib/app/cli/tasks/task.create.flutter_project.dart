import 'dart:io';

import 'package:assist/app/cli/components/command_task.dart';
import 'package:assist_core/models/config/config.flutter_project.dart';
import 'package:assist_core/services/service.flutter.dart';
import 'package:promptly/promptly.dart';

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
    return await FlutterService.create(config);
  }
}
