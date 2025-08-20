import 'package:assist_core/services/task_manager/shell_task.dart';
import 'package:assist_core/services/task_manager/task_event.dart';
import 'package:assist_core/utils/helpers.dart';
import 'package:assist_gui/core/utils/helpers.dart';
import 'package:assist_gui/features/task_manager/controller/task_manager_cubit.dart';
import 'package:assist_gui/shared/widgets/command_box.dart';
import 'package:assist_gui/shared/widgets/task_report_title.dart';
import 'package:assist_gui/shared/widgets/task_rerun_button.dart';
import 'package:assist_gui/shared/widgets/terminal_styled_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ShellTaskReportDialog extends StatelessWidget {
  const ShellTaskReportDialog({super.key, required this.task});

  final ShellTask task;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskManagerCubit, TaskEvent?>(
      builder: (context, state) {
        // output is value or error
        final output = task.result?.toString() ?? '';
        final strippedLog = stripAnsi(output);
        final stackTrace = task.result?.stackTrace?.toString();
        final isError = task.result?.error != null;

        return ShadDialog(
          constraints: BoxConstraints(maxWidth: 600),
          title: TaskReportTitle(task: task),
          description: CommandBox(command: task.fullCommand),
          actions: [
            TaskRerunButton.link(task: task),
            Spacer(),
            if (stackTrace != null)
              _buildCopyStackTraceButton(stackTrace, context),
            if (strippedLog.isNotEmpty)
              _buildCopyErrorButton(strippedLog, context),
          ],
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TerminalStyledCard.ansii(
              output: output,
              isError: isError,
              stackTrace: stackTrace,
            ),
          ),
        );
      },
    );
  }

  ShadButton _buildCopyErrorButton(String strippedLog, BuildContext context) {
    return ShadButton(
      size: ShadButtonSize.sm,
      leading: Icon(LucideIcons.copy),
      onPressed: () => copyAndToast(strippedLog, context),
      child: Text('Copy Output'),
    );
  }

  ShadButton _buildCopyStackTraceButton(
      String stackTrace, BuildContext context) {
    return ShadButton.outline(
      size: ShadButtonSize.sm,
      leading: Icon(LucideIcons.copy),
      onPressed: () => copyAndToast(stackTrace, context),
      child: Text('Copy Stack Trace'),
    );
  }
}
