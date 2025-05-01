import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:assist_core/services/service.secure_storage.dart';
import 'package:path/path.dart' as path;

/// Handles encryption key generation, storage, and retrieval.
class EncryptionHelper {
  static final _hiveDataPath = SecureStorageManager.hiveDataPath;
  static final _keyFilePath = path.join(_hiveDataPath, '.encryption_key');

  /// Load existing key or create a new one.
  static Future<List<int>> loadOrCreateKey() async {
    final keyFile = File(_keyFilePath);

    if (await keyFile.exists()) {
      final encodedKey = await keyFile.readAsString();
      return base64Decode(encodedKey);
    } else {
      final key = _generateRandomKey();
      await keyFile.create(recursive: true);
      await keyFile.writeAsString(base64Encode(key));
      return key;
    }
  }

  /// Generate a 32-byte secure random key.
  static List<int> _generateRandomKey() {
    final random = Random.secure();
    return List<int>.generate(32, (_) => random.nextInt(256));
  }

  /// Ensure storage folder exists
  static Future<void> ensureStoragePathExists() async {
    final dir = Directory(_hiveDataPath);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
  }
}
