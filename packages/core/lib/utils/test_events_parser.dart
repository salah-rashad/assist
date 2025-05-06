import 'package:collection/collection.dart';
import 'package:test_report_parser/test_report_parser.dart';

class TestReport {
  final String json;
  final List<TestSuiteUnit> suites;
  final bool success;
  final int totalDuration;
  final int totalTests;
  final int totalPasses;
  final int totalFailures;
  final int totalSkipped;

  int? get firstFailedSuite =>
      suites.firstWhereOrNull((suite) => !suite.isSucceeded)?.id;

  TestReport({
    required this.json,
    required this.suites,
    required this.success,
    required this.totalDuration,
    required this.totalTests,
    required this.totalPasses,
    required this.totalFailures,
    required this.totalSkipped,
  });

  factory TestReport.empty() => TestReport(
        json: '',
        suites: [],
        success: true,
        totalDuration: 0,
        totalTests: 0,
        totalPasses: 0,
        totalFailures: 0,
        totalSkipped: 0,
      );
}

class TestSuiteUnit {
  final int id;
  final String path;
  final String platform;
  final List<TestGroupUnit> groups;
  final List<TestCaseUnit> tests;
  final bool isLoadFailure;
  final String? loadErrorMessage;

  bool get isSucceeded => tests.every((test) => test.success);

  TestSuiteUnit({
    required this.id,
    required this.path,
    required this.platform,
    required this.groups,
    required this.tests,
    required this.isLoadFailure,
    required this.loadErrorMessage,
  });
}

class TestGroupUnit {
  final int id;
  final String? name;
  final int? parentID;
  final List<TestCaseUnit> tests;

  TestGroupUnit({
    required this.id,
    this.name,
    this.parentID,
    required this.tests,
  });

  TestGroupUnit copyWith({
    int? id,
    String? name,
    int? parentID,
    List<TestCaseUnit>? tests,
  }) {
    return TestGroupUnit(
      id: id ?? this.id,
      name: name ?? this.name,
      parentID: parentID ?? this.parentID,
      tests: tests ?? this.tests,
    );
  }
}

class TestCaseUnit {
  final int id;
  final String name;
  final int suiteID;
  final List<int> groupIDs;
  final Duration duration;
  final bool skipped;
  final bool success;
  final String? error;
  final String? stackTrace;
  final bool hidden;

  TestCaseUnit({
    required this.id,
    required this.name,
    required this.suiteID,
    required this.groupIDs,
    required this.duration,
    required this.skipped,
    required this.success,
    required this.hidden,
    this.error,
    this.stackTrace,
  });
}

class TestEventsParser {
  static TestReport parse(List<Event> events, {String json = ''}) {
    final suites = <int, TestSuiteUnit>{};
    final groups = <int, TestGroupUnit>{};
    final tests = <int, TestCaseUnit>{};
    final testStartTimes = <int, int>{};
    final testErrors = <int, Map<String, String?>>{};
    int totalTime = 0;
    bool overallSuccess = true;

    for (final event in events) {
      if (event is SuiteEvent) {
        suites[event.suite.id] = TestSuiteUnit(
          id: event.suite.id,
          path: event.suite.path ?? '',
          platform: event.suite.platform,
          groups: [],
          tests: [],
          isLoadFailure: false, // filled in later
          loadErrorMessage: null, // filled in later
        );
      } else if (event is GroupEvent) {
        groups[event.group.id] = TestGroupUnit(
          id: event.group.id,
          name: _getBaseGroupName(event.group, groups),
          parentID: event.group.parentID,
          tests: [],
        );
      } else if (event is TestStartEvent) {
        testStartTimes[event.test.id] = event.time;
        tests[event.test.id] = TestCaseUnit(
          id: event.test.id,
          name: event.test.name,
          suiteID: event.test.suiteID,
          groupIDs: event.test.groupIDs,
          duration: Duration.zero, // filled in later
          skipped: event.test.metadata.skip,
          success: false, // filled in later
          hidden: false, // filled in later
        );
      } else if (event is ErrorEvent) {
        testErrors[event.testID] = {
          'error': event.error,
          'stack': event.stackTrace,
        };
      } else if (event is TestDoneEvent) {
        final test = tests[event.testID];
        if (test != null) {
          final startTime = testStartTimes[event.testID] ?? 0;
          final duration = Duration(milliseconds: event.time - startTime);
          final err = testErrors[event.testID];

          final updatedTest = TestCaseUnit(
            id: test.id,
            name: _getBaseTestName(test, groups),
            suiteID: test.suiteID,
            groupIDs: test.groupIDs,
            duration: duration,
            skipped: event.skipped,
            success: event.result == 'success',
            hidden: event.hidden,
            error: err?['error'],
            stackTrace: err?['stack'],
          );

          tests[event.testID] = updatedTest;
          suites[test.suiteID]?.tests.add(updatedTest);

          int? lastGroupId = updatedTest.groupIDs.lastOrNull;
          if (lastGroupId != null) {
            groups[lastGroupId]?.tests.add(updatedTest);
          }

          // for (final groupId in test.groupIDs) {
          //   groups[groupId]?.tests.add(updatedTest);
          // }

          totalTime = event.time;
          if (event.result != 'success') overallSuccess = false;
        }
      } else if (event is DoneEvent) {
        overallSuccess = event.success ?? false;
      }
    }

    _applyTweaks(suites, groups, tests);

    // attach groups to their suites
    for (final group in groups.values) {
      final suiteID = tests.values
          .firstWhereOrNull((t) => t.groupIDs.contains(group.id))
          ?.suiteID;
      if (suiteID != null) {
        suites[suiteID]?.groups.add(group);
      }
    }

    return TestReport(
      json: json,
      suites: suites.values.toList(),
      success: overallSuccess,
      totalDuration: totalTime,
      totalTests: tests.length,
      totalPasses: tests.values.where((t) => t.success).length,
      totalFailures: tests.values.where((t) => !t.success).length,
      totalSkipped: tests.values.where((t) => t.skipped).length,
    );
  }

