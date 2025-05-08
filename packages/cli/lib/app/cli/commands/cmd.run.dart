import 'package:assist/app/cli/cli.printer.dart';
import 'package:assist/app/cli/tasks/task.run.check_pubspec.dart';
import 'package:assist/app/cli/tasks/task.run.launch_app.dart';
import 'package:assist/app/cli/tasks/task.run.path_validation.dart';
import 'package:assist/app/utils/cli.extensions.dart';
import 'package:assist/app/utils/error_handler.dart';
import 'package:assist_core/constants/supported_platform.dart';
import 'package:path/path.dart' as p;
import 'package:promptly/promptly.dart';

/// Command to run the GUI
class RunCommand extends Command<int> {
  RunCommand() : super('run', 'Run a project on Assist GUI.');

  @override
  Future<int> run() async {
    return handleRuntimeErrors(() async {
      final args = argResults?.rest;
      final arg0 = args?.firstOrNull;
      final platform = SupportedPlatform.current;

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

      if (process != null) {
        line();
        await process.stdout.listenVerbose();
        await process.stderr.listenErrors();
      }

      final exitCode = await process?.exitCode ?? ExitCode.success.code;

      if (exitCode != 0) {
        return finishWithError(
          'Failure',
          message: 'Failed to launch GUI on [$platform]',
          exitCode: exitCode,
          stackTrace: StackTrace.current,
        );
      }

      return finishSuccesfuly(
        'Success',
        message: 'GUI Launched on [$platform]',
      );
    });
  }

  @override
  String? get usageFooter => Printer.mainUsageFooter();
}
