import 'dart:convert';
import 'dart:io';

import 'package:assist_core/constants/paths.dart';
import 'package:assist_core/constants/supported_platform.dart';
import 'package:path/path.dart' as p;

class AssistConfigManager {
  static const _configFileName = 'config.json';
  static final _configDir = _getConfigDir();
  static final _configPath = '$_configDir/$_configFileName';

  static Future<Map<String, dynamic>> loadConfig() async {
    final file = File(_configPath);
    if (!await file.exists()) {
      return _defaultConfig();
    }

    final content = await file.readAsString();
    final decoded = jsonDecode(content);

    return {
      ..._defaultConfig(),
      ...decoded,
    };
  }

  static Future<void> saveConfig(Map<String, dynamic> config) async {
    final file = File(_configPath);
    await file.create(recursive: true);
    final jsonStr = JsonEncoder.withIndent('  ').convert(config);
    await file.writeAsString(jsonStr);
  }

  static Future<void> updateGuiData({
    required String path,
    required String bundle,
  }) async {
    final config = await loadConfig();
    config['gui'] = {
      'executable_path': path,
      'bundle_path': bundle,
      'installed_at': DateTime.now().toIso8601String(),
    };
    await saveConfig(config);
  }

  static Future<String?> getGuiExecutablePath() async {
    final config = await loadConfig();
    final gui = config['gui'] as Map?;
    return gui?['executable_path'] as String?;
  }

  static Future<String?> getGuiBundlePath() async {
    final config = await loadConfig();
    final gui = config['gui'] as Map?;
    return gui?['bundle_path'] as String?;
  }

  static Future<void> setVersion(String version) async {
    final config = await loadConfig();
    config['version'] = version;
    await saveConfig(config);
  }

  static Future<String?> getVersion() async {
    final config = await loadConfig();
    return config['version'];
  }

  static Map<String, dynamic> _defaultConfig() {
    return {
      'version': '',
      'gui': {},
    };
  }

  static String _getConfigDir() {
    final home = SupportedPlatform.current.getHomePath();
    return p.join(home, kCacheDir);
  }
}
