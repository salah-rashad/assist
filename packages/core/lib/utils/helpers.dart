import 'dart:io';

import 'package:assist_core/constants/paths.dart';
import 'package:path/path.dart' as p;

Directory getTempDirectory() {
  final systemTempDir = Directory.systemTemp;
  final directory = Directory(p.join(systemTempDir.path, kTempDir));
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }
  return directory;
}

String stripAnsi(String input) {
  final ansiRegex = RegExp(r'\x1B\[[0-9;]*m');
  return input.replaceAll(ansiRegex, '');
}
