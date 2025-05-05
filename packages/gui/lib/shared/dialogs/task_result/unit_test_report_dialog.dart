import 'package:assist_core/services/task_manager/task_event.dart';
import 'package:assist_core/tasks/task.tests.dart';
import 'package:assist_core/utils/test_events_parser.dart';
import 'package:assist_gui/features/task_manager/controller/task_manager_cubit.dart';
import 'package:assist_gui/shared/widgets/command_box.dart';
import 'package:assist_gui/shared/widgets/task_report_title.dart';
import 'package:assist_gui/shared/widgets/task_rerun_button.dart';
import 'package:assist_gui/shared/widgets/unit_test/test_report_stats.dart';
import 'package:assist_gui/shared/widgets/unit_test/test_suite_unit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class UnitTestReportDialog extends StatelessWidget {
  const UnitTestReportDialog({super.key, required this.task});

  final UnitTestTask task;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskManagerCubit, TaskEvent?>(
      builder: (context, state) {
        final report =
            task.result?.valueOrError as TestReport? ?? TestReport.empty();

        return ShadDialog(
          constraints: BoxConstraints(maxWidth: 600),
          title: TaskReportTitle(task: task),
          description: CommandBox(command: task.fullCommand),
          actions: [
            TaskRerunButton(task: task),
          ],
          child: ShadAccordion<int>(
            initialValue: report.firstFailedSuite,
            children: [
              const SizedBox(height: 8.0),
              TestReportStats(report: report),
              const SizedBox(height: 16.0),
              Column(
                spacing: 16.0,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final suite in report.suites)
                    TestSuiteUnitWidget(suite: suite)
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
