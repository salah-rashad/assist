import 'package:promptly/promptly.dart';

import '../utils/helpers.dart';

// ignore: constant_identifier_names
enum PlatformType { Android, iOS, Windows, Linux, macOS, Web }

enum AndroidLanguage {
  java,
  kotlin;

  static AndroidLanguage get defaultLanguage => kotlin;

  bool get isDefault => this == defaultLanguage;

  String toChoice() => generateChoice(name.titleCase, null, isDefault);
}

enum ProjectType {
  flutter,
  dart;

  String toChoice(String flutterVersion, String dartVersion) {
    final version = switch (this) {
      ProjectType.flutter => flutterVersion,
      ProjectType.dart => dartVersion,
    };

    return generateChoice(name.titleCase, version);
  }
}

enum DartProjectTemplate {
  cli('cli', 'CLI', 'A command-line application with basic argument parsing.'),
  console('console', 'Console', 'A command-line application.'),
  package('package', 'Package', 'A package containing shared Dart libraries.'),
  serverShelf('server-shelf', 'Server', 'A server app using package:shelf.'),
  web('web', 'Web', 'A web app that uses only core Dart libraries.');

  const DartProjectTemplate(this.value, this.name, this.description);

  final String name;
  final String description;
  final String value;

  static DartProjectTemplate get defaultChoice => console;

  bool get isDefault => this == defaultChoice;

  String toChoice() => generateChoice(name, description, isDefault);
}

enum FlutterProjectTemplate {
  app('app', 'App', 'A standard Flutter app project.'),
  appEmpty(
    'app',
    'Empty App',
    'A standard Flutter app project. (minimal, no guide comments)',
  ),
  module('module', 'Module', 'Add Flutter to an existing iOS or Android app.'),
  package('package', 'Package', 'A reusable Dart package, no native code.'),
  plugin(
    'plugin',
    'Plugin',
    'A package with platform-specific native implementations.',
  ),
  pluginFFI(
    'plugin_ffi',
    'FFI Plugin',
    'A plugin using FFI (dart:ffi) for native code.',
  );

  const FlutterProjectTemplate(this.value, this.name, this.description);

  final String name;
  final String description;
  final String value;

  static FlutterProjectTemplate get defaultChoice => app;

  bool get isDefault => this == defaultChoice;

  String toChoice() => generateChoice(name, description, isDefault);
}
