import '../services/task_manager/task_manager.dart';

class FormatTask extends Task {
  @override
  String get name => 'format';

  @override
  Future<void> execute() async {
    await Future.delayed(Duration(seconds: 3));
    throw Exception("Could not format");
  }
}
