import 'package:assist_core/assist_core.dart';
import 'package:assist_gui/shared/widgets/status_badge.dart';
import 'package:flutter/material.dart';

class VersionBadge extends StatelessWidget {
  const VersionBadge({super.key, required this.version});

  final Version version;

  @override
  Widget build(BuildContext context) {
    final label = 'v $version';

    // final isMajor = version.major > 0;
    // final isMinor = version.minor > 0 && version.major == 0;
    // final isPatch =
    //     version.patch > 0 && version.major == 0 && version.minor == 0;

    // if (isMajor) {
    //   return StatusBadge.info(label);
    // } else if (isMinor) {
    //   return StatusBadge.warning(label);
    // } else {
    //   return StatusBadge.error(label);
    // }

    return StatusBadge.normal(label);
  }
}
