import 'dart:io';

abstract class InternetConnectionService {
  static Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup(
        'google.com',
      ).timeout(const Duration(seconds: 2));
      return result.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
