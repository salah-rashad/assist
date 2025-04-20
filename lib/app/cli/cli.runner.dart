import 'package:chalkdart/chalkstrings.dart';
import 'package:promptly/promptly.dart' hide Tint;

import '../core/constants.dart';
import 'cli.printer.dart';

part 'cli.theme.dart';

class AssistCliRunner extends CommandRunner {
  AssistCliRunner()
    : super(
        Strings.executableName,
        Strings.description,
        version: Strings.version,
        theme: _customTheme,
      ) {
    // Cleans the screen before every command
    console.cleanScreen();
  }

  @override
  Never usageException(String message) => Printer.printUsageError(message);

  @override
  String? get usageFooter => Printer.mainUsageFooter();
}
