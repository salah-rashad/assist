import 'dart:io';

Future<void> main() async {
  final newVersion = getNewVersion();
  updateVersion(newVersion);
  await addCommitTag(newVersion);
}

String getNewVersion() {
  // Extract the new version from the pubspec.yaml
  final pubspec = File('packages/cli/pubspec.yaml').readAsStringSync();
  final versionMatch = RegExp(r'version:\s*(\S+)').firstMatch(pubspec);

  if (versionMatch == null) {
    stderr.writeln('❌ Could not find version in pubspec.yaml');
    exit(1);
  }

  return versionMatch.group(1)!;
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

/// Add commit tag to git commit e.g. "assist-v0.3.0"
Future<void> addCommitTag(String newVersion) async {
  final process = await Process.run('git', ['tag', 'assist-v$newVersion']);

  if (process.exitCode != 0) {
    stderr.writeln('❌ Error adding commit tag: ${process.stderr}');
    exit(1);
  }
}
