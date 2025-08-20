import 'package:assist_core/services/task_manager/task_manager.dart';
import 'package:assist_core/tasks/task.tests.dart';
import 'package:assist_core/utils/test_events_parser.dart';
import 'package:assist_gui/app/themes/app_theme.dart';
import 'package:assist_gui/core/utils/extensions.dart';
import 'package:assist_gui/core/utils/helpers.dart';
import 'package:assist_gui/shared/widgets/loading_indicator.dart';
import 'package:assist_gui/shared/widgets/unit_test/test_group_unit_widget.dart';
import 'package:assist_gui/shared/widgets/unit_test/test_suite_unit_footer.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:shadcn_ui/shadcn_ui.dart';

class TestSuiteUnitWidget extends StatefulWidget {
  const TestSuiteUnitWidget({super.key, required this.suite});

  final TestSuiteUnit suite;

  @override
  State<TestSuiteUnitWidget> createState() => _TestSuiteUnitWidgetState();
}

class _TestSuiteUnitWidgetState extends State<TestSuiteUnitWidget> {
  late final UnitTestTask suiteTask;
  TestSuiteUnit? suite;

  String get path => widget.suite.path;

  TaskStatus get status => suiteTask.status;

  @override
  void initState() {
    super.initState();
    suite = widget.suite;

    suiteTask = UnitTestTask(
      projectPath: context.project.path,
      projectType: context.project.projectType,
      testFilePath: path,
    );
  }

  void runTask() {
    setState(() {
      suite = null;
    });
    suiteTask.run(
      onEvent: (event) {
        refresh();
      },
    );
  }

  void refresh() {
    setState(() {
      final result = suiteTask.result;
      if (result != null) {
        final report = result.valueOrError as TestReport? ?? TestReport.empty();
        suite = report.suites.firstOrNull;
      }
    });
  }

  @override
  void dispose() {
    suiteTask.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadTheme(
      data: AppTheme.dark.themeData(),
      child: Builder(builder: (context) {
        final suite = this.suite;

        if (suite == null) {
          return ShadCard(
            backgroundColor: Colors.black.withValues(alpha: 0.95),
            padding: const EdgeInsets.all(16),
            title: Text(
              p.relative(path, from: context.project.path),
              style: TextStyle(fontSize: 16),
            ),
            trailing: LoadingIndicator(),
          );
        }

        return ShadCard(
          backgroundColor: Colors.black.withValues(alpha: 0.95),
          padding: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ShadAccordionItem(
              value: widget.suite.id,
              padding: EdgeInsets.zero,
              duration: const Duration(milliseconds: 200),
              title: Text(
                p.relative(
                  suite.path,
                  from: p.join(context.project.path, 'test'),
                ),
              ),
              child: SelectionArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: suite.isLoadFailure
                      ? _buildFailureMessage(context, suite.loadErrorMessage)
                      : _buildGroupUnits(suite.groups),
                ),
              ),
              separator: TestSuiteUnitFooter(suite: suite),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildFailureMessage(BuildContext context, String? message) {
    return Text(
      message.toString(),
      style: terminalStyle(context).apply(
        color: context.colorScheme.destructive,
      ),
    );
  }

  Widget _buildGroupUnits(Iterable<TestGroupUnit> groups) {
    if (groups.isEmpty) {
      return const Text(
        'No tests found.',
        style: TextStyle(color: Colors.white24),
      );
    }
    return Column(
      spacing: 8,
      children: [
        for (final group in groups) TestGroupUnitWidget(group: group),
      ],
    );
  }
}
