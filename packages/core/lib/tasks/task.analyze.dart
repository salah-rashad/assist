import '../services/task_manager/task_manager.dart';

class AnalyzeTask extends Task {
  @override
  String get name => 'analyze';

  @override
  Future<void> execute() async {
    await Future.delayed(Duration(seconds: 5));
  }
}
