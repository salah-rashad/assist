import 'package:assist/app/cli/cli.printer.dart';
import 'package:assist_core/constants/exceptions.cli.dart';
import 'package:promptly/promptly.dart';

/// Handle runtime errors thrown by the app.
///
/// Returns the exit code
Future<int> handleRuntimeErrors(Future<int> Function() runLogic) async {
  try {
    return await runLogic();
  } on CliException catch (error, stackTrace) {
    final exitCode = finishWithError(
      'FAILURE',
      message: error.message,
      stackTrace: stackTrace,
      exitCode: error.exitCode,
    );
    Printer.printSuggestions(error.suggestions);
    return exitCode;
  } catch (e, stackTrace) {
    return finishWithError(
      'Error',
      message: e.toString(),
      stackTrace: stackTrace,
      exitCode: ExitCode.software.code,
    );
  }
}
