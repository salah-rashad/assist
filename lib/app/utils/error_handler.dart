import 'package:promptly/promptly.dart';

import '../core/exceptions.dart';

Future<int> handleRuntimeErrors(Future<int> Function() runLogic) async {
  try {
    return await runLogic();
  } on CliException catch (error, stackTrace) {
    finishWithError(
      "FAILURE",
      message: error.message,
      stackTrace: stackTrace,
      exitCode: error.exitCode,
    );
    return error.exitCode;
  } catch (e, stackTrace) {
    return finishWithError(
      'Error',
      message: e.toString(),
      stackTrace: stackTrace,
      exitCode: ExitCode.software.code,
    );
  }
}
