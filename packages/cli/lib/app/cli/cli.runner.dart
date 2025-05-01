import 'package:assist/app/utils/string_colors.dart';
import 'package:promptly/promptly.dart';

import '../core/constants.dart';
import 'cli.printer.dart';
import 'commands/cmd.create.dart';
import 'commands/cmd.install.dart';
import 'commands/cmd.run.dart';

part 'cli.theme.dart';

/// The main command runner for the app
class AssistCliRunner extends CommandRunner {
  AssistCliRunner()
    : super(
        Strings.executableName,
        Strings.description,
        version: Strings.version,
        theme: CliThemes.defaultTheme,
      ) {
    addCommand(InstallCommand());
    addCommand(RunCommand());
    addCommand(CreateCommand());
  }

  @override
  Never usageException(String message) => Printer.printUsageError(message);

  //   @override
  //   String get publicUsageWithoutDescription => '''
  // ${Strings.logoArt2.split('\n').map((e) => theme.colors.success(e.prefixLine())).join('\n')}
  // ${super.publicUsageWithoutDescription}''';

  @override
  String? get usageFooter => Printer.mainUsageFooter();
}
