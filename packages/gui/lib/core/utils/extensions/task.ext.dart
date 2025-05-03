import 'package:assist_core/services/task_manager/task_manager.dart';
import 'package:assist_gui/shared/widgets/status_badge.dart';
import 'package:flutter/material.dart';

extension TaskExtension on Task {
  Widget statusAsWidget(BuildContext context) {
    return switch (status) {
      TaskStatus.idle => SizedBox.shrink(),
      TaskStatus.pending => StatusBadge.normal("Pending"),
      TaskStatus.completed => StatusBadge.success(),
      TaskStatus.failed => StatusBadge.error(),
      TaskStatus.cancelled => StatusBadge.error("Cancelled"),
      TaskStatus.running => () {
          return SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              strokeCap: StrokeCap.round,
            ),
          );
        }(),
    };
  }
}
