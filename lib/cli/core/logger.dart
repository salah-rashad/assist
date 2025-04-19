// import 'package:chalkdart/chalk.dart';
//
// enum LogLevel { info, success, warning, error, debug }
//
// class Logger {
//   static bool verbose = false;
//
//   static void info(String message) => _log(message, LogLevel.info);
//   static void success(String message) => _log(message, LogLevel.success);
//   static void warning(String message) => _log(message, LogLevel.warning);
//   static void error(String message) => _log(message, LogLevel.error);
//   static void debug(String message) {
//     if (verbose) _log(message, LogLevel.debug);
//   }
//
//   static void _log(String message, LogLevel level) {
//     final color = _getColor(level);
//     final prefix = _getPrefix(level);
//
//     // Print with the appropriate color
//     print(color("$prefix$message"));
//   }
//
//   static Chalk _getColor(LogLevel level) {
//     switch (level) {
//       case LogLevel.success:
//         return chalk.green;
//       case LogLevel.warning:
//         return chalk.yellow;
//       case LogLevel.error:
//         return chalk.red;
//       case LogLevel.debug:
//         return chalk.blue;
//       case LogLevel.info:
//         return chalk.cyan;
//     }
//   }
//
//   static String _getPrefix(LogLevel level) {
//     switch (level) {
//       case LogLevel.success:
//         return '[✓] ';
//       case LogLevel.warning:
//         return '[!] ';
//       case LogLevel.error:
//         return '[✗] ';
//       case LogLevel.debug:
//         return '[DEBUG] ';
//       case LogLevel.info:
//         return '[i] ';
//     }
//   }
// }
