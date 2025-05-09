import 'dart:io';

import 'package:chalkdart/chalkstrings.dart';

import 'helpers.dart';

Future<void> main() async {
  final newVersion = getNewVersion();
  updateVersion(newVersion);
}

void updateVersion(String newVersion) {
  try {
    final constantsFile = File('packages/core/lib/constants/version.dart');
    final content = constantsFile.readAsStringSync();

    // Replace the version string in the constants file
    final updatedContent = content.replaceAll(
      RegExp(r"const\s+String\s+assistVersion\s*=\s*'[^']*';"),
      "const String assistVersion = '$newVersion';",
    );

    constantsFile.writeAsStringSync(updatedContent);
    print('✔ Updated version to $newVersion in "${constantsFile.path}"'
        .black
        .onGreen);
  } catch (e) {
    stderr.writeln('❌ Error updating version: $e'.black.onIndianRed);
    exit(1);
  }
}
