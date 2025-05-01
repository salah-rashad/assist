import 'dart:async';

import '../base/assist_task.dart';

class AnalyzeTask extends CancellableTask {
  @override
  String get name => 'Code Analyzer';

  @override
  Future<void> runSteps() async {
    await step(() {
      return Future.delayed(Duration(seconds: 3));
    });

    await step(() {
      return Future.delayed(Duration(seconds: 5));
    });
  }
}
