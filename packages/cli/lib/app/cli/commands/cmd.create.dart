import 'dart:io';

import 'package:assist/app/cli/tasks/task.create.dart_project.dart';
import 'package:assist/app/utils/cli.extensions.dart';
import 'package:assist/app/utils/string_colors.dart';
import 'package:assist_core/constants/enums.dart';
import 'package:assist_core/constants/exceptions.dart';
import 'package:assist_core/models/config/config.base.dart';
import 'package:assist_core/models/config/config.dart_project.dart';
import 'package:assist_core/models/config/config.flutter_project.dart';
import 'package:assist_core/services/service.dart.dart';
import 'package:assist_core/services/service.flutter.dart';
import 'package:path/path.dart' as p;
import 'package:promptly/promptly.dart';

import '../../core/cli.strings.dart';
import '../../utils/cli.helpers.dart';
import '../../utils/error_handler.dart';
import '../components/command_task.dart';
import '../tasks/task.create.flutter_project.dart';

part 'cmd.create.dart.dart';
part 'cmd.create.flutter.dart';

/// Command to create a new Dart/Flutter project
class CreateCommand extends Command<int> {
  CreateCommand() : super('create', 'Create a new Dart/Flutter project.');

  @override
  Future<int> run() async {
    return handleRuntimeErrors(() async {
      final flutterVersion = await FlutterService.version();
      final dartVersion = DartService.version();

      header('Create', message: description);
      info(
        'Default values are indicated by '.cGray + theme.colors.success('*'),
      );
      line();
      line();
      ProjectType projectType = selectProjectType(flutterVersion, dartVersion);
      final isFlutter = projectType == ProjectType.flutter;
      final isDart = projectType == ProjectType.dart;

      if (isFlutter) {
        line();
        final template = selectFlutterTemplate();
        line();
        final projectName = promptProjectName();
        line();
        final projectParentDir = promptProjectParentDir(projectName);
        line();
        final shouldOverwrite = selectShouldOverwrite(
          projectParentDir,
          projectName,
        );
        line();
        final projectDescription = promptProjectDescription();
        line();
        final organization = promptProjectOrganization();
        List<PlatformType> supportedPlatforms = [];
        if (template == FlutterProjectTemplate.app ||
            template == FlutterProjectTemplate.appEmpty ||
            template == FlutterProjectTemplate.plugin) {
          line();
          supportedPlatforms = selectSupportedPlatforms();
        }
        AndroidLanguage? androidLanguage;
        if (supportedPlatforms.contains(PlatformType.Android)) {
          line();
          androidLanguage = selectAndroidLanguage();
        }
        line();
        final shouldRunPubGet = selectShouldRunPubGet();
        line();
        final isOfflineMode = selectIsOfflineMode();
        final config = FlutterProjectConfig(
          projectName: projectName,
          projectParentDir: projectParentDir,
          template: template.value,
          isEmptyApp: template == FlutterProjectTemplate.appEmpty,
          shouldOverwrite: shouldOverwrite,
          description: projectDescription,
          organization: organization,
          platforms:
              supportedPlatforms.map((p) => p.name.toLowerCase()).toList(),
          androidLanguage: androidLanguage?.name.toLowerCase(),
          shouldRunPubGet: shouldRunPubGet,
          isOfflineMode: isOfflineMode,
        );
        promptCommandConfirmation(config);
        line();
        final createTask = CreateFlutterProjectTask(config);
        return await runCreateTask(createTask, config.projectDir);
      } else if (isDart) {
        line();
        final template = selectDartTemplate();
        line();
        final projectName = promptProjectName();
        line();
        final projectParentDir = promptProjectParentDir(projectName);
        line();
        final shouldForce = selectShouldOverwrite(
          projectParentDir,
          projectName,
        );
        line();
        final shouldRunPubGet = selectShouldRunPubGet();
        final config = DartProjectConfig(
          projectName: projectName,
          projectParentDir: projectParentDir,
          template: template.value,
          shouldForce: shouldForce,
          shouldRunPubGet: shouldRunPubGet,
        );
        promptCommandConfirmation(config);
        line();
        final createTask = CreateDartProjectTask(config);
        return await runCreateTask(createTask, config.projectDir);
      }

      return ExitCode.success.code;
    });
  }

