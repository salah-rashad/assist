import 'dart:io';

import 'helpers.dart';

Future<void> main() async {
  final newVersion = getNewVersion();
  await addCommitTag(newVersion);
}

/// Add commit tag to git commit e.g. "assist-v0.3.0"
Future<void> addCommitTag(String newVersion) async {
  final process = await Process.run('git', ['tag', 'assist-v$newVersion']);

  if (process.exitCode != 0) {
    stderr.writeln('❌ Error adding commit tag: ${process.stderr}');
    exit(1);
  }
}
