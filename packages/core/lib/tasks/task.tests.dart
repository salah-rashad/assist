import 'dart:io';

import 'package:assist_core/constants/enums.dart';
import 'package:assist_core/services/task_manager/shell_task.dart';
import 'package:assist_core/utils/test_events_parser.dart';
import 'package:path/path.dart' as p;
import 'package:test_report_parser/test_report_parser.dart';

class UnitTestTask extends ShellTask<TestReport> {
  final String projectPath;
  final ProjectType projectType;

  /// Set this if you want to run only a specific named test
  /// [testName] could be a test name or a group name
  final String? testName;

  /// Set this if you want to run only a specific test file.
  /// Path should be relative (e.g. `test/my_test.dart`)
  final String? testFilePath;

  UnitTestTask({
    required this.projectPath,
    required this.projectType,
    this.testName,
    this.testFilePath,
  }) : super(
          projectType.isFlutter() ? 'flutter' : 'dart',
          [
            'test',
            if (testFilePath != null) testFilePath,
            if (testName != null) '--name $testName',
            '--reporter=json',
          ],
          workingDirectory: projectPath,
        );

  @override
  String get name => 'Unit Tests';

  @override
  Future<TestReport> execute() async {
    final testFolder = Directory(p.join(projectPath, 'test'));
    if (testFilePath == null && testName == null && !testFolder.existsSync()) {
      // throw 'No tests found in $projectPath';
      return TestReport.empty();
    }
    return super.execute();
  }

  @override
  TestReport handleResult(ProcessResult result) {
    final String output = result.stdout;
    final report = _parseEvents(output);

    if (result.exitCode != 0) {
      throw report;
    }

    return report;
  }

  TestReport _parseEvents(String output) {
    final lines = output.split('\n');

    final List<Event> events = [];
    for (final line in lines) {
      if (line.trim().isEmpty) continue;
      final event = parseJsonToEvent(line);
      events.add(event);
    }

    final report = TestEventsParser.parse(events, json: output);
    return report;
  }
}
