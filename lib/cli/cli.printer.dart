import 'dart:io';

import 'package:assist/cli/main.dart';
import 'package:assist/cli/utils/temp_link.dart';
import 'package:chalkdart/chalkstrings.dart';
import 'package:promptly/promptly.dart' hide Tint;

import 'core/constants.dart';

abstract class Printer {
  static newline() => print('\n');
  static printLogo() => print(Strings.logoArt.bold.indianRed);

  static printWelcome() => print('''
${'Welcome to ${Strings.appName} 🚀'.bold}
${Strings.description.gray}
''');

  static printUsageError(String message) {
    writeln(app.errorAppDescription);
    write('\x1B[1A');
    finishWithError(
      'Usage Error',
      message: message,
      exitCode: ExitCode.usage.code,
      stackTrace: StackTrace.current,
    );
    exit(ExitCode.usage.code);
  }

  static String mainUsageFooter() {
    final theme = app.theme;
    String l(String s) => theme.prefixLine(s);
    // String w(String s) => theme.prefixWarning(s);
    String r(String s) => theme.prefixRun(s);

    final recommendedUsage = console.sectionLine('Usage');
    final command1 =
        '${Strings.executableName.darkOrange} ${'<project_directory>'.gray.italic}';
    final command2 =
        '${Strings.executableName.darkOrange} run ${'<project_directory>'.gray.italic}';
    final moreInfo =
        'For more information, visit: '
                '${tempLink('https://github.com/salah-rashad/assist', 'GitHub')}'
                ' | '
                '${tempLink('https://pub.dev/packages/assist', 'Pub')}'
            .lightSlateGray;

    return '\r$recommendedUsage'
        '\x1B[3A\x1B[2K'
        '${l('')}'
        '\n${r(command1)}'
        '\n${r(command2)}'
        '\n${l('')}'
        '\n${l(moreInfo)}';
  }
}
