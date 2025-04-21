part of 'cmd.create.dart';

/// 1. Prompt user for project template
DartProjectTemplate selectDartTemplate() {
  final template = selectOne<DartProjectTemplate>(
    'Select template:',
    choices: DartProjectTemplate.values,
    defaultValue: DartProjectTemplate.console,
    display: (template) => template.asChoice(),
  );
  return template;
}

/// 2. Prompt user for project name
String promptProjectName() {
  return prompt(
    'Enter project name:',
    validator: GenericValidator(
      'Invalid dart project name. (ex: my_project)',
      RegExp(r'^[a-z][a-z0-9_]{0,49}$').hasMatch,
    ),
  );
}

/// 3. Prompt user for project directory
String promptProjectDir(String projectName) {
  final homePath = getUserHomePath();

  final parentDir = prompt(
    'Enter parent directory:',
    defaultValue: homePath,
    validator: GenericValidator("Directory does not exist.", (value) {
      return Directory(value).existsSync();
    }),
  );

  return p.normalize(p.absolute(parentDir));
}

/// 4. Prompt user if they want to overwrite existing files
bool selectShouldForce() {
  final yes = 'Yes';
  final no = 'No *';

  final result = selectOne(
    'Overwrite existing files? (if any)',
    choices: [yes, no],
    display: (p0) => p0,
    defaultValue: no,
  );

  return result == yes;
}

/// 5. Prompt user if they want to run `pub get` after project creation
bool selectShouldRunPubGet() {
  final yes = 'Yes *';
  final no = 'No';

  final result = selectOne(
    'Run `pub get` after create?',
    choices: [yes, no],
    display: (p0) => p0,
    defaultValue: yes,
  );

  return result == yes;
}

/// 6. Create dart project
Future<int> createDartProject(CreateDartProjectModel model) async {
  final process = await CreateDartProjectTask(model: model).run();

  if (process != null) {
    line();
    await process.stdout.listenVerbose();
    await process.stderr.listenErrors();
  }

  final exitCode = await process?.exitCode ?? 0;

  if (exitCode != 0) {
    return finishWithError(
      'FAILURE',
      message: 'Project creation failed.',
      exitCode: exitCode,
      stackTrace: StackTrace.current,
    );
  }

  return finishSuccesfuly(
    'SUCCESS',
    message: 'Project created successfully. 🎉',
    // suggestion:
    //     '\r${r('cd $projectName')}'
    //     '\n\r${r('dart run')}',
  );
}
