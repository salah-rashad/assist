import 'package:assist_core/services/task_manager/task_manager.dart';
import 'package:assist_gui/core/utils/extensions/task.ext.dart';
import 'package:flutter/material.dart';

class TaskReportTitle extends StatelessWidget {
  const TaskReportTitle({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: task.name,
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 16.0),
                  child: task.statusAsWidget(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
