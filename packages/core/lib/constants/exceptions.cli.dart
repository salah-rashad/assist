import 'package:io/io.dart';
import 'package:meta/meta.dart';

/// Exception thrown when a command fails
abstract class CliException implements Exception {
  final String? command;
  final int? _exitCode;
  final List<String> suggestions;

  @mustCallSuper
  int? get exitCode => _exitCode;

  // String get title => 'Error';
  String get message => 'Command failed';

  CliException({
    required this.command,
    required int? exitCode,
    required List<String>? suggestions,
  })  : _exitCode = exitCode,
        suggestions = suggestions ?? [];

  @override
  String toString() => 'Error: $message';
}

/// Thrown when the `pubspec.yaml` file is not found
class PubspecNotFoundException extends CliException {
  final String projectDir;

  PubspecNotFoundException(this.projectDir,
      {super.command, super.exitCode, super.suggestions});

  @override
  int? get exitCode => super.exitCode ?? ExitCode.osFile.code;

  @override
  String get message =>
      'No `pubspec.yaml` file found in directory: $projectDir';
}

/// Thrown when a directory is not found
class DirectoryNotFoundException extends CliException {
  final String projectDir;

  DirectoryNotFoundException(this.projectDir,
      {super.command, super.exitCode, super.suggestions});

  @override
  int get exitCode => super.exitCode ?? ExitCode.osFile.code;

  @override
  String get message => 'Directory not found: $projectDir';
}

/// Thrown when the `pubspec.yaml` file cannot be parsed
class PubspecParseException extends CliException {
  PubspecParseException({super.command, super.exitCode, super.suggestions});

  @override
  int get exitCode => super.exitCode ?? ExitCode.osFile.code;

  @override
  String get message => 'Unable to parse `pubspec.yaml` file';
}

/// Thrown when a command is cancelled by the user
class CommandCancelledByUserException extends CliException {
  CommandCancelledByUserException(
      {super.command, super.exitCode, super.suggestions});

  @override
  int get exitCode => super.exitCode ?? ExitCode.usage.code;

  @override
  String get message => 'Command cancelled by user';
}

/// Thrown when the overwrite confirmation fails
class OverwriteConfirmationFailedException extends CliException {
  OverwriteConfirmationFailedException(
      {super.command, super.exitCode, super.suggestions});

  @override
  int get exitCode => super.exitCode ?? ExitCode.usage.code;

  @override
  String get message => 'Overwrite confirmation failed. Please try again.';
}

/// Thrown when the project creation fails
class ProjectCreationFailedException extends CliException {
  ProjectCreationFailedException(
      {super.command, super.exitCode, super.suggestions});

  @override
  int get exitCode => super.exitCode ?? ExitCode.cantCreate.code;

  @override
  String get message => 'Project creation failed. Please check the logs.';
}

class LaunchAppFailedException extends CliException {
  LaunchAppFailedException({super.command, super.exitCode, super.suggestions});

  @override
  int get exitCode => super.exitCode ?? ExitCode.software.code;

  @override
  String get message => 'Executable not found.';
}
