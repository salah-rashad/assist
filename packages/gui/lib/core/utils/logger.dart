import 'package:flutter/foundation.dart';

enum Logger {
  black('30'),
  red('31'),
  green('32'),
  yellow('33'),
  blue('34'),
  magenta('35'),
  cyan('36'),
  white('37'),
  gray('90');

  final String code;

  const Logger(this.code);

  void call(dynamic text, {String? name}) {
    if (kDebugMode) {
      print('[${name ?? runtimeType}]: \x1B[${code}m$text\x1B[0m');
    }
  }

  static void data(String key, dynamic value) {
    if (kDebugMode) {
      print(
        '\x1B[${cyan.code}m[$key]:\x1B[0m \x1B[${yellow.code}m$value\x1B[0m',
      );
    }
  }

  static void error(String key, dynamic error, [StackTrace? stackTrace]) {
    if (kDebugMode) {
      print(
        '\x1B[${red.code}m[$key]:\x1B[0m'
        '\n    '
        '\x1B[${red.code}m$error\x1B[0m',
      );

      if (stackTrace != null) {
        debugPrintStack(stackTrace: stackTrace, label: key);
      }
    }
  }
}
