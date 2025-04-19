import 'dart:io';

import 'package:assist/cli/cli.parser.dart';

import 'cli.runner.dart';

late final AssistCliRunner app;

void runApp(List<String> args) {
  app = CliParser.parse();
  args = insertDefaultCommandIfDirectory(args, app);
  app.safeRun(args);
}

// Insert "run" as default command if the first argument is a directory
List<String> insertDefaultCommandIfDirectory(
  List<String> args,
  AssistCliRunner app,
) {
  final isCommand = app.commands.containsKey(args.firstOrNull);
  final isFlag = app.argParser.options.containsKey(args.firstOrNull);
  bool isDirectory(dir) => Directory(dir).existsSync();

  if (args.isNotEmpty && !isCommand && !isFlag && isDirectory(args.first)) {
    args = ['run', ...args];
  }
  return args;
}
