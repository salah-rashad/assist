import 'dart:async';

import 'package:assist/app/utils/extensions.dart';
import 'package:promptly/promptly.dart';

import '../services/service.version.dart';

enum ProjectType {
  flutter,
  dart;

  String asChoice(String flutterVersion) {
    final version = switch (this) {
      ProjectType.flutter => flutterVersion,
      ProjectType.dart => VersionService().getDartVersion(),
    };
    final line = name.titleCase.padRight(20) + version;
    return line.truncateChoice();
  }

  FutureOr<String> getVersion() async => switch (this) {
    ProjectType.flutter => await VersionService().getFlutterVersion(),
    ProjectType.dart => VersionService().getDartVersion(),
  };
}

enum DartProjectTemplate {
  cli('cli', 'A command-line application with basic argument parsing.'),
  console('console', 'A command-line application.'),
  package('package', 'A package containing shared Dart libraries.'),
  serverShelf('server-shelf', 'A server app using package:shelf.'),
  web('web', 'A web app that uses only core Dart libraries.');

  final String name;
  final String description;

  const DartProjectTemplate(this.name, this.description);

  bool get isDefault => this == DartProjectTemplate.console;

  String asChoice() {
    final sb = StringBuffer();
    final star = (isDefault ? ' * ' : '');
    final name = (this.name + star).padRight(20);
    sb.write(name);
    sb.write(description);
    final line = sb.toString();
    return line.truncateChoice();
  }
}
