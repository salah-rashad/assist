import 'dart:io';

import 'package:assist/cli/cli.printer.dart';
import 'package:promptly/promptly.dart';

import '../core/exceptions.dart';
import '../services/pubspec_service.dart';
import '../utils/error_handler.dart';
import '../utils/platform_utils.dart';

class RunCommand extends Command<int> {
  RunCommand() : super('run', 'Run the GUI.');

  @override
  Future<int> run() async {
    return handleRunErrors(() async {
      final args = argResults?.rest;
      final arg0 = args?.firstOrNull;
      final platform = getPlatformExecutable().platform;

      String projectDir = arg0 ?? '';

      // if no project directory is provided, show usage
      if (projectDir.isEmpty) {
        printUsage();
        return ExitCode.success.code;
      }

      if (['.', './', './.'].contains(projectDir)) {
        projectDir = Directory.current.path;
      }

      header('Run', message: description);
      await task(
        'Validating project path...',
        task: (_) async {
          await checkProjectDirectory(projectDir);
        },
        successMessage:
            'Valid path'
            '\n${theme.prefixLine('"$projectDir"').italic()}',
        failedMessage: '[Failed] Invalid path',
      );
      line();
      await task(
        'Checking `pubspec.yaml`...',
        task: (spinner) async {
          await PubspecService().checkPubspecExists(projectDir);
        },
        successMessage: 'Found `pubspec.yaml` file',
        failedMessage: 'No `pubspec.yaml` file found',
      );
      line();
      await task(
        'Launching App...',
        task: (_) async {
          await Future.delayed(const Duration(seconds: 5));
          // await GUIService(projectDir).launch();
        },
        clear: true,
      );
      finishSuccesfuly('Success', message: 'GUI Launched on [$platform]');
      return ExitCode.success.code;
    });
  }

  Future<void> checkProjectDirectory(String projectDir) async {
    if (!await Directory(projectDir).exists()) {
      throw DirectoryNotFoundException(projectDir);
    }
  }

  //   @override
  //   String get usage => '''
  // $description
  //
  // ##Usage##
  // ${Strings.executableName} run <project_dir>
  // ${Strings.executableName} <project_dir>
  //
  // ##Options##
  // -h, --help    Print this usage information.
  //
  // Run ${Strings.executableName} help to see global options.
  // '''.toColorizedUsage(argParser);

  @override
  String? get usageFooter => Printer.mainUsageFooter();
}
