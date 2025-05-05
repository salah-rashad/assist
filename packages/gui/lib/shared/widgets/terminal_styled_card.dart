import 'package:assist_gui/app/themes/app_theme.dart';
import 'package:assist_gui/core/utils/extensions.dart';
import 'package:assist_gui/core/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TerminalStyledCard extends StatelessWidget {
  const TerminalStyledCard({
    super.key,
    required this.child,
    required this.stackTrace,
  });

  final Widget child;
  final Widget? stackTrace;

  @override
  Widget build(BuildContext context) {
    return ShadTheme(
      data: AppTheme.dark.themeData(),
      child: ShadCard(
        backgroundColor: Colors.black.withValues(alpha: 0.95),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: SelectionArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: terminalStyle(context),
                  textAlign: TextAlign.start,
                  child: child,
                ),
                if (stackTrace != null) ...[
                  _buildStackTraceBox(context, stackTrace)
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStackTraceBox(BuildContext context, Widget? stackTrace) {
    if (stackTrace == null) return SizedBox.shrink();
    return ShadAccordion<Null>(
      children: [
        ShadAccordionItem(
          value: null,
          separator: SizedBox.shrink(),
          padding: EdgeInsets.only(top: 16.0),
          title: SelectionContainer.disabled(child: Text('Stack Trace')),
          titleStyle: context.textTheme.muted,
          icon: Icon(
            LucideIcons.chevronDown,
            color: context.colorScheme.mutedForeground,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: DefaultTextStyle(
              style: context.textTheme.small.copyWith(
                color: context.colorScheme.mutedForeground,
                fontFamily: terminalStyle(context).fontFamily,
              ),
              child: stackTrace,
            ),
          ),
        )
      ],
    );
  }
}
