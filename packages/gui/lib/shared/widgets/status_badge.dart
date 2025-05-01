import 'package:assist_gui/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

enum StatusBadgeType { normal, success, error, warning, info }

class StatusBadge extends StatelessWidget {
  const StatusBadge._({required this.label, required this.type});

  factory StatusBadge.normal(Widget label) =>
      StatusBadge._(label: label, type: StatusBadgeType.normal);

  factory StatusBadge.success(Widget label) =>
      StatusBadge._(label: label, type: StatusBadgeType.success);

  factory StatusBadge.error(Widget label) =>
      StatusBadge._(label: label, type: StatusBadgeType.error);

  factory StatusBadge.warning(Widget label) =>
      StatusBadge._(label: label, type: StatusBadgeType.warning);

  factory StatusBadge.info(Widget label) =>
      StatusBadge._(label: label, type: StatusBadgeType.info);

  final Widget label;
  final StatusBadgeType type;

  @override
  Widget build(BuildContext context) {
    Color color = mapStatusToColor(type, context);
    return ShadBadge.outline(
      foregroundColor: color,
      backgroundColor: color.withValues(alpha: 0.2),
      hoverBackgroundColor: color.withValues(alpha: 0.2),
      shape: StadiumBorder(
        side: BorderSide(color: color.withValues(alpha: 0.8)),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          height: context.textTheme.small.fontSize,
        ),
        child: label,
      ),
    );
  }

  Color mapStatusToColor(StatusBadgeType type, BuildContext context) {
    return switch (type) {
      StatusBadgeType.normal => context.colorScheme.mutedForeground,
      StatusBadgeType.success => context.extendedColors.success,
      StatusBadgeType.error => context.colorScheme.destructive,
      StatusBadgeType.warning => context.extendedColors.warning,
      StatusBadgeType.info => context.extendedColors.info,
    };
  }
}
