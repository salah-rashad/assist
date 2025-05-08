import 'package:assist/app/services/service.install.dart';
import 'package:assist/main.dart';
import 'package:assist_core/constants/supported_platform.dart';
import 'package:promptly/promptly.dart';

/// Command to install the GUI
class InstallCommand extends Command<int> {
  InstallCommand()
      : super('install', 'Install the GUI and initialize the tool.');

  @override
  Future<int> run() async {
    if (app.isDevMode) {
      final platform = SupportedPlatform.current;
      message('''
Installation should not be run in dev mode.

To install a version of the GUI in release mode with your latest changes, 
run `melos run build:gui:$platform` in the workspace directory.
''');
      return 0;
    }
    final service = InstallService();

    await service.install();

    // ln(String s) => writeln(theme.prefixLine(s.cIndianRed));
    //
    // header('Install', message: description);
    // wrapTextAsLines(CliStrings.logoArtWithVersion()).forEach(ln);
    // line();
    // // final installDir = await service.promptInstallDirectory();
    // final installDir = service.getInstallDirectory();
    // line();
    // await service.downloadGUIApp();
    // line();
    // await service.install(installDir.path);
    // message('Install directory: ${installDir.path}');
    // finishSuccesfuly(
    //   'Install',
    //   message: 'Installed Successfully',
    //   suggestion: 'Run `${app.executableName} <project_directory>` to start.',
    // );
    return 0;
  }
}
