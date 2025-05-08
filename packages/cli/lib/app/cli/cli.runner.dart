import 'package:assist/app/cli/cli.printer.dart';
import 'package:assist/app/cli/commands/cmd.create.dart';
import 'package:assist/app/cli/commands/cmd.install.dart';
import 'package:assist/app/cli/commands/cmd.run.dart';
import 'package:assist/app/core/cli.strings.dart';
import 'package:assist/app/utils/string_colors.dart';
import 'package:promptly/promptly.dart';

part 'cli.theme.dart';

/// The main command runner for the app
class AssistCliRunner extends CommandRunner {
  AssistCliRunner()
      : super(
          'assist',
          CliStrings.description,
          version: CliStrings.version,
          theme: CliThemes.defaultTheme,
        ) {
    argParser.addFlag(
      hide: true,
      'dev',
      help: 'Run in debug mode',
      negatable: true,
      callback: (value) {
        _isDevMode = value;
        if (_isDevMode) {
          _showDebugModeMessage();
        }
      },
    );

    addCommand(InstallCommand());
    addCommand(RunCommand());
    addCommand(CreateCommand());
  }

  bool _isDevMode = false;

  bool get isDevMode => _isDevMode;

  @override
  String get executableName =>
      super.executableName + (_isDevMode ? '-dev' : '');

  @override
  Never usageException(String message) => Printer.printUsageError(message);

  //   @override
  //   String get publicUsageWithoutDescription => '''
  // ${Strings.logoArt2.split('\n').map((e) => theme.colors.success(e.prefixLine())).join('\n')}
  // ${super.publicUsageWithoutDescription}''';

  @override
  String? get usageFooter => Printer.mainUsageFooter();
}

void _showDebugModeMessage() {
  writeln(' ');
  write('🚧 ');
  writeln('![DEVELOPMENT MODE]'.cWhite.cOnOrangeRed.italic().bold());
  writeln(' ');
}
