import 'package:assist_core/utils/test_events_parser.dart';
import 'package:assist_gui/core/utils/extensions/duration.ext.dart';
import 'package:assist_gui/shared/widgets/stat_item.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TestReportStats extends StatelessWidget {
  const TestReportStats({super.key, required this.report});

  final TestReport report;

  @override
  Widget build(BuildContext context) {
    final duration = report.totalDuration;
    final totalTests = report.totalTests;
    final totalPasses = report.totalPasses;
    final totalFailures = report.totalFailures;
    final totalSkipped = report.totalSkipped;

    return Row(
      spacing: 8.0,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatItem(
          label: 'Duration',
          icon: LucideIcons.clock,
          value: Duration(milliseconds: duration).toDurationString(),
        ),
        StatItem(
          label: 'Tests',
          icon: LucideIcons.flaskConical,
          value: totalTests.toString(),
        ),
        StatItem(
          label: 'Passed',
          icon: LucideIcons.check,
          value: totalPasses.toString(),
        ),
        StatItem(
          label: 'Failed',
          icon: LucideIcons.x,
          value: totalFailures.toString(),
        ),
        StatItem(
          label: 'Skipped',
          icon: LucideIcons.redoDot,
          value: totalSkipped.toString(),
        ),
      ],
    );
  }
}
