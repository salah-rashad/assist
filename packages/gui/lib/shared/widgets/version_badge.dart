import 'package:assist_core/assist_core.dart';
import 'package:assist_gui/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class VersionBadge extends StatelessWidget {
  const VersionBadge({super.key, required this.version});

  final Version version;

  @override
  Widget build(BuildContext context) {
    // final isMajor = version.major > 0;
    // final isMinor = version.minor > 0 && version.major == 0;
    // final isPatch =
    //     version.patch > 0 && version.major == 0 && version.minor == 0;
    //
    // Color color;
    // if (isMajor) {
    //   color = context.colorScheme.primary;
    // } else if (isMinor) {
    //   color = Colors.orange;
    // } else {
    //   color = context.colorScheme.destructive;
    // }

    final color = context.colorScheme.mutedForeground;

    return ShadBadge.raw(
      variant: ShadBadgeVariant.outline,
      foregroundColor: color,
      backgroundColor: color.withValues(alpha: 0.2),
      shape: StadiumBorder(
        side: BorderSide(color: color.withValues(alpha: 0.8)),
      ),
      child: Text('v $version'),
    );
  }
}
