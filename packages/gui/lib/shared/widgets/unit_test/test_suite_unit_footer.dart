import 'package:assist_core/utils/test_events_parser.dart';
import 'package:assist_gui/core/utils/extensions.dart';
import 'package:assist_gui/core/utils/helpers.dart';
import 'package:assist_gui/shared/widgets/link_text/link_text.dart';
import 'package:assist_gui/shared/widgets/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TestSuiteUnitFooter extends StatelessWidget {
  const TestSuiteUnitFooter({super.key, required this.suite});

  final TestSuiteUnit suite;

  String get path => suite.path;

  @override
  Widget build(BuildContext context) {
    final tests = suite.tests..retainWhere((t) => !t.hidden);
    final testCount = tests.length;
    final succeeded = suite.tests.where((test) => test.success == true).length;

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        spacing: 8,
        children: [
          Expanded(
            child: OverflowBar(
              spacing: 22.0,
              alignment: MainAxisAlignment.start,
              children: [
                // LinkText(
                //   "Rerun",
                //   icon: Icon(LucideIcons.refreshCw, size: 14),
                //   onTap: runTask,
                //   style: TextStyle(fontSize: 14),
                // ),
                LinkText(
                  'Open File',
                  icon: Icon(LucideIcons.externalLink, size: 14),
                  onTap: () => _openFile(context),
                  style: TextStyle(fontSize: 14),
                ),
                LinkText(
                  'Copy Path',
                  icon: Icon(LucideIcons.copy, size: 14),
                  onTap: () => copyAndToast(path, context),
                  style: TextStyle(fontSize: 14),
                  showIcon: true,
                ),
              ],
            ),
          ),
          StatusBadge.customColor(
              label: '$succeeded/$testCount',
              customColor: suite.isSucceeded
                  ? context.extendedColors.success
                  : context.colorScheme.destructive)
        ],
      ),
    );
  }

  void _openFile(BuildContext context) {
    final absolutePath = p.join(context.project.path, path);
    launchUrlString('file://$absolutePath');
  }
}
