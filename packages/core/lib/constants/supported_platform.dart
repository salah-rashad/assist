import 'dart:io';

enum SupportedPlatform {
  windows,
  linux,
  macos;

  static SupportedPlatform get current {
    if (Platform.isWindows) return windows;
    if (Platform.isLinux) return linux;
    if (Platform.isMacOS) return macos;
    throw UnsupportedError('Unsupported OS: ${Platform.operatingSystem}');
  }

  @override
  String toString() => name;

  String getHomePath() {
    final result = switch (this) {
      SupportedPlatform.windows => Platform.environment['USERPROFILE'],
      SupportedPlatform.linux => Platform.environment['HOME'],
      SupportedPlatform.macos => Platform.environment['HOME'],
    };
    if (result == null) {
      throw Exception('Could not find user\'s home directory.');
    }
    return result;
  }
}
