import 'package:assist_core/services/task_manager/shell_task.dart';
import 'package:assist_core/services/task_manager/task_event.dart';
import 'package:assist_core/services/task_manager/task_manager.dart';
import 'package:assist_core/utils/helpers.dart';
import 'package:assist_gui/core/utils/extensions.dart';
import 'package:assist_gui/core/utils/extensions/task.ext.dart';
import 'package:assist_gui/features/task_manager/controller/task_manager_cubit.dart';
import 'package:assist_gui/shared/widgets/ansi_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TaskResultDetailsDialog extends StatelessWidget {
  const TaskResultDetailsDialog({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskManagerCubit, TaskEvent?>(
      builder: (context, state) {
        final ansiLog = task.result?.toString() ?? '';
        final strippedLog = stripAnsi(ansiLog);
        final stackTrace = task.result?.stackTrace?.toString();

        return ShadDialog(
          constraints: BoxConstraints(maxWidth: 600),
          title: _buildTitle(context),
          description: _buildDescription(context),
          actions: [
            if (task.isFailed || task.isCancelled) ...[
              _buildRetryButton(context),
              Spacer(),
            ],
            if (stackTrace != null)
              _buildCopyStackTraceButton(stackTrace, context),
            if (strippedLog.isNotEmpty)
              _buildCopyErrorButton(strippedLog, context),
          ],
          child: ShadCard(
            backgroundColor: Colors.black.withValues(alpha: 0.95),
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildErrorText(ansiLog, context),
                  if (stackTrace != null) ...[
                    _buildStackTraceBox(context, stackTrace)
                  ]
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  SelectableText _buildErrorText(String ansiLog, BuildContext context) {
    return SelectableText.rich(
      AnsiText(ansiLog).asTextSpan(),
      textAlign: TextAlign.start,
      style: GoogleFonts.ubuntuMono(
        color: context.colorScheme.mutedForeground,
        fontSize: 14,
      ),
    );
  }

  ShadAccordion<Null> _buildStackTraceBox(
      BuildContext context, String stackTrace) {
    return ShadAccordion<Null>(
      children: [
        ShadAccordionItem(
          value: null,
          separator: SizedBox.shrink(),
          padding: EdgeInsets.only(top: 16.0),
          title: Text("Stack Trace"),
          titleStyle: context.textTheme.muted,
          icon: Icon(
            LucideIcons.chevronDown,
            color: context.colorScheme.mutedForeground,
            size: 16,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SelectableText(
              stackTrace,
              textAlign: TextAlign.start,
              style: context.textTheme.small.copyWith(
                color: context.colorScheme.mutedForeground,
                fontFamily: GoogleFonts.ubuntuMono().fontFamily,
              ),
            ),
          ),
        )
      ],
    );
  }

  Text _buildTitle(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: task.name,
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 16.0),
                  child: task.statusAsWidget(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget? _buildDescription(BuildContext context) {
    final task = this.task;
    if (task is ShellTask) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SelectableText(
              task.fullCommand,
              textAlign: TextAlign.start,
            ),
          ),
          ShadTooltip(
            builder: (context) => Text('Copy Command'),
            child: ShadIconButton.secondary(
              icon: Icon(LucideIcons.copy),
              onPressed: () => _copy(task.fullCommand, context),
              width: 28,
              height: 28,
              padding: EdgeInsets.zero,
              decoration: ShadDecoration(
                  border: ShadBorder(
                radius: BorderRadius.all(Radius.circular(6)),
              )),
            ),
          )
        ],
      );
    }

    return null;
  }

  ShadButton _buildCopyErrorButton(String strippedLog, BuildContext context) {
    return ShadButton(
      size: ShadButtonSize.sm,
      leading: Icon(LucideIcons.copy),
      onPressed: () => _copy(strippedLog, context),
      child: Text("Copy Error"),
    );
  }

  ShadButton _buildCopyStackTraceButton(
      String stackTrace, BuildContext context) {
    return ShadButton.outline(
      size: ShadButtonSize.sm,
      leading: Icon(LucideIcons.copy),
      onPressed: () => _copy(stackTrace, context),
      child: Text("Copy Stack Trace"),
    );
  }

  ShadButton _buildRetryButton(BuildContext context) {
    return ShadButton.link(
      size: ShadButtonSize.sm,
      leading: Icon(LucideIcons.refreshCw),
      onPressed: () => context.taskManager.submitTask(task),
      child: Text("Retry"),
    );
  }

  Future<void> _copy(String text, BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      context.showSonner(
        ShadToast(
          title: Text('Copied'),
        ),
      );
    }
  }
}
