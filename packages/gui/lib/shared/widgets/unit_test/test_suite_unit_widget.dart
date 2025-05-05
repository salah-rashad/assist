import 'package:assist_core/services/task_manager/task_manager.dart';
import 'package:assist_core/tasks/task.tests.dart';
import 'package:assist_core/utils/test_events_parser.dart';
import 'package:assist_gui/app/themes/app_theme.dart';
import 'package:assist_gui/core/utils/extensions.dart';
import 'package:assist_gui/shared/widgets/loading_indicator.dart';
import 'package:assist_gui/shared/widgets/unit_test/test_group_unit_widget.dart';
import 'package:assist_gui/shared/widgets/unit_test/test_suite_unit_footer.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TestSuiteUnitWidget extends StatefulWidget {
  const TestSuiteUnitWidget({super.key, required this.suite});

  final TestSuiteUnit suite;

  @override
  State<TestSuiteUnitWidget> createState() => _TestSuiteUnitWidgetState();
}

class _TestSuiteUnitWidgetState extends State<TestSuiteUnitWidget> {
  late final UnitTestTask suiteTask;
  late TestSuiteUnit? suite;

  String get path => widget.suite.path;
  TaskStatus get status => suiteTask.status;

  final GlobalKey _contentKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _handleAutoFocus();

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
    _handleAutoFocus();
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
              widget.suite.path,
              style: TextStyle(fontSize: 16),
            ),
            trailing: LoadingIndicator(),
          );
        }

        // Rename root group
        final groups = suite.groups.mapIndexed((i, group) {
          if (i == 0) {
            return group.copyWith(name: 'Root');
          }
          return group;
        });

        return TapRegion(
          onTapUpInside: (event) => _handleAutoFocus(),
          child: ShadCard(
            backgroundColor: Colors.black.withValues(alpha: 0.95),
            padding: const EdgeInsets.all(16),
            footer: TestSuiteUnitFooter(suite: suite),
            child: ShadAccordionItem(
              value: widget.suite.id,
              padding: EdgeInsets.zero,
              duration: const Duration(milliseconds: 200),
              separator: SizedBox.shrink(),
              title: Text(suite.path),
              child: SelectionArea(
                key: _contentKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    spacing: 8,
                    children: [
                      for (final group in groups)
                        TestGroupUnitWidget(group: group),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  /// Auto scroll to this widget when expanded
  void _handleAutoFocus() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 250), () {
        final isNowExpanded =
            (_contentKey.currentContext?.size?.height ?? 0) > 0;
        if (isNowExpanded) {
          if (!mounted) return;
          final renderObject = context.findRenderObject();
          if (renderObject != null) {
            Scrollable.maybeOf(context)?.position.ensureVisible(
                  renderObject,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOutCirc,
                  alignment: 0,
                );
          }
        }
      });
    });
  }
}
