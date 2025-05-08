import 'dart:io';

import 'package:chalkdart/chalkstrings.dart';

import 'helpers.dart';

Future<void> main() async {
  final newVersion = getNewVersion();
  await addCommitTag(newVersion);
}

/// Add commit tag to git commit e.g. "assist-v0.3.0"
Future<void> addCommitTag(String newVersion) async {
  // Get the latest commit message
  final logResult = await Process.run('git', ['log', '-1', '--pretty=%s']);
  final lastCommitMessage = logResult.stdout.toString().trim();

  if (!lastCommitMessage.startsWith('chore(release)')) {
    stdout.writeln(
        'ℹ️ Skipping tag: Last commit is not a release commit.'.black.onBlue);
    return;
  }

  // Add the tag
  final tagResult = await Process.run('git', ['tag', 'assist-v$newVersion']);

  if (tagResult.exitCode != 0) {
    stderr.writeln(
        '❌ Error adding commit tag: ${tagResult.stderr}'.black.onIndianRed);
    exit(1);
  } else {
    stdout
        .writeln('✔ Tag assist-v$newVersion added successfully.'.black.onGreen);
  }
}
