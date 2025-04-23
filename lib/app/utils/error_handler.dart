import 'package:promptly/promptly.dart';

import '../core/exceptions.dart';

/// Handle runtime errors thrown by the app.
///
/// Returns the exit code
Future<int> handleRuntimeErrors(Future<int> Function() runLogic) async {
  try {
    return await runLogic();
  } on CliException catch (error, stackTrace) {
    return finishWithError(
      "FAILURE",
      message: error.message,
      stackTrace: stackTrace,
      exitCode: error.exitCode,
    );
  } catch (e, stackTrace) {
    return finishWithError(
      'Error',
      message: e.toString(),
      stackTrace: stackTrace,
      exitCode: ExitCode.software.code,
    );
  }
}
