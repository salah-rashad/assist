import 'package:assist_gui/core/utils/extensions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuickActionButton extends StatelessWidget {
  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final Widget icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ShadButton.outline(
      onPressed: onPressed,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      backgroundColor: context.colorScheme.cardForeground.withValues(
        alpha: 0.05,
      ),
      hoverBackgroundColor: context.colorScheme.cardForeground.withValues(
        alpha: 0.1,
      ),
      leading: IconTheme(
        data: IconThemeData(size: 18, color: context.colorScheme.primary),
        child: icon,
      ),
      gap: 12,
      trailing: Icon(
        LucideIcons.chevronRight,
        size: 18,
        color: context.colorScheme.cardForeground.withValues(alpha: 0.3),
      ),
      child: Expanded(
        child: AutoSizeText(
          label,
          maxLines: 1,
          style: context.textTheme.list,
          minFontSize: context.textTheme.small.fontSize ?? 14,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
