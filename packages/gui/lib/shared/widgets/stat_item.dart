import 'package:assist_gui/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class StatItem extends StatelessWidget {
  const StatItem({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    this.color,
  });

  final String label;
  final IconData icon;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ShadCard(
        backgroundColor: context.colorScheme.foreground.withValues(alpha: 0.03),
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Icon(
              icon,
              size: 16,
              color: color ?? context.colorScheme.secondaryForeground,
            ),
            Text(
              value,
              maxLines: 1,
              style: context.textTheme.h2,
            ),
            Text(
              label,
              maxLines: 1,
              style: context.textTheme.small,
            ),
          ],
        ),
      ),
    );
  }
}
