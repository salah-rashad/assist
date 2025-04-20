import 'package:assist/app/utils/extensions.dart';
import 'package:path/path.dart' as p;
import 'package:promptly/promptly.dart';

import '../../utils/error_handler.dart';
import '../../utils/platform_utils.dart';
import '../cli.printer.dart';
import '../tasks/task.run.check_pubspec.dart';
import '../tasks/task.run.launch_app.dart';
import '../tasks/task.run.path_validation.dart';

class RunCommand extends Command<int> {
  RunCommand() : super('run', 'Run the GUI.');

  @override
  Future<int> run() async {
    return handleRunErrors(() async {
      final args = argResults?.rest;
      final arg0 = args?.firstOrNull;
      final platform = getPlatformExecutable().platform;

      String projectDir = arg0 ?? '';
      projectDir = p.normalize(p.absolute(projectDir));

      // if no project directory is provided, show usage
      if (projectDir.isEmpty) {
        printUsage();
        return ExitCode.success.code;
      }

      header('Run', message: description);

      await PathValidationTask(projectDir).run();
      line();
      await CheckPubspecTask(projectDir).run();
      line();
      final process = await LaunchAppTask(projectDir, platform).run();

      finishSuccesfuly('Success', message: 'GUI Launched on [$platform]');

      if (process != null) {
        line();
        await process.stdout.asLines(
          (data) => message(data, style: MessageStyle.verbose),
        );
        await process.stderr.asLines(
          (data) => message(data, style: MessageStyle.error),
        );
      }

      final exitCode = await process?.exitCode ?? 0;

      if (exitCode != 0) {
        return finishWithError(
          'Failure',
          message: 'Failed to launch GUI on [$platform]',
          exitCode: exitCode,
          stackTrace: StackTrace.current,
        );
      }

      return exitCode;
    });
  }

  @override
  String? get usageFooter => Printer.mainUsageFooter();
}
