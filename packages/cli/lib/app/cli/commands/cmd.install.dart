import 'package:assist/app/core/cli.strings.dart';
import 'package:assist/app/services/service.install.dart';
import 'package:assist/app/utils/string_colors.dart';
import 'package:promptly/promptly.dart';

/// Command to install the GUI
class InstallCommand extends Command<int> {
  InstallCommand()
      : super('install', 'Install the GUI and initialize the tool.');

  @override
  Future<int> run() async {
    final service = InstallService();

    ln(String s) => writeln(theme.prefixLine(s.cIndianRed));

    header('Install', message: description);
    wrapTextAsLines(CliStrings.logoArtWithVersion()).forEach(ln);
    line();
    // final installDir = await service.promptInstallDirectory();
    final installDir = service.getGuiInstallDir();
    line();
    await service.downloadGUIApp();
    line();
    await service.install(installDir.path);
    message('Install directory: ${installDir.path}');
    finishSuccesfuly(
      'Install',
      message: 'Installed Successfully',
      suggestion:
          'Run `${CliStrings.executableName} <project_directory>` to start.',
    );
    return 0;
  }
}
