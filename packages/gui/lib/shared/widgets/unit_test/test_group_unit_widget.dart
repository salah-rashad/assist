import 'package:assist_core/utils/test_events_parser.dart';
import 'package:assist_gui/core/utils/extensions.dart';
import 'package:assist_gui/shared/widgets/unit_test/test_case_unit_widget.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TestGroupUnitWidget extends StatelessWidget {
  const TestGroupUnitWidget({super.key, required this.group});

  final TestGroupUnit group;

  @override
  Widget build(BuildContext context) {
    final tests = getTestsInExactGroup(
      groupId: group.id,
      allTests: group.tests,
    );

    if (tests.isEmpty) {
      return SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildGroupName(context),
          ShadSeparator.horizontal(
            margin: EdgeInsets.symmetric(horizontal: 24),
            color: Colors.white.withValues(alpha: 0.05),
          ),
          for (final test in tests) TestCaseUnitWidget(test: test),
        ],
      ),
    );
  }

  Widget buildGroupName(BuildContext context) {
    final groupName = group.name ?? '';

    return SelectionContainer.disabled(
      child: Row(
        children: [
          Icon(
            LucideIcons.arrowBigRightDash,
            size: 16,
            color: context.colorScheme.secondaryForeground,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              groupName,
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: context.textTheme.small.apply(
                color: context.colorScheme.secondaryForeground,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<TestCaseUnit> getTestsInExactGroup({
    required int groupId,
    required List<TestCaseUnit> allTests,
  }) {
    return allTests.where((test) {
      return test.groupIDs.isNotEmpty && test.groupIDs.last == groupId;
    }).toList();
  }
}
