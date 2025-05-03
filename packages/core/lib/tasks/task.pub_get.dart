import 'package:assist_core/services/task_manager/shell_task.dart';

import '../constants/enums.dart';

class PubGetTask extends ShellTask {
  final String projectPath;
  final ProjectType? projectType;

  PubGetTask({required this.projectPath, required this.projectType})
      : super(
          projectType == ProjectType.flutter ? 'flutter' : 'dart',
          ['pub', 'get'],
          workingDirectory: projectPath,
        );

  @override
  String get name => 'Pub Get';
}
