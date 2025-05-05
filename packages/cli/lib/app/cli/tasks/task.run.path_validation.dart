import 'dart:io';

import 'package:assist/app/cli/components/command_task.dart';
import 'package:assist_core/constants/exceptions.cli.dart';
import 'package:promptly/promptly.dart';

class PathValidationTask extends CommandTask {
  PathValidationTask(this.projectDir);

  final String projectDir;

  @override
  String get prompt => 'Validate path';

  @override
  String get successTag => '[Found]';

  @override
  String get failedTag => '[Not found]';

  @override
  String get successHint => projectDir.italic();

  @override
  Future<void> execute(LoaderState state) async {
    if (!await Directory(projectDir).exists()) {
      throw DirectoryNotFoundException(projectDir);
    }
  }
}
