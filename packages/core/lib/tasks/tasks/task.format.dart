import 'package:assist_core/tasks/base/assist_task_result.dart';

import '../base/assist_task.dart';

class AnalyzeTask extends AssistTask {
  @override
  String get name => 'Code Formatter';

  @override
  Future<AssistTaskResult> run() async {
    await Future.delayed(Duration(seconds: 3));

    return AssistTaskResult.success('Code formatted.');
  }
}
