import 'package:chalkdart/chalkstrings.dart';
import 'package:promptly/promptly.dart';

import '../../core/constants.dart';
import '../../services/service.install.dart';

/// Command to install the GUI
class InstallCommand extends Command<int> {
  InstallCommand()
    : super('install', "Install the GUI and initialize the tool.");

  @override
  Future<int> run() async {
    final service = InstallService();

    ln(s) => writeln(theme.prefixLine(s));

    header('Install', message: description);
    wrapTextAsLines(Strings.logoArtWithVersion().indianRed).forEach(ln);
    line();
    final installDir = service.promptInstallDirectory();
    line();
    await service.downloadGUIApp();
    line();
    await service.install(installDir);

    finishSuccesfuly(
      'Install',
      message: 'Installed Successfully',
      suggestion:
          'Run `${Strings.executableName} <project_directory>` to start.',
    );
    return 0;
  }
}
