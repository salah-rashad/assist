import 'dart:io';

import 'package:assist/app/cli/cli.runner.dart';
import 'package:path/path.dart' as p;
import 'package:promptly/promptly.dart';

final app = AssistCliRunner();

void runApp(List<String> args) {
  console.cleanScreen();
  args = checkArguments(args);
  app.safeRun(args);
}

/// Detects if the first argument is a directory and if so, adds 'run' before it.
/// This should run the app at that location
List<String> checkArguments(List<String> args) {
  final isCommand = app.commands.containsKey(args.firstOrNull);
  final isFlag = app.argParser.options.containsKey(args.firstOrNull);
  bool isDirectory(dir) {
    dir = p.normalize(p.absolute(dir));
    return Directory(dir).existsSync();
  }

  if (args.isNotEmpty && !isCommand && !isFlag && isDirectory(args.first)) {
    args = ['run', ...args];
  }
  return args;
}
