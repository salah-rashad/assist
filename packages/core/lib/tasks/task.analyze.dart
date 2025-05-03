import 'package:assist_core/services/task_manager/shell_task.dart';

class AnalyzeTask extends ShellTask {
  AnalyzeTask({required String projectPath})
      : super(
          'dart',
          [
            'analyze',
            '--fatal-infos',
            projectPath,
          ],
        );

  @override
  String get name => 'Analyze';
}
