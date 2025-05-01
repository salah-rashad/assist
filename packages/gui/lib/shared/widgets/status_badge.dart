import 'package:assist_gui/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

const _success = LucideIcons.check;
const _error = LucideIcons.x;
const _warning = LucideIcons.triangleAlert;
const _info = LucideIcons.info;

enum StatusBadgeType { normal, success, error, warning, info }

/// A badge that displays a status.
///
/// - [type] can be:
///   - [StatusBadge.normal] displays a normal badge.
///   - [StatusBadge.success] displays a success badge.
///   - [StatusBadge.error] displays an error badge.
///   - [StatusBadge.warning] displays a warning badge.
///   - [StatusBadge.info] displays an info badge.
///
/// - [label] can be a [Widget], [String], or [IconData].
class StatusBadge extends StatelessWidget {
  const StatusBadge._({required this.label, required this.type})
      : customColor = null,
        assert(label != null),
        assert(label is Widget || label is String || label is IconData);

  const StatusBadge.customColor(
      {super.key, required this.label, required this.customColor})
      : type = StatusBadgeType.normal,
        assert(label != null),
        assert(label is Widget || label is String || label is IconData);

  factory StatusBadge.normal(label) =>
      StatusBadge._(label: label, type: StatusBadgeType.normal);

  factory StatusBadge.success([label]) =>
      StatusBadge._(label: label ?? _success, type: StatusBadgeType.success);

  factory StatusBadge.error([label]) =>
      StatusBadge._(label: label ?? _error, type: StatusBadgeType.error);

  factory StatusBadge.warning([label]) =>
      StatusBadge._(label: label ?? _warning, type: StatusBadgeType.warning);

  factory StatusBadge.info([label]) =>
      StatusBadge._(label: label ?? _info, type: StatusBadgeType.info);

  final dynamic label;
  final StatusBadgeType type;
  final Color? customColor;

  @override
  Widget build(BuildContext context) {
    var label_ = label;

    if (label is Widget) {
      label_ = label;
    } else if (label is String) {
      label_ = Text(label);
    } else if (label is IconData) {
      label_ = Icon(label);
    }

    final color = customColor ?? mapStatusToColor(type, context);
    return ShadBadge.outline(
      foregroundColor: color,
      backgroundColor: color.withValues(alpha: 0.2),
      hoverBackgroundColor: color.withValues(alpha: 0.2),
      shape: StadiumBorder(
        side: BorderSide(color: color.withValues(alpha: 0.8)),
      ),
      child: IconTheme(
        data:
            IconThemeData(size: context.textTheme.small.fontSize, color: color),
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(
            height: context.textTheme.small.fontSize,
          ),
          child: label_,
        ),
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
