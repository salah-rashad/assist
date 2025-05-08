import 'package:assist_core/utils/test_events_parser.dart';
import 'package:assist_gui/core/utils/extensions.dart';
import 'package:assist_gui/core/utils/extensions/duration.ext.dart';
import 'package:assist_gui/core/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TestCaseUnitWidget extends StatelessWidget {
  const TestCaseUnitWidget({super.key, required this.test});

  final TestCaseUnit test;

  bool get isSuccess => test.success;
  bool get isSkipped => test.skipped;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: terminalStyle(context),
      child: Padding(
        padding:
            EdgeInsetsDirectional.only(start: 24.0, end: 24.0, bottom: 8.0),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildName(context),
            if (!isSuccess) _buildDetails(context),
          ],
        ),
      ),
    );
  }

  Widget buildName(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Icon(
          isSkipped
              ? LucideIcons.redoDot
              : isSuccess
                  ? LucideIcons.circleCheck
                  : LucideIcons.circleX,
          color: isSkipped
              ? Colors.white24
              : isSuccess
                  ? context.extendedColors.success
                  : context.colorScheme.destructive,
        ),
        Expanded(
          child: Row(
            children: [
              Text(
                test.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.mutedForeground,
                ),
              ),
              const Spacer(),
              Text(
                test.duration.toDurationString(),
                style: TextStyle(
                  color: Colors.white24,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (test.error != null)
            Text(
              test.error.toString(),
              textAlign: TextAlign.start,
              style: TextStyle(color: context.colorScheme.destructive),
            ),
          if (test.stackTrace != null)
            Text(
              test.stackTrace.toString(),
              textAlign: TextAlign.start,
              style: TextStyle(
                  color:
                      context.colorScheme.destructive.withValues(alpha: 0.6)),
            ),
        ],
      ),
    );
  }
}
