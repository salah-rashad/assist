import 'package:uuid/uuid.dart';

import 'assist_task_result.dart';

abstract class AssistTask {
  final String id = Uuid().v1(); // unique id (time-based)
  String get name;

  bool _isCancelled = false;

  bool get isCancelled => _isCancelled;

  void cancel() {
    _isCancelled = true;
    onCancelled(); // optional per-task override
  }

  /// Optionally override this in subclasses
  void onCancelled() {}

  Future<AssistTaskResult> run();

  /// Use in tasks to safely stop:
  bool get shouldStop => _isCancelled;
}
