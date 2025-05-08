import 'dart:io';

import 'package:assist/app/core/cli.strings.dart';
import 'package:path/path.dart' as p;

/// Returns the platform-specific executable to launch
({String platform, String exec}) getPlatformExecutable() {
  if (Platform.isWindows) return (platform: 'windows', exec: 'gui.exe');
  if (Platform.isMacOS) return (platform: 'macos', exec: 'gui');
  if (Platform.isLinux) return (platform: 'linux', exec: 'gui');

  throw UnsupportedError('Unsupported platform for installing the GUI.');
}

/// Returns the name of the executable file produced after building
String getExecutableName(String baseName) {
  if (Platform.isWindows) return '$baseName.exe';
  return baseName; // macOS and Linux
}

/// Returns the full path to the built executable
String getBuiltExecutablePath(String guiProjectPath, String baseName) {
  final platform = getPlatformExecutable();
  final execName = getExecutableName(baseName);

  return '$guiProjectPath/build/$platform/runner/$execName';
}

/// Get the absolute path to this Dart package in the pub cache
String getGlobalPackagePath() {
  final home = Platform.environment['HOME'] ?? '';
  return p.join(
    home,
    '.pub-cache',
    'global_packages',
    CliStrings.executableName,
  );
}

/// Get the user's home directory path on the system
String getUserHomePath() {
  if (Platform.isWindows) {
    return Platform.environment['USERPROFILE'] ?? '';
  } else {
    return Platform.environment['HOME'] ?? '';
  }
}
