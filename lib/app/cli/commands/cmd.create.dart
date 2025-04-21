import 'dart:io';

import 'package:assist/app/cli/tasks/task.create.dart_project.dart';
import 'package:assist/app/utils/extensions.dart';
import 'package:chalkdart/chalkstrings.dart';
import 'package:path/path.dart' as p;
import 'package:promptly/promptly.dart' hide StringColor, Tint;

import '../../core/enums.dart';
import '../../models/create_dart_project_model.dart';
import '../../services/service.create.dart';
import '../../services/service.version.dart';
import '../../utils/error_handler.dart';
import '../../utils/helpers.dart';

part 'cmd.create.dart.dart';
part 'cmd.create.flutter.dart';

class CreateCommand extends Command<int> {
  CreateCommand() : super('create', 'Create a new Dart/Flutter project.');

  @override
  Future<int> run() async {
    return handleRuntimeErrors(() async {
      final flutterVersion = await VersionService().getFlutterVersion();

      header('Create', message: description);
      info('Default values are indicated by '.gray + '*'.brightGreen);
      line();
      line();
      ProjectType projectType = selectProjectType(flutterVersion);
      final isFlutter = projectType == ProjectType.flutter;
      final isDart = projectType == ProjectType.dart;
      line();

      if (isFlutter) {
        // TODO(salah): implement flutter project creation
        return FlutterCreateProjectService().create();
      } else if (isDart) {
        final template = selectDartTemplate();
        line();
        final projectName = promptProjectName();
        line();
        final projectDir = promptProjectDir(projectName);
        line();
        final shouldForce = selectShouldForce();
        line();
        final shouldRunPubGet = selectShouldRunPubGet();
        line();
        return await createDartProject(
          CreateDartProjectModel(
            projectName: projectName,
            projectDir: projectDir,
            template: template,
            shouldForce: shouldForce,
            shouldRunPubGet: shouldRunPubGet,
          ),
        );
      }

      return ExitCode.success.code;
    });
  }

  ProjectType selectProjectType(String flutterVersion) {
    final projectType = selectOne<ProjectType>(
      'Select project type:',
      choices: ProjectType.values,
      display: (projectType) => projectType.asChoice(flutterVersion),
    );
    return projectType;
  }
}
