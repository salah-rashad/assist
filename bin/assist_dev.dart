import 'package:chalkdart/chalkstrings.dart';

import '../packages/cli/bin/assist.dart' as assist;

// A copy of packages/cli/bin/assist_dev.dart
// This allows us to use assist during development.
void main(List<String> arguments) async {
  print(' ![DEVELOPMENT MODE] '.black.darkGray);
  print(' ');
  assist.main(arguments);

  // if (arguments.contains('-h') || arguments.contains('--help')) {
  //   print('---------------------------------------------------------');
  //   print('| You are running a local development version of assist. |');
  //   print('---------------------------------------------------------');
  //   print('\n');
  // }
}
