import 'dart:io';

import 'package:path/path.dart' as path;

import '../core/exceptions.dart';

/// Service for reading and updating the `pubspec.yaml` file
class PubspecService {
  /// Check if `pubspec.yaml` exists in the [dir] directory
  Future<void> checkPubspecExists(String dir) async {
    final pubspecFile = File(path.join(dir, 'pubspec.yaml'));

    if (!await pubspecFile.exists()) {
      throw PubspecNotFoundException(dir);
    }
  }
}
