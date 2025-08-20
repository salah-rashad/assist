import 'package:assist_gui/app/themes/app_theme.dart';
import 'package:assist_gui/core/utils/extensions.dart';
import 'package:assist_gui/core/utils/helpers.dart';
import 'package:assist_gui/shared/widgets/ansi_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TerminalStyledCard extends StatelessWidget {
  const TerminalStyledCard({
    super.key,
    required this.child,
    this.stackTrace,
    this.isError = false,
  })  : _isAnsi = false,
        _ansiiOutput = '';

  TerminalStyledCard.ansii({
    required String output,
    this.isError = false,
    required String? stackTrace,
  })  : _isAnsi = true,
        _ansiiOutput = output,
        child = SizedBox.shrink(),
        stackTrace = stackTrace == null ? null : Text(stackTrace);

  final Widget child;
  final Widget? stackTrace;

  final bool _isAnsi;
  final String _ansiiOutput;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return ShadTheme(
      data: AppTheme.dark.themeData(),
      child: Builder(builder: (context) {
        return ShadCard(
          backgroundColor: Colors.black.withValues(alpha: 0.95),
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 120),
            child: SelectionArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 16,
                children: [
                  DefaultTextStyle(
                    style: terminalStyle(context).apply(
                      color: isError ? context.colorScheme.destructive : null,
                    ),
                    textAlign: TextAlign.start,
                    child: _buildChild(context),
                  ),
                  if (stackTrace != null) ...[
                    _buildStackTraceBox(context, stackTrace)
                  ]
                ],
              ),
            ),
          ),
        );
      }),
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

  Widget _buildChild(BuildContext context) {
    if (_isAnsi) {
      return Text.rich(
        AnsiText(_ansiiOutput).asTextSpan(),
      );
    } else {
      return child;
    }
  }
}
