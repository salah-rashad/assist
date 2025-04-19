import 'package:promptly/promptly.dart';

import '../core/exceptions.dart';

Future<int> handleRunErrors(Future<int> Function() runLogic) async {
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
    finishWithError('Error', message: error.toString(), stackTrace: stackTrace);
    return ExitCode.software.code;
  }
}
