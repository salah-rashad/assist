import 'package:assist_core/assist_core.dart';
import 'package:assist_gui/core/utils/extensions.dart';
import 'package:assist_gui/shared/widgets/status_badge.dart';
import 'package:flutter/material.dart';

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

    return StatusBadge.normal("v $version");
  }
}
