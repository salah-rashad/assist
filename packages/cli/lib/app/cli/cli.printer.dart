import 'dart:io';

import 'package:assist/app/core/cli.strings.dart';
import 'package:assist/app/utils/cli.extensions.dart';
import 'package:assist/app/utils/cli.helpers.dart';
import 'package:assist/app/utils/string_colors.dart';
import 'package:assist/main.dart';
import 'package:promptly/promptly.dart';

/// CLI printer
abstract class Printer {
  static newline() => print('\n');

  static printLogo() => print(CliStrings.logoArt.cIndianRed.bold());

  static printUsageError(String message) {
    write(app.errorAppDescription);
    finishWithError(
      'Usage Error',
      message: message,
      exitCode: ExitCode.usage.code,
      stackTrace: StackTrace.current,
    );
    exit(ExitCode.usage.code);
  }

  static String mainUsageFooter() {
    // String l(String s) => theme.prefixLine(s);
    // String r(String s) => theme.prefixRun(s);

    final usage = console.sectionLine('Usage');
    final command1 =
        '${app.executableName} ${'<project_directory>'.cGray.italic()}';
    final command2 =
        '${app.executableName} ${'run'.dim()} ${'<project_directory>'.cGray.italic()}';
    final moreInfo = 'For more information, visit: '
        '${linkLine('https://github.com/salah-rashad/assist', 'GitHub')}'
        ' | '
        '${linkLine('https://pub.dev/packages/assist', 'Pub')}';

    final sb = StringBuffer();
    sb.write('\r$usage');
    // sb.write('\x1B[3A\x1B[2K');
    // sb.writeln(''.prefixLine());
    sb.writeln(command1.prefixRun());
    sb.writeln(command2.prefixRun());
    sb.writeln(''.prefixLine());
    sb.write(moreInfo.prefixLine());

    return sb.toString();
  }

  static void printSuggestions(List<String> suggestions) {
    final sb = StringBuffer();
    sb.writeln(''.prefixLine());
    sb.write(theme.colors.hint('Suggestions').prefixWarning());
    for (final line in suggestions) {
      sb.writeln('');
      sb.write(theme.colors.warning(line).prefix(''));
    }
    writeln(sb.toString());
  }
}
