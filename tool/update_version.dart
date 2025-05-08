import 'dart:io';

void main() {
  try {
    final constantsFile = File('packages/cli/lib/app/core/cli.strings.dart');
    final content = constantsFile.readAsStringSync();

    // Extract the new version from the pubspec.yaml
    final pubspec = File('packages/cli/pubspec.yaml').readAsStringSync();
    final versionMatch = RegExp(r'version:\s*(\S+)').firstMatch(pubspec);

    if (versionMatch == null) {
      stderr.writeln('❌ Could not find version in pubspec.yaml');
      exit(1);
    }

    final newVersion = versionMatch.group(1);

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
