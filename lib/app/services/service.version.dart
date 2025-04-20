import 'dart:io';

class VersionService {
  String getDartVersion() {
    final version = Platform.version;
    final match = RegExp(r'^([\w\.-]+ \(\w+\))').firstMatch(version);
    return match?.group(1) ?? version.split(' ')[0];
  }

  Future<String> getFlutterVersion() async {
    try {
      final version = await Process.run('flutter', ['--version']);
      if (version.exitCode != 0) {
        return '';
      }
      final versionString = version.stdout.toString().split('\n')[0].trim();
      final match = RegExp(r'Flutter (.*?) • https').firstMatch(versionString);
      return match?.group(1) ?? '';
    } on Exception catch (_) {
      return '';
    }
  }
}
