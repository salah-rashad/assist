import 'dart:io';

import 'package:assist/app/cli/components/command_task.dart';
import 'package:assist/app/services/service.launch.dart';
import 'package:assist_core/constants/supported_platform.dart';
import 'package:promptly/promptly.dart';

class LaunchAppTask extends CommandTask<Process> {
  LaunchAppTask(this.projectDir, this.platform);

  final String projectDir;
  final SupportedPlatform platform;

  @override
  String get prompt => 'Launch App 🚀';

  @override
  Future<Process> execute(LoaderState state) async {
    final service = LaunchService(projectDir);
    return service.launch();
  }
}
