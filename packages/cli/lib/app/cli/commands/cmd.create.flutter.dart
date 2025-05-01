part of 'cmd.create.dart';

/// Prompt user for project template
FlutterProjectTemplate selectFlutterTemplate() {
  final template = selectOne(
    'Select template:',
    choices: FlutterProjectTemplate.values,
    defaultValue: FlutterProjectTemplate.defaultChoice,
    display: (template) => template.toChoice(),
  );
  return template;
}

/// Prompt user for project description
String promptProjectDescription() {
  return prompt('Enter project description:');
}

/// Prompt user for project organization (e.g. com.example)
String promptProjectOrganization() {
  return prompt(
    'Enter project organization:',
    defaultValue: 'com.example',
    validator: GenericValidator(
      'Invalid organization name. (ex: com.example)',
      RegExp(r'^[a-z]+(\.[a-z][a-z0-9]*)+$').hasMatch,
    ),
  );
}

/// Prompt user to select Flutter supported platforms
List<PlatformType> selectSupportedPlatforms() {
  return selectAny(
    'Select supported platforms:',
    choices: PlatformType.values,
    defaultValues: PlatformType.values,
    display: (platform) => platform.name,
  );
}

/// Prompt user to select Android language
AndroidLanguage selectAndroidLanguage() {
  return selectOne(
    'Select Android language:',
    choices: AndroidLanguage.values,
    defaultValue: AndroidLanguage.defaultLanguage,
    display: (language) => language.toChoice(),
  );
}

/// Prompt user if they want to run `pub get` in offline mode
bool selectIsOfflineMode() {
  final yes = 'Yes';
  final no = 'No *';

  final result = selectOne(
    'Run `pub get` in offline mode?  (Uses cached packages)',
    choices: [yes, no],
    defaultValue: no,
  );

  return result == yes;
}
