import '../base/assist_task.dart';
import '../base/task_event.dart';

class FormatTask extends AssistTask {
  @override
  String get name => 'Code Formatter';

  @override
  Future<TaskEvent> run() async {
    await Future.delayed(Duration(seconds: 3));
    throw UnimplementedError();
  }
}
