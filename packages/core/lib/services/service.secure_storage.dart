import 'package:hive/hive.dart';
import 'package:path/path.dart' as path;

import '../core/utils/helpers.dart';
import 'service.encryption.dart';

/// Provides high-level secure token storage APIs.
class SecureStorageManager {
  static const _boxName = 'secure_box';
  static const _tokenKey = 'github_token';

  static final hiveDataPath = path.join(getTempDirectory().path, 'hive_data');

  /// Initialize Hive with encryption
  static Future<void> initialize() async {
    await EncryptionHelper.ensureStoragePathExists();
    Hive.init(hiveDataPath);

    final encryptionKey = await EncryptionHelper.loadOrCreateKey();
    await Hive.openBox<String>(
      _boxName,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
  }

  /// Save a token securely
  static Future<void> saveToken(String token) async {
    final box = Hive.box<String>(_boxName);
    await box.put(_tokenKey, token);
  }

  /// Retrieve the stored token
  static String? getToken() {
    final box = Hive.box<String>(_boxName);
    return box.get(_tokenKey);
  }

  /// Delete the stored token
  static Future<void> deleteToken() async {
    final box = Hive.box<String>(_boxName);
    await box.delete(_tokenKey);
  }

  /// Close storage properly (for CLI apps)
  static Future<void> close() async {
    await Hive.close();
  }
}