  /// Prompt user to select project type
  ProjectType selectProjectType(String flutterVersion, String dartVersion) {
    final projectType = selectOne<ProjectType>(
      'Select project type:',
      choices: ProjectType.values,
      display: (projectType) =>
          projectType.toChoice(flutterVersion, dartVersion),
    );
    return projectType;
  }

  /// Prompt user for project directory
  String promptProjectParentDir(String projectName) {
    final defaultPath = Directory.current.path;

    final parentDir = prompt(
      'Enter parent directory:',
      initialText: defaultPath,
      validator: GenericValidator("Directory does not exist.", (value) {
        return Directory(value).existsSync();
      }),
    );

    return p.normalize(p.absolute(parentDir));
  }

  /// Prompt user if they want to overwrite existing files
  bool selectShouldOverwrite(String projectDir, String projectName) {
    final yes = 'Yes';
    final no = 'No *';

    final fullPath = p.join(projectDir, projectName);
    final directoryExists = Directory(fullPath).existsSync();

    final text =
        'Directory `$projectName` already exists. Overwrite?'.cDarkOrange;

    final formattedPrompt = '\r${text.prefix('⚠️  ')}'.replaceAll('\n', '');

    if (directoryExists) {
      final result = selectOne(
        formattedPrompt,
        choices: [yes, no],
        display: (p0) => p0,
        defaultValue: no,
      );

      if (result == yes) {
        String confirmation = confirmOverwrite(projectName);
        final isValid = confirmation == projectName;

        if (!isValid) {
          throw OverwriteConfirmationFailedException();
        }

        return isValid;
      }
    }

    return false;
  }

  /// Prompt user to confirm the overwrite
  int attempts = 0;

  String confirmOverwrite(String projectName) {
    attempts++;

    final text = 'Type `$projectName` to confirm overwrite:';

    line(message: '\b[$attempts/3]'.italic().darkGray());
    final confirmation = prompt(text);

    final isMaxAttempts = attempts >= 3;
    final isValid = confirmation == projectName;

    if (isValid) {
      return confirmation;
    } else if (isMaxAttempts) {
      error('Maximum attempts reached.');
      return confirmation;
    } else {
      error("Incorrect confirmation.");
      return confirmOverwrite(projectName);
    }
  }

  /// Prompts user to confirm the generated command is correct
  void promptCommandConfirmation(CommandConfigBase config) {
    line();
    line();
    // void l(x) => line(message: '\b$x'.lightGray, prefix: '');
    final commandLineList = config.toCommandLineList();
    for (final l in commandLineList) {
      writeln("\t${l.strip().cLightBlue.italic()}".prefixLine());
    }

    line();
    line();

    final yes = 'Yes, Continue';
    final no = 'No, Cancel';

    final result = selectOne(
      'Verify command. Is this correct?',
      choices: [yes, no],
      defaultValue: yes,
    );

    if (result == no) {
      throw CommandCancelledByUserException();
    }
  }

  String _suggestions(String projectDir) {
    final sb = StringBuffer();
    sb.writeln(
      'Run `${CliStrings.executableName} help` to see available commands.',
    );
    sb.writeln();
    sb.writeln(
      linkLine(
        'file:///$projectDir',
        'Open Project Directory →'.cGray,
      ).prefix('📂 '),
    );
    return sb.toString();
  }

  /// Runs the create task and returns the exit code
  Future<int> runCreateTask(
    CommandTask<Process> task,
    String projectDir,
  ) async {
    final process = await task.run();

    if (process != null) {
      line();
      await process.stdout.listenVerbose();
      await process.stderr.listenErrors();
    }

    final exitCode = await process?.exitCode ?? 0;

    if (exitCode != 0) {
      throw ProjectCreationFailedException(exitCode: exitCode);
    }

    String suggestions = _suggestions(projectDir);

    return finishSuccesfuly(
      'SUCCESS',
      message: 'Project Created! 📦',
      suggestion: suggestions,
    );
  }
}
