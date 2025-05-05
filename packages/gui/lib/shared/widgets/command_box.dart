import 'package:assist_gui/core/utils/extensions.dart';
import 'package:assist_gui/core/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CommandBox extends StatelessWidget {
  const CommandBox({super.key, required this.command});

  final String command;

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      backgroundColor: context.colorScheme.foreground.withValues(alpha: 0.03),
      padding: EdgeInsets.only(left: 12.0, top: 4.0, bottom: 4.0),
      child: Row(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SelectableText(
              command,
              textAlign: TextAlign.start,
              style: terminalStyle(context),
            ),
          ),
          ShadTooltip(
            builder: (context) => Text('Copy Command'),
            child: ShadIconButton.ghost(
              width: 28,
              height: 28,
              foregroundColor: context.colorScheme.mutedForeground,
              padding: EdgeInsets.zero,
              icon: Icon(LucideIcons.copy),
              decoration: ShadDecoration(
                border: ShadBorder(
                  radius: BorderRadius.all(Radius.circular(6)),
                ),
              ),
              onPressed: () => copyAndToast(command, context),
            ),
          )
        ],
      ),
    );
  }
}
