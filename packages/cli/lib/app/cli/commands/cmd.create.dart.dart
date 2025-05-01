part of 'cmd.create.dart';

/// Prompt user for project template
DartProjectTemplate selectDartTemplate() {
  final template = selectOne(
    'Select template:',
    choices: DartProjectTemplate.values,
    defaultValue: DartProjectTemplate.defaultChoice,
    display: (template) => template.toChoice(),
  );
  return template;
}

/// Prompt user for project name
String promptProjectName() {
  return prompt(
    'Enter project name:',
    validator: GenericValidator(
      'Invalid dart project name. (ex: my_project)',
      RegExp(r'^[a-z][a-z0-9_]{0,49}$').hasMatch,
    ),
  );
}

/// Prompt user if they want to run `pub get` after project creation
bool selectShouldRunPubGet() {
  final yes = 'Yes *';
  final no = 'No';

  final result = selectOne(
    'Run `pub get` after create?',
    choices: [yes, no],
    defaultValue: yes,
  );

  return result == yes;
}
