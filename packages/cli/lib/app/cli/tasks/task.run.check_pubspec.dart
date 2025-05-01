import 'package:assist_core/services/service.pubspec.dart';
import 'package:promptly/promptly.dart';

import '../components/command_task.dart';

class CheckPubspecTask extends CommandTask {
  CheckPubspecTask(this.projectDir);

  final String projectDir;

  @override
  String get prompt => 'Check `pubspec.yaml` file';

  @override
  String get successTag => '[Found]';

  @override
  String get failedTag => '[Not Found]';

  @override
  Future<void> execute(LoaderState state) {
    return PubspecService().checkPubspecExists(projectDir);
  }
}
