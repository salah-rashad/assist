import 'dart:io';

import 'helpers.dart';

Future<void> main() async {
  final newVersion = getNewVersion();
  updateVersion(newVersion);
}

void updateVersion(String newVersion) {
  try {
    final constantsFile = File('packages/cli/lib/app/core/cli.strings.dart');
    final content = constantsFile.readAsStringSync();

    // Replace the version string in the constants file
    final updatedContent = content.replaceAll(
      RegExp(r"const\s+String\s+version\s*=\s*'[^']*';"),
      "const String version = '$newVersion';",
    );

    constantsFile.writeAsStringSync(updatedContent);
    print('✅ Updated version to $newVersion in "${constantsFile.path}"');
  } catch (e) {
    stderr.writeln('❌ Error updating version: $e');
    exit(1);
  }
}
