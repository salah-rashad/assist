import 'dart:io';

import 'package:assist/app/core/constants.dart';
import 'package:assist/app/services/service.pubspec.dart';
import 'package:path/path.dart' as p;
import 'package:promptly/promptly.dart';

String toMegaBytes(int bytes, {int fractionDigits = 2}) {
  return (bytes / (1024 * 1024)).toStringAsFixed(fractionDigits);
}

String getAppVersion() {
  final executablePath = Platform.script.toFilePath();
  String path = p.join(executablePath, '..', '..', 'pubspec.yaml');
  path = p.normalize(path);
  try {
    final pubspec = PubspecService().parse(path);
    return pubspec.version.toString();
  } on Exception catch (_) {
    return Strings.version;
  }
}

String getUserHomePath() {
  if (Platform.isWindows) {
    return Platform.environment['USERPROFILE'] ?? '';
  } else {
    return Platform.environment['HOME'] ?? '';
  }
}

String r(String s) => console.theme.prefixRun(s);
