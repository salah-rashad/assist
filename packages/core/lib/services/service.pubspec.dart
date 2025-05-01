import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:pubspec_parse/pubspec_parse.dart';

import '../constants/exceptions.dart';

/// Service for reading and updating the `pubspec.yaml` file
class PubspecService {
  /// Check if `pubspec.yaml` exists in the [dir] directory
  Future<void> checkPubspecExists(String dir) async {
    final pubspecFile = File(path.join(dir, 'pubspec.yaml'));

    if (!await pubspecFile.exists()) {
      throw PubspecNotFoundException(dir);
    }
  }

  /// Parse the `pubspec.yaml` file
  Pubspec parse(String path) {
    try {
      final pubspecFile = File(path);
      final pubspecContent = pubspecFile.readAsStringSync();
      return Pubspec.parse(pubspecContent);
    } on Exception catch (_) {
      throw PubspecParseException();
    }
  }
}