  static void _applyTweaks(Map<int, TestSuiteUnit> suites,
      Map<int, TestGroupUnit> groups, Map<int, TestCaseUnit> tests) {
    // Add load error message to failed suites
    for (final suite in suites.values) {
      bool isLoadingTest(TestCaseUnit t) => t.name.startsWith('loading ');

      final loadTest = suite.tests.firstWhereOrNull(
        (t) => isLoadingTest(t) && t.error != null,
      );

      final hasGroups = suite.groups.isNotEmpty;
      final hasTests = suite.tests.where((t) => !isLoadingTest(t)).isNotEmpty;

      if (loadTest != null && !hasGroups && !hasTests) {
        suites[suite.id] = TestSuiteUnit(
          id: suite.id,
          path: suite.path,
          platform: suite.platform,
          groups: suite.groups,
          tests: suite.tests,
          isLoadFailure: true,
          loadErrorMessage:
              loadTest.error ?? 'Unknown error while loading suite.',
        );
      }
    }

    // Remove hidden tests like "loading" tests
    tests.removeWhere((key, value) => value.hidden);

    // update root group's name
    groups.updateAll(
      (key, value) {
        if (value.parentID == null) {
          return value.copyWith(name: 'Root');
        }

        return value;
      },
    );

    // remove empty groups
    groups.removeWhere((key, value) => value.tests.isEmpty);
  }
}

String _getBaseTestName(TestCaseUnit test, Map<int, TestGroupUnit> groups) {
  if (test.groupIDs.isEmpty) return test.name;

  // Build full group path
  final groupParts = test.groupIDs
      .map((id) => groups[id]?.name ?? '')
      .join(' ')
      .split(' ')
      .where((s) => s.isNotEmpty)
      .toList();

  final nameParts = test.name.split(' ');

  // Skip prefix from name
  final baseParts = _skipPrefix(nameParts, groupParts);

  return baseParts.join(' ').trim();
}

String _getBaseGroupName(Group group, Map<int, TestGroupUnit> groups) {
  String fullPrefix = '';
  int? current = group.parentID;

  while (current != null) {
    final parent = groups[current];
    if (parent == null) break;
    fullPrefix = '${parent.name} $fullPrefix';
    current = parent.parentID;
  }

  final name = group.name.trim();
  final prefix = fullPrefix.trim();

  if (prefix.isNotEmpty && name.startsWith('$prefix ')) {
    return name.substring(prefix.length).trim();
  }

  return name;
}

List<String> _skipPrefix(List<String> full, List<String> prefix) {
  if (prefix.length > full.length) return full;

  for (int i = 0; i < prefix.length; i++) {
    if (full[i] != prefix[i]) return full;
  }

  return full.sublist(prefix.length);
}
