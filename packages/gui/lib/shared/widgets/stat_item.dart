import 'package:assist_gui/core/utils/extensions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class StatItem extends StatelessWidget {
  const StatItem({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    this.fgColor,
    this.bgColor,
  });

  final String label;
  final IconData icon;
  final String value;
  final Color? fgColor;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    final bgColor =
        this.bgColor ?? context.colorScheme.foreground.withValues(alpha: 0.03);
    final fgColor = this.fgColor ?? context.colorScheme.secondaryForeground;

    return Expanded(
      child: AspectRatio(
        aspectRatio: 1 / 1.2,
        child: ShadCard(
          backgroundColor: bgColor,
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Icon(
                icon,
                size: 16,
                color: fgColor.withValues(alpha: 0.7),
              ),
              Spacer(),
              AutoSizeText(
                value,
                maxLines: 1,
                style: context.textTheme.h2.apply(color: fgColor),
                minFontSize: 18,
              ),
              Text(
                label,
                maxLines: 1,
                style: context.textTheme.small.apply(color: fgColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
