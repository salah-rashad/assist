import 'package:path/path.dart' as p;

import 'config.base.dart';

/// Configuration for `dart create` command
class DartProjectConfig extends CommandConfigBase {
  const DartProjectConfig({
    required this.projectName,
    required this.projectParentDir,
    required this.template,
    required this.shouldForce,
    required this.shouldRunPubGet,
  });

  /// Project name, used also as project directory name
  final String projectName;

  /// Project's parent directory path where the project will be created
  final String projectParentDir;

  /// Project template name. See: [DartProjectTemplate]
  /// - Flag: `--template=...`
  final String template;

  /// Should overwrite existing project directory
  /// - Flag: `--force`
  final bool shouldForce;

  /// Should get dependencies after project creation
  /// - Flag: `--pub` or `--no-pub`
  final bool shouldRunPubGet;

  @override
  String get executableName => 'dart';

  @override
  String get commandName => 'create';

  @override
  List<String> get args => [
    projectName,
    '--template=$template',
    if (shouldForce) '--force',
    shouldRunPubGet ? '--pub' : '--no-pub',
  ];

  String get projectDir => p.join(projectParentDir, projectName);
}
