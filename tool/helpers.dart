import 'dart:io';

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
