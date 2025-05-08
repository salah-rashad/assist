import 'package:assist_core/services/task_manager/shell_task.dart';

class FormatTask extends ShellTask {
  final String projectPath;

  FormatTask({required this.projectPath})
      : super('dart', [
          'format',
          '--output=none',
          '--set-exit-if-changed',
          projectPath,
        ]);

  @override
  String get name => 'Format';
}
