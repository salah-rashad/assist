// class CommandDirectoryDetectedException implements Exception {}

import 'package:promptly/promptly.dart';

abstract class CliException implements Exception {
  final String? command;

  int get exitCode;
  // String get title => 'Error';
  String get message => 'Command failed';

  CliException({this.command});

  @override
  String toString() => 'Error: $message';
}

class PubspecNotFoundException extends CliException {
  final String projectDir;

  PubspecNotFoundException(this.projectDir, {super.command});

  @override
  int get exitCode => ExitCode.osFile.code;

  @override
  String get message =>
      'No `pubspec.yaml` file found in directory: $projectDir';
}

class DirectoryNotFoundException extends CliException {
  final String projectDir;

  DirectoryNotFoundException(this.projectDir, {super.command});

  @override
  int get exitCode => ExitCode.osFile.code;

  @override
  String get message => 'Directory not found: $projectDir';
}

class PubspecParseException extends CliException {
  PubspecParseException({super.command});

  @override
  int get exitCode => ExitCode.osFile.code;

  @override
  String get message => 'Unable to parse `pubspec.yaml` file';
}
