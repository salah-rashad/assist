import '../core/enums.dart';

class CreateDartProjectModel {
  const CreateDartProjectModel({
    required this.projectName,
    required this.projectDir,
    required this.template,
    required this.shouldForce,
    required this.shouldRunPubGet,
  });

  final String projectName;
  final String projectDir;
  final DartProjectTemplate template;
  final bool shouldForce;
  final bool shouldRunPubGet;

  List<String> get args => [
    'create',
    projectName,
    '-t',
    template.name,
    if (shouldForce) '--force',
    shouldRunPubGet ? '--pub' : '--no-pub',
  ];

  String toCommandLine() {
    return 'dart ${args.join(' ')}';
  }
}
