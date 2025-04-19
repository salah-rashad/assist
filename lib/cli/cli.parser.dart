import 'cli.runner.dart';
import 'commands/cmd.install.dart';
import 'commands/cmd.run.dart';

class CliParser {
  static AssistCliRunner parse() {
    final r = AssistCliRunner();

    r.addCommand(InstallCommand());
    r.addCommand(RunCommand());

    return r;
  }
}
