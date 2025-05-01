import 'dart:io';

import 'package:path/path.dart' as p;

import '../constants/paths.dart';

Directory getTempDirectory() {
  final systemTempDir = Directory.systemTemp;
  final directory = Directory(p.join(systemTempDir.path, kTempDir));
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }
  return directory;
}
