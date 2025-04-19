import 'package:assist/cli/cli.printer.dart';
import 'package:promptly/promptly.dart' hide Tint;

import 'core/constants.dart';

part 'cli.theme.dart';

class AssistCliRunner extends CommandRunner {
  AssistCliRunner()
    : super(
        Strings.executableName,
        Strings.description,
        version: Strings.version,
        theme: _cliTheme,
      ) {
    console.cleanScreen();
  }

  @override
  Never usageException(String message) => Printer.printUsageError(message);

  @override
  String? get usageFooter => Printer.mainUsageFooter();
}
